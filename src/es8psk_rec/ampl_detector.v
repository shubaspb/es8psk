
module ampl_detector
   (input               clk,
    input               reset_b,
    input       [15:0]  sig_i,
    input       [15:0]  sig_q,
    input       [31:0]  thresh_noise,
    input       [31:0]  thresh_coeff,
    output reg  [19:0]  thresh,
    output reg  [19:0]  thresh_8psk,
    output      [19:0]  ampl_out
    );

localparam N = 40;

wire [19:0] sig_i_20 = {sig_i, 4'd0};
wire [19:0] sig_q_20 = {sig_q, 4'd0};
wire [19:0] magnitude;
polar_cordic #(.W(20)) polar_cordic_inst (
    .reset_b    (reset_b),
    .clk        (clk),
    .sig_i      (sig_i_20),
    .sig_q      (sig_q_20),
    .magnitude  (magnitude),
    .angle      ()
);

wire [19:0] magnitude_del;
delay_rg #(.W(40), .D(N)) delay_rg_inst1
   (.reset_b    (reset_b),
    .clk        (clk    ),
    .din        (magnitude),
    .dout       (magnitude_del));

reg [25:0] acc_ampl;
always @ (posedge clk, negedge reset_b)
    if (~reset_b) begin
        acc_ampl <= 26'd0;
    end else  begin
        acc_ampl <= acc_ampl + magnitude - magnitude_del;
    end

reg [31:0] thresh_noi;
reg [31:0] thresh_coeff1;
always @ (posedge clk, negedge reset_b)
    if (~reset_b) begin
        thresh_noi <= 32'd0;
        thresh_coeff1 <= 32'h20000;
    end else  begin
        thresh_noi <= thresh_noise;
        thresh_coeff1 <= thresh_coeff;
    end

reg [39:0] thresh_0;
always @(posedge clk, negedge reset_b)
   if (~reset_b) begin
        thresh_0 <= 40'd0;
        thresh <= 20'd0;
        thresh_8psk <= 20'd0;
   end else begin
        thresh_0 <= acc_ampl[25:6]*thresh_coeff1[19:0];
        thresh <= thresh_0[37:18] + thresh_noi;
        thresh_8psk <= thresh_0[37:18] + {3'd0, thresh_noi[19:3]};
   end

assign ampl_out = acc_ampl[24:5];

endmodule