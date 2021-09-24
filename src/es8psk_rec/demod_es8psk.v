
module demod_es8psk
   (input               clk,
    input               reset_b,
    input               ena_in,
    input               strobe,
    input       [19:0]  thresh,
    input       [19:0]  sig_i,
    input       [19:0]  sig_q,
    output reg  [2:0]   symbol,
    output reg          ena_out,
    output reg          error);


////////////// amplitude & phase detector ////////////////////////////////////////////////////////////
wire [31:0] angle;
wire [19:0] ampl;
polar_cordic #(.W(20)) polar_cordic_inst
   (.reset_b    (reset_b),
    .clk        (clk),
    .sig_i      (sig_i),
    .sig_q      (sig_q),
    .magnitude  (ampl),
    .angle      (angle));

reg ena_symb;
always @(posedge clk, negedge reset_b)
    if (!reset_b) begin
        ena_symb <= 1'd0;
    end else begin
        ena_symb <= strobe & (ampl>=thresh);
    end

///////////////// FSM drift compensator //////////////////////////////////////////////////////////////
// one-hot coding FSM (better in FPGA (less logic, but more flip-flops) and simpify debug in ASIC, 
// but binary coding in ASIC takes less area)
localparam [1:0]    IDLE  = 2'd0,
                    WAIT  = 2'd1,
                    START = 2'd2,
                    LOOP  = 2'd3;
localparam [3:0] DEFAULT  = 4'd0;

reg [3:0] state, next;
always @(posedge clk, negedge reset_b)
    if (!reset_b) begin state <= DEFAULT;
                        state[IDLE] <= 1'b1;
    end else            state <= next;

always @* begin
    next = DEFAULT; // eliminate latches
    case (1'b1)
        state[IDLE ]  : if (!ena_in)    next[WAIT ] = 1'b1;
                        else            next[IDLE ] = 1'b1;
        state[WAIT ]  : if (ena_in)     next[START] = 1'b1;
                        else            next[WAIT ] = 1'b1;
        state[START]  : if (ena_symb)   next[LOOP ] = 1'b1;
                        else            next[START] = 1'b1;
        state[LOOP ]  : if (!ena_in)    next[WAIT ] = 1'b1;
                        else            next[LOOP ] = 1'b1;
    endcase
end

// simple assign because this wires used in non-blocking assignments later
wire current_symb = next[LOOP] & ena_symb;
wire start_mes = state[START];

/////////////// drift estimation loop ////////////////////////////////////////////////////////////////
// phase of estimated symbol
reg [31:0] ang_cor;
wire [31:0] delta_phase_estim;
reg signed [31:0] phase_estim;
always @* begin
    if      (symbol == 4'd0)    phase_estim = 32'h00000000;
    else if (symbol == 4'd1)    phase_estim = 32'h20000000;
    else if (symbol == 4'd3)    phase_estim = 32'h40000000;
    else if (symbol == 4'd2)    phase_estim = 32'h60000000;
    else if (symbol == 4'd6)    phase_estim = 32'h80000000;
    else if (symbol == 4'd7)    phase_estim = 32'hA0000000;
    else if (symbol == 4'd5)    phase_estim = 32'hC0000000;
    else if (symbol == 4'd4)    phase_estim = 32'hE0000000;
    else                        phase_estim = 32'h00000000;
end

reg [31:0] ang_cor2;
always @ (posedge clk)
    ang_cor2 <= ang_cor;
assign delta_phase_estim = ang_cor2 - phase_estim;


// correction after sync interval
wire [31:0] delta_degree = 32'd23860929;  // 2 degree
reg [31:0] angle_drift;
always @(posedge clk) begin
    if (start_mes)
        angle_drift <= angle;
    else if (current_symb) begin
        if (delta_phase_estim[31])
            angle_drift <= angle_drift - delta_degree;
        else
            angle_drift <= angle_drift + delta_degree;
    end else begin
        angle_drift <= angle_drift;
    end
end

reg ena_ang;
always @(posedge clk) begin
    if (start_mes)
        ang_cor <= 32'd0;
    else if (current_symb)
        ang_cor <= angle - angle_drift;
    else
        ang_cor <= ang_cor;
    ena_ang <= ena_symb;
end

/////////////////// demodulation ////////////////////////////////////////////////////////////////////
wire [3:0] angc = ang_cor[31:28];
always @(posedge clk, negedge reset_b)
    if (!reset_b) begin
        symbol <= 4'h8;
        ena_out <= 1'b0;
    end else begin
        if (ena_in) begin
            if (ena_ang) begin
                if      ((angc>=4'hF) & (angc<4'h1)) symbol <= 4'd0;
                else if ((angc>=4'h1) & (angc<4'h3)) symbol <= 4'd1;
                else if ((angc>=4'h3) & (angc<4'h5)) symbol <= 4'd3;
                else if ((angc>=4'h5) & (angc<4'h7)) symbol <= 4'd2;
                else if ((angc>=4'h7) & (angc<4'h9)) symbol <= 4'd6;
                else if ((angc>=4'h9) & (angc<4'hB)) symbol <= 4'd7;
                else if ((angc>=4'hB) & (angc<4'hD)) symbol <= 4'd5;
                else if ((angc>=4'hD) & (angc<4'hF)) symbol <= 4'd4;
                else                                 symbol <= 4'h8;
                ena_out <= 1'b1;
            end else begin
                symbol <= symbol;
                ena_out <= 1'b0;
            end
        end else begin
            symbol <= 4'd8;
            ena_out <= 1'b0;
        end
    end


endmodule