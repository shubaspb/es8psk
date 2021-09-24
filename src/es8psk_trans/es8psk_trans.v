// 8PSK Transceiver for 1090ES: channel coder with Reed-Solomon,
// interleaving, modulation (8PSK, ASK), shaping filter

module es8psk_trans
   (
    input               clk,
    input               clk_dec,
    input               reset_b,
    input       [87:0]  data_tx,
    input       [203:0] data_8psk_tx,
    input               ena_data,
    output reg  [19:0]  tx_i,
    output reg  [19:0]  tx_q
    );

///////////// CRC 24 //////////////////////////////////
reg [111:0] reg_112;
reg [111:0] s_112;
reg [24:0]  poly24;
always @(*) begin : main
    integer b;
    integer d;
    s_112 = {data_tx[87:0], 24'h000000};
    reg_112 = s_112;
    poly24 = 25'h1FFF409;
    for(d=111; d > 23; d=d-1)
        if(reg_112[d])
            for(b=0; b < 25; b=b+1)
                reg_112[d-b] = reg_112[d-b]^poly24[24-b];
    s_112[23:0] = reg_112[23:0];
end
wire [111:0] data_tx_enc = s_112;
////////////////////////////////////////////////////////


///////////// Read-Solomon ////////////////////////
wire [323:0]    data_8psk_enc0;
wire            ena_8psk_enc0;
wire [67:0] tst_enc;
rs_encoder rs_encoder_inst(
    .clk        (clk_dec        ),
    .reset_b    (reset_b        ),
    .din        (data_8psk_tx   ),
    .ena_in     (ena_data       ),
    .dout       (data_8psk_enc0 ),
    .ena_out    (ena_8psk_enc0  ),
    .tst        (tst            ));
///////////////////////////////////////////////////

wire ready;
wire ena_m;
wire [2:0] sym_m;
gen_message_ext_sq  gen_message_ext_sq_inst(
    .clk        (clk_dec        ),
    .reset_b    (reset_b        ),
    .data       (data_tx_enc    ),
    .data_8psk  (data_8psk_enc0 ),
    .ena_data   (ena_8psk_enc0  ),
    .ready      (ready          ),
    .ena_m      (ena_m          ),
    .sym_m      (sym_m          ));

/////////// 8psk modulation ////////////////
wire [19:0] sig_i;
wire [19:0] sig_q;
mod_8psk  mod_8psk_inst(
    .clk       (clk_dec ),
    .reset_b   (reset_b ),
    .symbol    (sym_m   ),
    .ena_in    (ena_m   ),
    .real_out  (sig_i   ),
    .imag_out  (sig_q   ));
////////////////////////////////////////////

reg [19:0] tx_i_reg;
reg [19:0] tx_q_reg;
always @(posedge clk, negedge reset_b)
    if (!reset_b) begin
        tx_i_reg <= 20'd0;
        tx_q_reg <= 20'd0;
        tx_i <= 20'd0;
        tx_q <= 20'd0;
    end else begin
        tx_i_reg <= sig_i;
        tx_q_reg <= sig_q;
        tx_i <= tx_i_reg;
        tx_q <= tx_q_reg;
    end

////////// lpf +-8 MHz /////////////////////
//    fir_45  fir_45_real
//       (.clk         (clk       ),
//        .reset_b     (reset_b   ),
//        .data_input  (sig_i     ),
//        .data_output (tx_i      ));
//
//    fir_45  fir_45_imag
//       (.clk         (clk       ),
//        .reset_b     (reset_b   ),
//        .data_input  (sig_q     ),
//        .data_output (tx_q      ));
////////////////////////////////////////////

endmodule