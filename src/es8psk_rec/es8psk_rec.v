
module es8psk_rec
   (input           clk,
    input           clk_dec,
    input           reset_b,
    input   [15:0]  rx_i,
    input   [15:0]  rx_q,
    output  [203:0] data_8psk_rx,
    output          ena_data_rx,
    output          fail_data
    );


///////////// matched filter - LPF 1.8 MHz ///////////////////////////////////////////////////////
wire [19:0] fir_real;
wire [19:0] fir_imag;

lpf_dec #(.W(20)) lpf_dec_i
   (.clk        (clk),
    .clk_dec    (clk_dec),
    .reset_b    (reset_b),
    .sig_in     ({rx_i, 4'd0}),
    .sig_out    (fir_real));

lpf_dec #(.W(20)) lpf_dec_q
   (.clk        (clk),
    .clk_dec    (clk_dec),
    .reset_b    (reset_b),
    .sig_in     ({rx_q, 4'd0}),
    .sig_out    (fir_imag));


////////////////// thresh ////////////////////////////////////////////////////////////////////////////
wire [31:0] thresh_noise = 32'd100;
wire [31:0] thresh_coeff = 32'd150000;
wire [19:0] thresh;
ampl_detector ampl_detector_inst
   (.clk            (clk_dec        ),
    .reset_b        (reset_b        ),
    .sig_i          (fir_real[19:4] ),
    .sig_q          (fir_imag[19:4] ),
    .thresh_noise   (thresh_noise   ),
    .thresh_coeff   (thresh_coeff   ),
    .thresh         (thresh         ));

/////////////// correlator ////////////////////////////////////////////////////////////////////////
wire [19:0] corr;
corr_preample  corr_preample_inst
   (.clk        (clk_dec        ),
    .reset_b    (reset_b        ),
    .sig_i      (fir_real[19:4] ),
    .sig_q      (fir_imag[19:4] ),
    .corr       (corr           ));

wire strobe;
wire ena_message;
find_max_corr find_max_corr_inst
   (.clk            (clk_dec    ),
    .reset_b        (reset_b    ),
    .corr           (corr       ),
    .thresh         (thresh     ),
    .strobe         (strobe     ),
    .ena_message    (ena_message));

///////// syncro with correlator  ////////////////////////////////////////////////////////////////////
wire [19:0] sig_i_del;
wire [19:0] sig_q_del;
delay_rg  #(.W(40), .D(39)) delay_rg_inst8
   (.reset_b    (reset_b    ),
    .clk        (clk_dec    ),
    .din        ({fir_real,fir_imag}),
    .dout       ({sig_i_del,sig_q_del}));

wire [19:0] thresh_del;
delay_rg  #(.W(20), .D(12)) delay_rg_inst9
   (.reset_b    (reset_b    ),
    .clk        (clk_dec    ),
    .din        (thresh),
    .dout       (thresh_del));


///////////// demodulation /////////////////////////////////////////////////////////////////////////
wire [2:0] symbol;
wire ena_out;
wire error;
wire ena_phase_sync;
wire [2:0] phase_sync;
wire [67:0] tst_demod;
//wire [31:0] delay_var;
demod_es8psk  demod_es8psk_inst
   (.clk        (clk_dec    ),
    .reset_b    (reset_b    ),
    .ena_in     (ena_message),
    .strobe     (strobe     ),
    .thresh     (thresh_del ),
    .sig_i      (sig_i_del  ),
    .sig_q      (sig_q_del  ),
    .symbol     (symbol     ),
    .ena_out    (ena_out    ),
    .error      (error      ));

decoder_8psk decoder_8psk_inst
   (.clk            (clk_dec           ),
    .reset_b        (reset_b            ),
    .new_message    (ena_message  ),
    .symbol         (symbol             ),
    .ena            (ena_out            ),
    .err_reg        (32'd0              ),
    .data_8psk      (data_8psk_rx       ),
    .ena_data       (ena_data_rx        ),
    .fail_data      (fail_data          )
    );

endmodule