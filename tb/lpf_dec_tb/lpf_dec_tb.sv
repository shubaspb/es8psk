`timescale 1ns / 10ps

module lpf_dec_tb
   (output [23:0] sig);



//////// clock and reset ////////////////////////////////////////////////////////////////////////
reg clk;
reg clk_dec;
reg reset_b;
always
    #8 clk = ~clk;              // 60 MHz
always
    #96 clk_dec = ~clk_dec;     // 5 MHz

initial
begin
    clk = 1;
    reset_b = 0;
    #1
    clk_dec = 1;
    #102 reset_b = 1; 
end 


////////////////////////////////////////////////////////////////////
//    integer data_file;
//    initial begin
//    	data_file = $fopen("input_file.txt", "r");
//    end
//    
//    s20 sig_in_i; 
//    s20 sig_in_q;
//    integer tmp;
//    always_ff @(posedge clk) begin
//        tmp = $fscanf(data_file, "%d,%d\n", sig_in_i, sig_in_q); 
//    end
////////////////////////////////////////////////////////////////////


localparam W=20;

//////////////// impact ////////////////////////////////////////////////////////
reg [31:0] cnt_freq;
always @(posedge clk, negedge reset_b)
    if (!reset_b)
        cnt_freq <= 32'd0;
    else 
        cnt_freq <= cnt_freq + 32'd10000;

wire signed [W-1:0] sig_in_i;
wire signed [W-1:0] sig_in_q;
ddc_duc_cordic  #(.WI(16),.WO(W)) ddc_duc_cordic_inst2 (
    .reset_b    (reset_b),
    .clk        (clk),
    .frequency  (cnt_freq),
    .s_in_i     (16'd32000 ),
    .s_in_q     (16'd0),
    .s_out_i    (sig_in_i),
    .s_out_q    (sig_in_q)
);


/////////////////// LPF //////////////////////////////////////////////////////////////
wire signed [19:0] sig_out_i;
lpf_dec #(.W(W)) lpf_dec_i
   (.clk        (clk),
    .clk_dec    (clk_dec),
    .reset_b    (reset_b),
    .sig_in     (sig_in_i),
    .sig_out    (sig_out_i));

wire signed [19:0] sig_out_q;
lpf_dec #(.W(W)) lpf_dec_q
   (.clk        (clk),
    .clk_dec    (clk_dec),
    .reset_b    (reset_b),
    .sig_in     (sig_in_q),
    .sig_out    (sig_out_q));




////////////////////////////// WRITE FILE //////////////////////////////////////////////////////
integer write_data1;
initial begin
    write_data1 = $fopen("output_file.txt", "w");
end
always_ff @(posedge clk_dec) begin
    $fdisplay(write_data1, "%d,%d,%d", cnt_freq, sig_out_i, sig_out_q);
end



endmodule