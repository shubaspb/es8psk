// Copyright (c) 2015, Dmitry Shubin
// FIR filter

module fir_filter
   #(parameter W = 20)
   (input           clk,
    input           reset_b,
    input  [W-1:0]  data_input,
    output [W-1:0]  data_output);

localparam N = 24;    // N=K*4, N<=64
localparam WC = 18;
wire signed [WC-1:0] coef [0:63];
assign coef [0  ] = 18'd0 +454;
assign coef [1  ] = 18'd0 -342;
assign coef [2  ] = 18'd0 -1479;
assign coef [3  ] = 18'd0 -1138;
assign coef [4  ] = 18'd0 +2580;
assign coef [5  ] = 18'd0 +6289;
assign coef [6  ] = 18'd0 +2017;
assign coef [7  ] = 18'd0 -11143;
assign coef [8  ] = 18'd0 -18470;
assign coef [9  ] = 18'd0 -1403;
assign coef [10 ] = 18'd0 +38404;
assign coef [11 ] = 18'd0 +72928;
assign coef [12 ] = 18'd0;
assign coef [13 ] = 18'd0;
assign coef [14 ] = 18'd0;
assign coef [15 ] = 18'd0;
assign coef [16 ] = 18'd0;
assign coef [17 ] = 18'd0;
assign coef [18 ] = 18'd0;
assign coef [19 ] = 18'd0;
assign coef [20 ] = 18'd0;
assign coef [21 ] = 18'd0;
assign coef [22 ] = 18'd0;
assign coef [23 ] = 18'd0;
assign coef [24 ] = 18'd0;
assign coef [25 ] = 18'd0;
assign coef [26 ] = 18'd0;
assign coef [27 ] = 18'd0;
assign coef [28 ] = 18'd0;
assign coef [29 ] = 18'd0;
assign coef [30 ] = 18'd0;
assign coef [31 ] = 18'd0;
assign coef [32 ] = 18'd0;
assign coef [33 ] = 18'd0;
assign coef [34 ] = 18'd0;
assign coef [35 ] = 18'd0;
assign coef [36 ] = 18'd0;
assign coef [37 ] = 18'd0;
assign coef [38 ] = 18'd0;
assign coef [39 ] = 18'd0;
assign coef [40 ] = 18'd0;
assign coef [41 ] = 18'd0;
assign coef [42 ] = 18'd0;
assign coef [43 ] = 18'd0;
assign coef [44 ] = 18'd0;
assign coef [45 ] = 18'd0;
assign coef [46 ] = 18'd0;
assign coef [47 ] = 18'd0;
assign coef [48 ] = 18'd0;
assign coef [49 ] = 18'd0;
assign coef [50 ] = 18'd0;
assign coef [51 ] = 18'd0;
assign coef [52 ] = 18'd0;
assign coef [53 ] = 18'd0;
assign coef [54 ] = 18'd0;
assign coef [55 ] = 18'd0;
assign coef [56 ] = 18'd0;
assign coef [57 ] = 18'd0;
assign coef [58 ] = 18'd0;
assign coef [59 ] = 18'd0;
assign coef [60 ] = 18'd0;
assign coef [61 ] = 18'd0;
assign coef [62 ] = 18'd0;
assign coef [63 ] = 18'd0;


reg signed [W-1:0] data_input_reg;
always @(posedge clk, negedge reset_b)
    if (!reset_b)
        data_input_reg <= 'd0;
    else
        data_input_reg <= data_input;

reg signed [W-1:0] rg [0:N-1];
always @(posedge clk) begin : line_delay
    integer i;
    rg[0] <= data_input_reg;
    for(i=0; i<(N-1); i=i+1)
        rg[i+1] <= rg[i];
end

reg signed [W:0] add_0 [0:N/2-1];
reg signed [W+WC-1:0] mult [0:N/2-1];
always @(posedge clk) begin : add_mult
    integer i;
    for (i=0; i<N/2; i=i+1) begin
        add_0[i] <= rg[i] + rg[N-1-i];
        mult[i] <= add_0[i] * coef[i];
    end
end

reg signed [W+WC-1:0] add_1 [0:N/4-1];
always @(posedge clk)  begin : adder_1
    integer i;
    for (i=0; i<N/4; i=i+1)
        add_1[i] <= mult[i] + mult[N/2-1-i];
end

reg signed [W+WC-1:0] add_2;
always @(*) begin : adder_2
    integer i;
    add_2 = 'd0;
    for (i=0; i<N/4; i=i+1)
        add_2 = add_2 + add_1[i];
end

// output reset
reg [N+3:0] rst_rg;
always @(posedge clk, negedge reset_b)
    if (!reset_b)
        rst_rg[N+3:0] <= 'd0;
    else
        rst_rg[N+3:0] <= {rst_rg[N+2:0], reset_b};
wire rst_n = rst_rg[N+2];

reg signed [W-1:0] add_3;
always @(posedge clk, negedge rst_n) begin
    if (!rst_n)
        add_3 <= 'd0;
    else
        add_3 <= add_2[W+WC-1:WC]+$signed(add_2[WC-1]);
end

assign data_output = add_3;


endmodule