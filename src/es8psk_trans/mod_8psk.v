
module mod_8psk
   (input           clk,
    input           reset_b,
    input   [2:0]   symbol,
    input           ena_in,
    output  [19:0]  real_out,
    output  [19:0]  imag_out
    );

    /////////// form PM 8 /////////////////////////////////////////////////////////////////////////////////////////////////
    reg [19:0] real_mod;
    reg [19:0] imag_mod;
    always @(posedge clk, negedge reset_b)
       if (~reset_b) begin
            { real_mod , imag_mod } <= { 20'd0 , 20'd0 };
       end else begin
            if (ena_in) begin
                case (symbol)
                    3'd1    : { real_mod , imag_mod } <= { 20'b01011010100000100110 , 20'b01011010100000100110 }; //  J  J
                    3'd0    : { real_mod , imag_mod } <= { 20'b01111111111111111111 , 20'b00000000000000000000 }; //  1  0
                    3'd6    : { real_mod , imag_mod } <= { 20'b10000000000000000001 , 20'b00000000000000000000 }; // -1  0
                    3'd7    : { real_mod , imag_mod } <= { 20'b10100101011111011010 , 20'b10100101011111011010 }; // -J -J
                    3'd3    : { real_mod , imag_mod } <= { 20'b00000000000000000000 , 20'b01111111111111111111 }; //  0  1
                    3'd4    : { real_mod , imag_mod } <= { 20'b01011010100000100110 , 20'b10100101011111011010 }; //  J -J
                    3'd2    : { real_mod , imag_mod } <= { 20'b10100101011111011010 , 20'b01011010100000100110 }; // -J  J
                    3'd5    : { real_mod , imag_mod } <= { 20'b00000000000000000000 , 20'b10000000000000000001 }; //  0 -1
                    default : { real_mod , imag_mod } <= { 20'd0 , 20'd0 };
                endcase
            end else begin
                { real_mod , imag_mod } <= { 20'd0 , 20'd0 };
            end
       end
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    assign real_out = real_mod;
    assign imag_out = imag_mod;

    endmodule