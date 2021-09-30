
module tester_channel
   #(parameter W = 32) 
   (input               clk,
    input               reset_b, 
     input      [W-1:0] data_rx,
     input              ena_data_rx,
     output reg [W-1:0] data_tx,
     output reg         ena_data_tx,
     output reg [31:0]  err,
     output reg [31:0]  bits,
     output             error,
     output     [67:0]  tst
     );

localparam PERIOD = 2000;


/////////////// LSFR /////////////////////////////////////
     wire [31:0] feedback_fun = 32'hF8200000;
     reg [31:0] reg_lsfr;
     always @ (posedge clk, negedge reset_b)
          if(~reset_b) begin
               reg_lsfr <= 32'hffffffff;
          end else begin
               reg_lsfr[31:1] <= reg_lsfr[30:0];
               reg_lsfr[0] <= ^(feedback_fun & reg_lsfr); 
          end
     wire [203:0] regd = 204'h_fffff_22222_11111_12345_67890_33333_44444_55555_66666_fffff_f;
///////////////////////////////////////////////////////////


//////////// send controller //////////////////////////////
    reg [15:0] cnt_send;
    reg send_data;
    always @ (posedge clk, negedge reset_b)
        if(~reset_b) begin
            cnt_send <= 16'd0;
            send_data <= 1'b0;
        end else begin
            if (cnt_send == PERIOD) begin
                cnt_send <= 16'd0;
            end else begin
                cnt_send <= cnt_send + 16'd1;
            end
            send_data <= (cnt_send == 16'd1000);
        end
    
    always @ (posedge clk, negedge reset_b)
        if(~reset_b) begin
            data_tx <= {(W){1'b0}};
            ena_data_tx <= 1'b0;
        end else begin
            if (send_data) begin
                data_tx <= {1'b1, regd[W-2:0]};
                ena_data_tx <= 1'b1;
            end else begin
                data_tx <= data_tx;
                ena_data_tx <= 1'b0;
            end
        end
///////////////////////////////////////////////////////////////


          
//////////// statistic ////////////////////////////////////////
    reg [W-1:0] rerr;
    always @ (posedge clk, negedge reset_b)
        if(~reset_b) begin
            rerr <= {(W){1'b0}};
        end else begin
            if (ena_data_rx) begin
                rerr <= data_tx ^ data_rx;
            end else begin
                rerr[W-1:0] <= {rerr[W-2:0], 1'b0};
            end
        end
    wire err_stream = rerr[W-1];
    
    ///// statistic every 1 sec
    reg [31:0] cnt;
    wire reset_stat;
    always @ (posedge clk, negedge reset_b)
        if(~reset_b) begin
            cnt <= 32'd0;
        end else begin
            if (reset_stat) begin
                cnt <= 32'd1;
            end else begin
                cnt <= cnt + 32'd1;
            end
        end
    assign reset_stat = (cnt==32'd60000000);


    reg [31:0] err_acc;
    reg [31:0] bits_acc;
    always @ (posedge clk, negedge reset_b)
        if(~reset_b) begin
            err_acc <= 32'd0;
            err <= 32'd0;
        end else begin
            if (reset_stat) begin
                err_acc <= 32'd0;
                err <= err_acc;
            end else begin
                err_acc <= err_acc + err_stream;
                err <= err;
            end
        end

    always @ (posedge clk, negedge reset_b)
        if(~reset_b) begin
            bits_acc <= 32'd0;
            bits <= 32'd0;
        end else begin
            if (reset_stat) begin 
                bits_acc <= 32'd0;
                bits <= bits_acc;
            end else if (ena_data_rx) begin
                bits_acc <= bits_acc + W;
                bits <= bits;
            end else begin
                bits_acc <= bits_acc;
                bits <= bits;
            end
        end
////////////////////////////////////////////////////////////////


////////////// packet statistic ////////////////
    reg check_packet;
    reg [31:0] pack_num_acc;
    reg [31:0] pack_err_acc;
    reg [31:0] pack_num;
    reg [31:0] pack_err;
    always @ (posedge clk, negedge reset_b)
        if(~reset_b) begin
            check_packet <= 1'b0;
            pack_num_acc <= 32'd0;
            pack_err_acc <= 32'd0;
            pack_num <= 32'd0;
            pack_err <= 32'd0;
        end else begin
            check_packet <= ena_data_rx;
            if (reset_stat) begin 
                pack_num_acc <= 32'd0;
                pack_err_acc <= 32'd0;
                pack_num <= pack_num_acc;
                pack_err <= pack_err_acc;
            end else if (check_packet) begin
                pack_num_acc <= pack_num_acc + 32'd1;
                pack_err_acc <= pack_err_acc + |rerr;
            end else begin
                pack_num_acc <= pack_num_acc;
                pack_err_acc <= pack_err_acc;
            end
        end
//////////////////////////////////////////////

    wire [8:0] ind_st = cnt_send[8:0];
    wire stream_tx = ((cnt_send >= 24'd0)&(cnt_send <= 24'd1024)) ? data_tx[ind_st] : 1'b0;
    wire stream_rx = ((cnt_send >= 24'd0)&(cnt_send <= 24'd1024)) ? data_rx[ind_st] : 1'b0;

    assign tst = {
        clk,
        err_stream,
        ena_data_tx,
        ena_data_rx,
        stream_tx,
        stream_rx,
        err[18:0],
        bits[18:0],
        pack_num[11:0],
        pack_err[11:0]
    }; 

    assign error = rerr[W-1];

endmodule