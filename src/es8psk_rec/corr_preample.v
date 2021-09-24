
module corr_preample
   (input clk,
    input reset_b,
    input [15:0] sig_i,
    input [15:0] sig_q,
    output [19:0] corr
    );

localparam N = 5;

reg signed [15:0] d_i [0:N*10-1];
always @ (posedge clk, negedge reset_b) begin : line_del_i
integer i;
    if(~reset_b) begin
        for(i=0; i < N*10; i=i+1)
            d_i[i] <= 32'd0;
    end else begin
        d_i[0] <= sig_i;
        for(i=0; i < N*10-1; i=i+1)
            d_i[i+1] <= d_i[i];
    end
end

reg signed [15:0] d_q [0:N*10-1];
always @ (posedge clk, negedge reset_b) begin : line_del_q
integer i;
    if(~reset_b) begin
        for(i=0; i < N*10; i=i+1)
            d_q[i] <= 32'd0;
    end else begin
        d_q[0] <= sig_q;
        for(i=0; i < N*10-1; i=i+1)
            d_q[i+1] <= d_q[i];
    end
end

reg signed [23:0] acc_i_0, acc_i_1, acc_i_2, acc_i_3;
always @ (posedge clk, negedge reset_b)
    if(~reset_b)  begin
        acc_i_0 <= 24'd0;
        acc_i_1 <= 24'd0;
        acc_i_2 <= 24'd0;
        acc_i_3 <= 24'd0;
    end else  begin
        acc_i_0 <= acc_i_0 + d_i[0*N] - d_i[1*N-1];
        acc_i_1 <= acc_i_1 + d_i[2*N] - d_i[3*N-1];
        acc_i_2 <= acc_i_2 + d_i[7*N] - d_i[8*N-1];
        acc_i_3 <= acc_i_3 + d_i[9*N] - d_i[10*N-1];
    end

reg signed [23:0] acc_q_0, acc_q_1, acc_q_2, acc_q_3;
always @ (posedge clk, negedge reset_b)
    if(~reset_b)  begin
        acc_q_0 <= 24'd0;
        acc_q_1 <= 24'd0;
        acc_q_2 <= 24'd0;
        acc_q_3 <= 24'd0;
    end else  begin
        acc_q_0 <= acc_q_0 + d_q[0*N] - d_q[1*N-1];
        acc_q_1 <= acc_q_1 + d_q[2*N] - d_q[3*N-1];
        acc_q_2 <= acc_q_2 + d_q[7*N] - d_q[8*N-1];
        acc_q_3 <= acc_q_3 + d_q[9*N] - d_q[10*N-1];
    end

reg signed [23:0] acc_i;
reg signed [23:0] acc_q;
always @ (posedge clk, negedge reset_b)
    if(~reset_b)  begin
        acc_i <= 24'd0;
        acc_q <= 24'd0;
    end else  begin
        acc_i <= acc_i_0 + acc_i_1 + acc_i_2 + acc_i_3;
        acc_q <= acc_q_0 + acc_q_1 + acc_q_2 + acc_q_3;
    end

wire [23:0] corr_24;
polar_cordic #(.W(24)) polar_cordic_inst
   (.reset_b    (reset_b),
    .clk        (clk),
    .sig_i      (acc_i),
    .sig_q      (acc_q),
    .magnitude  (corr_24));

assign corr = corr_24;


endmodule