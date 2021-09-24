
module find_max_corr
   (input           clk,
    input           reset_b,
    input [19:0]    corr,
    input [19:0]    thresh,
    output reg      strobe,
    output reg      ena_message
    );

localparam LENGTH_CHIP = 10;
localparam LENGTH_FIND = 6*LENGTH_CHIP;
localparam LENGTH_CORR = 6*LENGTH_CHIP+3;
localparam LENGTH_LOCK = 130*LENGTH_CHIP;
localparam END_MESSAGE = 123*LENGTH_CHIP+3;

reg find;
reg lock;
reg start_find;
reg start_lock;
always @ (posedge clk, negedge reset_b)
    if(~reset_b)  begin
        start_find <= 1'b0;
        start_lock <= 1'b0;
    end else  begin
        if ((corr>thresh)&(~lock)) begin
            start_find <= 1'b1;
            start_lock <= 1'b1;
        end else begin
            start_find <= 1'b0;
            start_lock <= 1'b0;
        end
    end

reg [15:0] cnt_find;
always @ (posedge clk, negedge reset_b)
    if(~reset_b) begin
        cnt_find <= 16'hffff;
    end else  begin
        if (start_find) begin
            cnt_find <= 16'd0;
        end else if (cnt_find == LENGTH_FIND) begin
            cnt_find <= 16'hffff;
        end else begin
            cnt_find <= cnt_find + ~&cnt_find;
        end
    end

reg [15:0] cnt_lock;
always @ (posedge clk, negedge reset_b)
    if(~reset_b) begin
        cnt_lock <= 16'hffff;
    end else  begin
        if (start_lock) begin
            cnt_lock <= 16'd0;
        end else if (cnt_lock == LENGTH_LOCK) begin
            cnt_lock <= 16'hffff;
        end else begin
            cnt_lock <= cnt_lock + ~&cnt_lock;
        end
    end

always @ (posedge clk, negedge reset_b)
    if(~reset_b) begin
        find <= 1'b0;
        lock <= 1'b0;
    end else begin
        find <= ~&cnt_find;
        lock <= ~&cnt_lock;
    end

reg [31:0] corr_reg0, corr_reg1, corr_reg2;
always @ (posedge clk, negedge reset_b)
    if(~reset_b) begin
        corr_reg0 <= 32'd0;
        corr_reg1 <= 32'd0;
        corr_reg2 <= 32'd0;
    end else begin
        corr_reg0 <= corr;
        corr_reg1 <= corr_reg0;
        corr_reg2 <= corr_reg1;
    end

reg [31:0] corr_max;
wire new_max = (corr_reg1 > corr_max) & find;
always @ (posedge clk, negedge reset_b)
    if(~reset_b) begin
        corr_max <= 32'd0;
    end else  begin
        if (find) begin
            corr_max <= (new_max) ? corr_reg1 : corr_max;
        end else begin
            corr_max <= 32'd0;
        end
    end

reg [15:0] cnt_corr;
always @ (posedge clk, negedge reset_b)
    if(~reset_b) begin
        cnt_corr <= 16'd0;
    end else  begin
        if (new_max)
            cnt_corr <= LENGTH_CORR;
        else
            cnt_corr <= cnt_corr - |cnt_corr;
    end
wire start_message = (cnt_corr==16'd1);

reg [19:0] corr_curr;
reg [19:0] corr_early;
reg [19:0] corr_late;
always @ (posedge clk, negedge reset_b)
    if(~reset_b) begin
        corr_curr   <= 20'd0;
        corr_early  <= 20'd0;
        corr_late   <= 20'd0;
    end else  begin
        if (find) begin
            corr_curr   <= (new_max) ? corr_reg1 : corr;
            corr_early  <= (new_max) ? corr_reg2 : corr_early;
            corr_late   <= (new_max) ? corr_reg0 : corr_late;
        end
    end

reg [15:0] cnt_symb;
wire end_message;
always @ (posedge clk, negedge reset_b)
    if(~reset_b) begin
        cnt_symb <= 16'hffff;
        strobe <= 1'b0;
    end else  begin
        if (lock) begin
            if (start_message | (cnt_symb == (LENGTH_CHIP/2-1)))
                cnt_symb <= 16'd0;
            else
                cnt_symb <= cnt_symb + ~&cnt_symb;
        end else begin
            cnt_symb <= 16'hffff;
        end
        strobe <= (cnt_symb == 16'd2) & ena_message;
    end

assign end_message = (cnt_lock == END_MESSAGE);
always @ (posedge clk, negedge reset_b)
    if(~reset_b) begin
        ena_message <= 1'b0;
    end else  begin
        if (lock) begin
            if (start_message)
                ena_message <= 1'd1;
            else if (end_message)
                ena_message <= 1'd0;
            else
                ena_message <= ena_message;
        end else begin
            ena_message <= 1'd0;
        end
    end

endmodule