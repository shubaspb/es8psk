
module lpf_dec
   #(parameter W = 20)
   (input          clk,
    input          clk_dec,
    input          reset_b,
    input  [W-1:0] sig_in,
    output [W-1:0] sig_out);

localparam W_GAIN = 17; // W_GAIN = ceil(ORDER_CIC^n_stages)
localparam W_GAIN_STAGE = 4;
localparam ORDER_CIC = 10;

wire [W-1:0] cic_out0; 
cic_filter
  #(.W_IN           (W),
    .W_GAIN         (W_GAIN),
    .W_GAIN_STAGE   (W_GAIN_STAGE),
    .W_OUT          (W),
    .ORDER          (ORDER_CIC))
cic_filter_inst_1
   (.clk            (clk),
    .reset_b        (reset_b),
    .data_input     (sig_in),
    .data_output    (cic_out0));

wire [W-1:0] cic_out;
cic_filter
  #(.W_IN           (W),
    .W_GAIN         (W_GAIN),
    .W_GAIN_STAGE   (W_GAIN_STAGE),
    .W_OUT          (W),
    .ORDER          (ORDER_CIC))
cic_filter_inst_3
   (.clk            (clk),
    .reset_b        (reset_b),
    .data_input     (cic_out0),
    .data_output    (cic_out));

reg [W-1:0] data_dec;
always @ (posedge clk_dec, negedge reset_b)
    if(!reset_b)
       data_dec <= {(W){1'b0}};
    else 
       data_dec <= cic_out;

wire [W-1:0] data_fir;
fir_filter
    #(.W(20))
fir_filter_inst
   (.clk        (clk_dec    ),
    .reset_b    (reset_b    ),
    .data_input (data_dec   ),
    .data_output(data_fir   ));

assign sig_out = data_fir;


endmodule