
module rs_encoder
   (input               clk,
    input               reset_b,
    input       [203:0] din,
    input               ena_in,
    output reg  [323:0] dout,
    output reg          ena_out,
    output      [67:0]  tst
    );

    wire reset_b_dec = ~ena_in;

//////////////// form symbols stream /////////////////////////////////
    reg	[7:0] cnt;
    always @(posedge clk, negedge reset_b)
        if(~reset_b) begin
            cnt <= 8'hff;
        end else begin
            if (ena_in)
                cnt <= 8'd0;
            else
                cnt <= cnt + ~&cnt;
        end
    wire [7:0] cntp = cnt;

    reg [5:0] symbol;
    always @(posedge clk, negedge reset_b) begin
        if(~reset_b) begin
            symbol <= 6'd0;
        end else begin
            if ((cnt>=8'd0)&(cnt<=8'd33)) begin
                symbol <= {din[cnt*2+0], din[cnt*2+68], din[cnt*2+136], din[cnt*2+1], din[cnt*2+69], din[cnt*2+137]};
            end else begin
                symbol <= 6'd0;
            end
        end
    end

    reg start_packet;
    reg end_packet;
    always @(posedge clk, negedge reset_b) begin
        if(~reset_b) begin
            start_packet <= 1'b0;
            end_packet <= 1'b0;
        end else begin
            start_packet <= (cnt==8'd0);
            end_packet <= (cnt==8'd33);
        end
    end

    wire [5:0] enc_out_data;
    RsEncodeTop RsEncodeTop_inst(
       .CLK		(clk            ),
       .RESET	(reset_b        ),
       .enable	(reset_b        ),
       .startPls(start_packet   ),
       .dataIn	(symbol         ),
       .dataOut (enc_out_data   )
    );

    reg start_packet_reg;
    reg enc_out_startofpacket;
    always @(posedge clk, negedge reset_b) begin
        if(~reset_b) begin
            start_packet_reg <= 1'b0;
            enc_out_startofpacket <= 1'b0;
        end else begin
            start_packet_reg <= start_packet;
            enc_out_startofpacket <= start_packet_reg;
        end
    end

    reg	[7:0] rcnt;
    reg [5:0] enc_out_data_reg;
    always @(posedge clk, negedge reset_b)
        if(~reset_b) begin
            rcnt <= 8'hff;
            enc_out_data_reg <= 6'd0;
        end else begin
            if (enc_out_startofpacket)
                rcnt <= 8'd0;
            else
                rcnt <= rcnt + ~&rcnt;
            enc_out_data_reg <= enc_out_data;
        end

    reg [323:0] dint;
    always @(posedge clk, negedge reset_b) begin
        if(~reset_b) begin
            dint <= 324'd0;
        end else begin
            if ((rcnt>=8'd0)&(rcnt<=8'd53))
                {dint[rcnt*2+0], dint[rcnt*2+108], dint[rcnt*2+216], dint[rcnt*2+1], dint[rcnt*2+109], dint[rcnt*2+217]} <= enc_out_data_reg;
            else if (rcnt==8'd56) begin
                dint <= 324'd0;
            end else begin
                dint <= dint;
            end
        end
    end

    always @(posedge clk, negedge reset_b) begin
        if(~reset_b) begin
            dout <= 324'd0;
            ena_out <= 1'b0;
        end else begin
            if (rcnt==8'd55) begin
                dout <= dint;
                ena_out <= 1'b1;
            end else begin
                dout <= dout;
                ena_out <= 1'b0;
            end
        end
    end

    endmodule