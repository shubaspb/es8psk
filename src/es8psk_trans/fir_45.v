
module fir_45
   #(parameter W = 20)
   (input clk,
    input reset_b,
    input  [W-1:0] data_input,
    output [W-1:0] data_output);


////////////// pulse response /////////////////////////////////////////
    // MATLAB:
    // load('vlib\ddc_meteo\h_pulse_comp_norm.mat', 'h_pulse_comp_norm')
    // >> hhh = round(Num*2^20); hhr  = Dop_code(hhh, 21, 0);
    // >> write_sig(hhr , 21, 'coefff.dat');
    wire signed [W:0] rom_coef [0:22];
    assign rom_coef [0  ] = 21'b_111111110100110100000;
    assign rom_coef [1  ] = 21'b_000000000100110100101;
    assign rom_coef [2  ] = 21'b_000000000111101101101;
    assign rom_coef [3  ] = 21'b_000000001011100101001;
    assign rom_coef [4  ] = 21'b_000000001111000001011;
    assign rom_coef [5  ] = 21'b_000000010000100001111;
    assign rom_coef [6  ] = 21'b_000000001110110010011;
    assign rom_coef [7  ] = 21'b_000000001000111101100;
    assign rom_coef [8  ] = 21'b_111111111111000010110;
    assign rom_coef [9  ] = 21'b_111111110010000010101;
    assign rom_coef [10 ] = 21'b_111111100100000001101;
    assign rom_coef [11 ] = 21'b_111111010111111011010;
    assign rom_coef [12 ] = 21'b_111111010001001001101;
    assign rom_coef [13 ] = 21'b_111111010010111111011;
    assign rom_coef [14 ] = 21'b_111111100000000000011;
    assign rom_coef [15 ] = 21'b_111111111001011001110;
    assign rom_coef [16 ] = 21'b_000000011110101001001;
    assign rom_coef [17 ] = 21'b_000001001101010000111;
    assign rom_coef [18 ] = 21'b_000010000001000101111;
    assign rom_coef [19 ] = 21'b_000010110100101100100;
    assign rom_coef [20 ] = 21'b_000011100010001101010;
    assign rom_coef [21 ] = 21'b_000100000100000111010;
    assign rom_coef [22 ] = 21'b_000100010110001111101;
///////////////////////////////////////////////////////////////////////


    reg signed [W-1:0] rg [0:45];
    always @ (posedge clk, negedge reset_b) begin : line_delay
    integer i;
        if(~reset_b) begin
            for(i=0; i < 46; i=i+1)
                rg[i] <= {(W){1'b0}};
        end else begin
            rg[0] <= data_input;
            for(i=0; i < 45; i=i+1)
                rg[i+1] <= rg[i];
        end
    end

    reg signed [W:0] add_0 [0:22];
    always @ (posedge clk, negedge reset_b) begin : adder_0
    integer i;
        if(~reset_b) begin
            for (i=0; i<23; i=i+1)
                add_0[i] <= {(W+1){1'b0}};
        end else begin
            add_0[0 ] <= rg[0 ] + rg[45];
            add_0[1 ] <= rg[1 ] + rg[44];
            add_0[2 ] <= rg[2 ] + rg[43];
            add_0[3 ] <= rg[3 ] + rg[42];
            add_0[4 ] <= rg[4 ] + rg[41];
            add_0[5 ] <= rg[5 ] + rg[40];
            add_0[6 ] <= rg[6 ] + rg[39];
            add_0[7 ] <= rg[7 ] + rg[38];
            add_0[8 ] <= rg[8 ] + rg[37];
            add_0[9 ] <= rg[9 ] + rg[36];
            add_0[10] <= rg[10] + rg[35];
            add_0[11] <= rg[11] + rg[34];
            add_0[12] <= rg[12] + rg[33];
            add_0[13] <= rg[13] + rg[32];
            add_0[14] <= rg[14] + rg[31];
            add_0[15] <= rg[15] + rg[30];
            add_0[16] <= rg[16] + rg[29];
            add_0[17] <= rg[17] + rg[28];
            add_0[18] <= rg[18] + rg[27];
            add_0[19] <= rg[19] + rg[26];
            add_0[20] <= rg[20] + rg[25];
            add_0[21] <= rg[21] + rg[24];
            add_0[22] <= rg[22] + rg[23];
        end
    end

    reg signed [W*2:0] mult [0:22];
    always @ (posedge clk, negedge reset_b) begin : multipliers
    integer i;
        if(~reset_b) begin
            for (i=0; i<23; i=i+1)
                mult[i] <= {(W*2+1){1'b0}};
        end else begin
            mult[0 ] <= add_0[0 ] * rom_coef[0 ];
            mult[1 ] <= add_0[1 ] * rom_coef[1 ];
            mult[2 ] <= add_0[2 ] * rom_coef[2 ];
            mult[3 ] <= add_0[3 ] * rom_coef[3 ];
            mult[4 ] <= add_0[4 ] * rom_coef[4 ];
            mult[5 ] <= add_0[5 ] * rom_coef[5 ];
            mult[6 ] <= add_0[6 ] * rom_coef[6 ];
            mult[7 ] <= add_0[7 ] * rom_coef[7 ];
            mult[8 ] <= add_0[8 ] * rom_coef[8 ];
            mult[9 ] <= add_0[9 ] * rom_coef[9 ];
            mult[10] <= add_0[10] * rom_coef[10];
            mult[11] <= add_0[11] * rom_coef[11];
            mult[12] <= add_0[12] * rom_coef[12];
            mult[13] <= add_0[13] * rom_coef[13];
            mult[14] <= add_0[14] * rom_coef[14];
            mult[15] <= add_0[15] * rom_coef[15];
            mult[16] <= add_0[16] * rom_coef[16];
            mult[17] <= add_0[17] * rom_coef[17];
            mult[18] <= add_0[18] * rom_coef[18];
            mult[19] <= add_0[19] * rom_coef[19];
            mult[20] <= add_0[20] * rom_coef[20];
            mult[21] <= add_0[21] * rom_coef[21];
            mult[22] <= add_0[22] * rom_coef[22];
        end
    end

    reg signed [W*2:0] add_1 [0:11];
    reg signed [W*2:0] add_2 [0:5];
    reg signed [W*2:0] add_3 [0:2];
    
    always @ (posedge clk, negedge reset_b) begin : adder_1
    integer i;
        if(~reset_b) begin
            for (i=0; i<12; i=i+1)
                add_1[i] <= {(W*2+1){1'b0}};
        end else begin
            add_1[0 ] <= mult[0 ];
            add_1[1 ] <= mult[1 ] + mult[22];
            add_1[2 ] <= mult[2 ] + mult[21];
            add_1[3 ] <= mult[3 ] + mult[20];
            add_1[4 ] <= mult[4 ] + mult[19];
            add_1[5 ] <= mult[5 ] + mult[18];
            add_1[6 ] <= mult[6 ] + mult[17];
            add_1[7 ] <= mult[7 ] + mult[16];
            add_1[8 ] <= mult[8 ] + mult[15];
            add_1[9 ] <= mult[9 ] + mult[14];
            add_1[10] <= mult[10] + mult[13];
            add_1[11] <= mult[11] + mult[12];
        end
    end

    always @ (posedge clk, negedge reset_b)
        if(~reset_b) begin
            add_2[0] <= {(W*2+1){1'b0}};
            add_2[1] <= {(W*2+1){1'b0}};
            add_2[2] <= {(W*2+1){1'b0}};
            add_2[3] <= {(W*2+1){1'b0}};
            add_2[4] <= {(W*2+1){1'b0}};
            add_2[5] <= {(W*2+1){1'b0}};
        end else begin
            add_2[0 ] <= add_1[0 ] + add_1[11];
            add_2[1 ] <= add_1[1 ] + add_1[10];
            add_2[2 ] <= add_1[2 ] + add_1[9 ];
            add_2[3 ] <= add_1[3 ] + add_1[8 ];
            add_2[4 ] <= add_1[4 ] + add_1[7 ];
            add_2[5 ] <= add_1[5 ] + add_1[6 ];
        end
        
    always @ (posedge clk, negedge reset_b)
        if(~reset_b) begin
            add_3[0] <= {(W*2+1){1'b0}};
            add_3[1] <= {(W*2+1){1'b0}};
            add_3[2] <= {(W*2+1){1'b0}};
        end else begin
            add_3[0] <= add_2[0 ] + add_2[5 ];
            add_3[1] <= add_2[1 ] + add_2[4 ];
            add_3[2] <= add_2[2 ] + add_2[3 ];
        end
        
    reg signed [W*2:0] add_4;
    always @ (posedge clk, negedge reset_b)
        if(~reset_b) begin
            add_4 <= {(W*2+1){1'b0}};
        end else begin
            add_4 <= add_3[0] + add_3[1] + add_3[2];
        end

    reg signed [W-1:0] add_5;
    always @ (posedge clk, negedge reset_b)
        if(~reset_b) begin
            add_5 <= {(W){1'b0}};
        end else  begin
            add_5 <= add_4[W*2:W+1]+$signed(add_4[W]);
        end

    assign data_output = add_5;


endmodule