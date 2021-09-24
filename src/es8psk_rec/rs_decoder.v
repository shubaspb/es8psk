
module rs_decoder
   (input               clk,
    input               reset_b,
    input       [323:0] din,
    input               ena_in,
    output reg  [203:0] dout,
    output reg          ena_out,
    output              fail_data,
    output      [67:0]  tst
    );

wire reset_b_dec = ~ena_in;

//////////////// form symbols stream /////////////////////////////////
reg [7:0] cnt;
always @(posedge clk, negedge reset_b)
    if(~reset_b) begin
        cnt <= 8'hff;
    end else begin
        if (ena_in)
            cnt <= 8'd0;
        else
            cnt <= cnt + ~&cnt;
    end

reg [323:0] dinr;
always @(posedge clk, negedge reset_b)
    if(~reset_b) begin
        dinr <= 324'd0;
    end else begin
        if (ena_in)
            dinr <= din;
        else
            dinr <= dinr;
    end

reg [5:0] symbol;
always @(posedge clk, negedge reset_b)
    if(~reset_b) begin
        symbol <= 6'd0;
    end else begin
        if ((cnt>=8'd0)&(cnt<=8'd53)) begin
            symbol <= {dinr[cnt*2+0], dinr[cnt*2+108], dinr[cnt*2+216], dinr[cnt*2+1], dinr[cnt*2+109], dinr[cnt*2+217]};
        end else begin
            symbol <= 6'd0;
        end
    end

reg dec_in_valid;
reg start_packet;
reg end_packet;
reg end_packet_reg;
always @(posedge clk, negedge reset_b)
    if(~reset_b) begin
        dec_in_valid <= 1'b0;
        start_packet <= 1'b0;
        end_packet <= 1'b0;
        end_packet_reg <= 1'b0;
    end else begin
        dec_in_valid <= (cnt>=8'd0)&(cnt<=8'd200);
        start_packet <= (cnt==8'd0);
        end_packet   <= (cnt==8'd53);
        end_packet_reg <= end_packet;
    end

wire [5:0] dec_out_data;
wire dec_out_startofpacket;
wire [5:0]   errorNum;       // number of errors corrected
wire [5:0]   erasureNum;     // number of erasure corrected
wire         fail;           // decoding failure signal
wire [5:0]   delayedData;    // delayed input data

RsDecodeTop RsDecodeTop_inst(
    .CLK        (clk            ),
    .RESET      (reset_b_dec    ),
    .enable     (reset_b_dec    ),
    .startPls   (start_packet   ),
    .erasureIn  (1'b0           ),
    .dataIn     (symbol         ),
    .outStartPls(dec_out_startofpacket),
    .outData    (dec_out_data   ),
    .errorNum   (errorNum       ),
    .erasureNum (erasureNum     ),
    .fail       (fail           ),
    .delayedData(delayedData    )
);

reg [7:0] rcnt;
reg [5:0] dec_out_data_reg;
always @(posedge clk, negedge reset_b)
    if(~reset_b) begin
        rcnt <= 8'hff;
        dec_out_data_reg <= 6'd0;
    end else begin
        if (dec_out_startofpacket)
            rcnt <= 8'd0;
        else
            rcnt <= rcnt + ~&rcnt;
        dec_out_data_reg <= dec_out_data;
    end

reg [323:0] dint;
always @(posedge clk, negedge reset_b)
    if(~reset_b) begin
        dint <= 336'd0;
    end else begin
        if ((rcnt>=8'd0)&(rcnt<=8'd33))
            {dint[rcnt*2+0], dint[rcnt*2+108], dint[rcnt*2+216], dint[rcnt*2+1], dint[rcnt*2+109], dint[rcnt*2+217]} <= dec_out_data_reg;
        else if (rcnt==8'd36)
            dint <= 336'd0;
        else
            dint <= dint;
    end

always @(posedge clk, negedge reset_b)
    if(~reset_b) begin
        dout <= 204'd0;
        ena_out <= 1'b0;
    end else begin
        if (rcnt==8'd35) begin
            dout <= {dint[283:216], dint[175:108], dint[67:0]};
            ena_out <= 1'b1;
        end else begin
            dout <= dout;
            ena_out <= 1'b0;
        end
    end

reg	fail0, fail1;
reg set_fail;
always @(posedge clk, negedge reset_b)
    if(~reset_b) begin
        {fail0, fail1} <= 2'd0;
        set_fail <= 1'b0;
    end else begin
        {fail0, fail1} <= {fail, fail0};
        set_fail <= (~fail1) & fail0;
    end
assign fail_data = fail;

reg [15:0] kcnt;
always @(posedge clk, negedge reset_b)
    if(~reset_b) begin
        kcnt <= 16'd0;
    end else begin
        if (set_fail)
            kcnt <= kcnt + 16'd1;
        else
            kcnt <= kcnt;
    end

endmodule