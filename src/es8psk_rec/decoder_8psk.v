
module decoder_8psk
   (input               clk,
    input               reset_b,
    input               new_message,
    input       [2:0]   symbol,
    input               ena,
    input       [31:0]  err_reg,
    output reg  [203:0] data_8psk,
    output              ena_data,
    output              fail_data
    );

reg new_message_reg;
always @(posedge clk, negedge reset_b)
    if(~reset_b)
        new_message_reg <= 1'd0;
    else
        new_message_reg <= new_message;
wire new_message_str = (~new_message_reg) & new_message;
wire new_message_end = (~new_message) & new_message_reg;

reg [7:0] cnt;
always @(posedge clk, negedge reset_b) begin
    if(~reset_b) begin
        cnt <= 8'hff;
    end else begin
        if (new_message_str)
            cnt <= 8'd0;
        else if (ena)
            cnt <= cnt + 8'd1;
        else
            cnt <= cnt;
    end
end

wire [7:0] index_data = 67-cnt+4;
wire [7:0] index_par = 39-cnt+72;
reg [67:0] data0, data1, data2;
reg [39:0] parity0, parity1, parity2;
always @(posedge clk, negedge reset_b) begin
    if(~reset_b) begin
        data0[67:0] <= 68'd0;
        data1[67:0] <= 68'd0;
        data2[67:0] <= 68'd0;
        parity0[39:0] <= 40'd0;
        parity1[39:0] <= 40'd0;
        parity2[39:0] <= 40'd0;
    end else begin
        if (ena) begin
            if ((cnt>=8'd4)&(cnt<=8'd71)) begin
                data0[index_data] <= symbol[0];
                data1[index_data] <= symbol[1];
                data2[index_data] <= symbol[2];
            end else if ((cnt>=8'd72)&(cnt<=8'd111)) begin
                parity0[index_par] <= symbol[0];
                parity1[index_par] <= symbol[1];
                parity2[index_par] <= symbol[2];
            end
        end
    end
end

//////////////// Read-Solomon decoder /////////////////////////////////////////////////////////////////////////////
//wire ena_in_dec = (cnt==8'd112);
reg ena_in_dec, ena_in_dec_reg;
reg [7:0] cnt_reg;
always @(posedge clk, negedge reset_b)
    if (~reset_b) begin
        cnt_reg <= 8'd0;
        ena_in_dec <= 1'b0;
        ena_in_dec_reg <= 1'b0;
    end else begin
        cnt_reg <= cnt;
        ena_in_dec <= new_message_end;
        ena_in_dec_reg <= ena_in_dec;
    end

wire [323:0] din_dec ={
    parity0[39:0],
    data0[67:0],
    parity1[39:0],
    data1[67:0],
    parity2[39:0],
    data2[67:0]
};

wire [323:0] error_vec = {err_reg[31:0], err_reg[31:0], err_reg[31:0], err_reg[31:0],  err_reg[31:0], err_reg[31:0], err_reg[31:0], err_reg[31:0], err_reg[31:0], err_reg[31:0], 4'd0};
wire [323:0] din_dec_err = din_dec; // ^ error_vec;

wire [203:0] dout_dec   ; // = {data0, data1, data2};
wire ena_out_dec; // = ena_in_dec;
//wire fail_data;
rs_decoder rs_decoder_inst
   (.clk        (clk            ),
    .reset_b    (reset_b        ),
    .din        (din_dec        ),
    .ena_in     (ena_in_dec_reg ),
    .dout       (dout_dec       ),
    .ena_out    (ena_out_dec    ),
    .fail_data  (fail_data      ),
    .tst        ()
    );


//////////////// ena data ///////////////////////////////////////////////////////////////////////////////////////////
reg ena_data0;
always @(posedge clk, negedge reset_b)
    if (~reset_b) begin
        ena_data0 <= 1'd0;
        data_8psk <= 204'd0;
    end else begin
        ena_data0 <= ena_out_dec;
        data_8psk <= dout_dec;
    end

reg ena_data1;
always @(posedge clk, negedge reset_b)
    if(~reset_b)
        ena_data1 <= 1'd0;
    else
        ena_data1 <= ena_data0;

wire ena_data2 = (~ena_data1) & ena_data0;
delay_rg  #(.W(1), .D(150))  delay_rg_inst1
   (.reset_b    (reset_b    ),
    .clk        (clk        ),
    .din        (ena_data2  ),
    .dout       (ena_data   ));


endmodule