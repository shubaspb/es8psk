`timescale 1ns / 1ps

module es_8psk_tb(
    output [67:0] tst_out
    );

/////// Generate clock and reset //////
reg clk;
reg clk_dec;
reg reset_b;
always
    #8 clk = ~clk;              // 60 MHz
always
    #48 clk_dec = ~clk_dec;     // 10 MHz

initial
begin
    clk = 1;
    reset_b = 0;
    #1
    clk_dec = 1;
    #302 reset_b = 1;
end
////////////////////////////////////////

wire [87:0] data_tx;
wire [203:0] data_8psk_tx;
wire [87:0] data_rx;
wire [203:0] data_8psk_rx;

/////////// 8-PSK TX ////////////////////////////////////////////
wire [19:0] tx_i;
wire [19:0] tx_q;
wire ena_data_tx;
es8psk_trans  ch8psk_trans_inst
   (.clk            ( clk           ),
    .clk_dec        ( clk_dec       ),
    .reset_b        ( reset_b       ),
    .data_tx        ( data_tx       ),
    .data_8psk_tx   ( data_8psk_tx  ),//(204'h_00000000_00010002_00040006_00070007_00070007_0), // (204'd0), //
    .ena_data       ( ena_data_tx   ),
    .tx_i           ( tx_i          ),
    .tx_q           ( tx_q          )
    );

/////////// RF channel model ///////////////////////////////////
wire [15:0] rx_i;
wire [15:0] rx_q;
rf_channel
    #(.ATT_SIG(8),
      .ATT_NOI(4))
rf_channel_inst(
    .clk        (clk        ),
    .reset_b    (reset_b    ),
    .frequency  (32'h00040000),
    .sig_in_i   (tx_i[19:4] ),
    .sig_in_q   (tx_q[19:4] ),
    .sig_out_i  (rx_i       ),
    .sig_out_q  (rx_q       ));

/////////// 8-PSK RX ////////////////////////////////////////////
wire start_fdec;
wire [19:0] thresh_calc;
es8psk_rec ch8psk_rec_inst
   (.clk            (clk            ),
    .clk_dec        (clk_dec        ),
    .reset_b        (reset_b        ),
    .rx_i           (rx_i           ),
    .rx_q           (rx_q           ),
    .data_8psk_rx   (data_8psk_rx   ),
    .ena_data_rx    (ena_data_rx    )
    );

/////////// tester ///////////////////////////////////////////
wire [111:0] dcd_code;
assign data_rx = dcd_code[111:24];

wire ena_data_rx_del;
delay_rg  #(.W(1), .D(700))  delay_rg_inst15
   (.reset_b    (reset_b        ),
    .clk        (clk_dec        ),
    .din        (ena_data_rx    ),
    .dout       (ena_data_rx_del));

wire [111:0] data_tx0;
wire [203:0] data_8psk_tx0;

wire [31:0] err_mono;
wire [31:0] bits_mono;
tester_channel #(.W(112)) tester_channel_inst0
   (.clk            (clk_dec        ),
    .reset_b        (reset_b        ),
    .data_rx        (data_rx        ),
    .ena_data_rx    (ena_data_rx_del),
    .data_tx        (data_tx0       ),
    .ena_data_tx    (ena_data_tx    ),
    .err            (err_mono       ),
    .bits           (bits_mono      )
    );

wire [31:0] err_8psk;
wire [31:0] bits_8psk;
tester_channel #(.W(204)) tester_channel_inst1
   (.clk            (clk_dec        ),
    .reset_b        (reset_b        ),
    .data_rx        (data_8psk_rx   ),
    .ena_data_rx    (ena_data_rx    ),
    .data_tx        (data_8psk_tx   ),
    .ena_data_tx    (),
    .err            (err_8psk       ),
    .bits           (bits_8psk      )
    );

//// insert error bits
wire [111:0] error_vec = {104'd0, 8'h18};
wire [203:0] error_vec_8psk = {196'd0, 8'h1f};

assign data_tx = 112'h_f234567890_1234567890_ff;      //data_tx0;  // ^ error_vec;
//assign data_8psk_tx = 204'h_ffffffffff_1234567890_ffffffffff_1234567890_ffffffffff_f    ; //data_8psk_tx0;   // ^ error_vec_8psk;          



endmodule