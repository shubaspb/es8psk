
module gen_message_ext_sq
   (input               clk,
    input               reset_b,
    input       [111:0] data,        // BPSK data
    input       [323:0] data_8psk,   // extra 3 bits 8PSK
    input               ena_data,
    output reg          ready,
    output reg          ena_m,
    output reg  [2:0]   sym_m
    );

localparam N=10;

function reg rng(input [15:0] low, value, high);
    begin
        rng = value >= low && value <= high;
    end
endfunction

///////// start new message //////////////////////////////////
    reg start_cnt;
    reg ena_data_reg;
    always @(posedge clk, negedge reset_b)
        if (~reset_b) begin
            ena_data_reg <= 1'd0;
            start_cnt <= 1'd0;
        end else begin
            ena_data_reg <= ena_data;
            start_cnt <= (~ena_data_reg) & ena_data;
        end

////////// latch data /////////////////////////////////////////
    reg [111:0] data3;
    reg [67:0] data2;
    reg [67:0] data1;
    reg [67:0] data0;
    reg [39:0] parity2;
    reg [39:0] parity1;
    reg [39:0] parity0;
    always @(posedge clk, negedge reset_b)
        if (~reset_b) begin
            data3 <= 112'd0;
            data2 <= 68'd0;
            data1 <= 68'd0;
            data0 <= 68'd0;
            parity2 <= 40'd0;
            parity1 <= 40'd0;
            parity0 <= 40'd0;
        end else begin
            if (ena_data & ready) begin
                data3 <= data[111:0];
                data2   <= data_8psk[67:0];     // [323:256];
                parity2 <= data_8psk[107:68];   // [255:216];
                data1   <= data_8psk[175:108];  // [215:148];
                parity1 <= data_8psk[215:176];  // [147:108];
                data0   <= data_8psk[283:216];  // [107:40];
                parity0 <= data_8psk[323:284];  // [39:0];
            end
        end
///////////////////////////////////////////////////////////////

/////////// PPM timer ////////////////////////////////////	
    reg [15:0] scnt;
    wire new_ppm = (scnt==(N-1));
    always @(posedge clk, negedge reset_b)
        if (~reset_b) begin
            scnt <= 16'hff;
        end else begin
            if (start_cnt | new_ppm) begin
                scnt <= 16'd0;
            end else begin
                scnt <= scnt + ~&scnt;
            end
        end

////////// PPM counter ///////////////////////////////////
    reg [15:0] wc;
    always @(posedge clk, negedge reset_b)
        if (~reset_b) begin
            wc <= 16'hff;
        end else begin
            if (start_cnt) begin
                wc <= 16'd0;
            end else if (new_ppm) begin
                wc <= wc + ~&wc;
            end
        end
        
////////// ready ///////////////////////////////////////
    always @(posedge clk, negedge reset_b)
        if (~reset_b) begin
            ready <= 1'd1;
        end else begin
            if (start_cnt)
                ready <= 1'd0;
            else if (wc==16'd130)
                ready <= 1'd1;
            else
                ready <= ready;
        end

/////////////////// mux ////////////////////////////////////////////////////////////////////////////
    // indexes
    wire [15:0] i0 = 16'd111 + 16'd8  - wc;
    wire [15:0] i1 = 16'd67  + 16'd12 - wc;
    wire [15:0] i2 = 16'd39  + 16'd80 - wc;
    // mux
    reg [3:0] sym;
    reg en;
    always @(posedge clk, negedge reset_b)
        if (~reset_b) begin
            {en, sym} <= { 5'b00000 };
        end else begin
            case (1)
            // preamble
                rng(0,  wc, 0  ) : {en, sym} <= { 5'b11000 };
                rng(1,  wc, 1  ) : {en, sym} <= { 5'b11000 };
                rng(2,  wc, 2  ) : {en, sym} <= { 5'b00000 };
                rng(3,  wc, 3  ) : {en, sym} <= { 5'b10000 };
                rng(4,  wc, 4  ) : {en, sym} <= { 5'b10000 };
                rng(5,  wc, 5  ) : {en, sym} <= { 5'b00000 };
                rng(6,  wc, 6  ) : {en, sym} <= { 5'b00000 };
                rng(7,  wc, 7  ) : {en, sym} <= { 5'b00000 };
            // sync
                rng(8,  wc, 8  ) : {en, sym} <= { 1'b1, data3[i0], 3'b000 };
                rng(9,  wc, 9  ) : {en, sym} <= { 1'b1, data3[i0], 3'b000 };
                rng(10, wc, 10 ) : {en, sym} <= { 1'b1, data3[i0], 3'b000 };
                rng(11, wc, 11 ) : {en, sym} <= { 1'b1, data3[i0], 3'b000 };
            // message data
                rng(12, wc, 79 ) : {en, sym} <= { 1'b1, data3[i0], data2[i1], data1[i1], data0[i1] };
            // parity        
                rng(80, wc, 119) : {en, sym} <= { 1'b1, data3[i0], parity2[i2], parity1[i2], parity0[i2] };
                default          : {en, sym} <= { 5'b00000 };
            endcase
       end
//////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
////////// positioning modulation //////////////////////////////////////
    reg [15:0] scnt_reg;
    always @(posedge clk, negedge reset_b)
        if (~reset_b) begin
            scnt_reg <= 16'd0;
            ena_m <= 1'b0;
            sym_m <= 3'd0;
        end else begin
            scnt_reg <= scnt;
            if (sym[3]) begin
                ena_m <= (scnt_reg>=16'd0) & (scnt_reg<=(N/2-1)) & en;
            end else begin
                ena_m <= (scnt_reg>=(N/2)) & (scnt_reg<=(N-1)) & en;
            end
            sym_m <= sym[2:0];
        end
///////////////////////////////////////////////////////////////////////


endmodule