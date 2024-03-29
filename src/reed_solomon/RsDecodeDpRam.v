//===================================================================
// Module Name : RsDecodeDpRam
// File Name   : RsDecodeDpRam.v
// Function    : Rs Decoder DpRam Memory Module
// 
// Revision History:
// Date          By           Version    Change Description
//===================================================================
// 2009/02/03  Gael Sapience     1.0       Original
//
//===================================================================
// (C) COPYRIGHT 2009 SYSTEM LSI CO., Ltd.
//


module RsDecodeDpRam (/*AUTOARG*/
   // Outputs
   q,
   // Inputs
   clock,
   data,
   rdaddress,
   rden,
   wraddress,
   wren
   );

   output [6:0]   q;
   input          clock;
   input  [6:0]   data;
   input  [7:0]   rdaddress;
   input  [7:0]   wraddress;
   input          rden;
   input          wren;



    //------------------------------------------------------------------
    // + mem
    //  - DpRam Memory
    //------------------------------------------------------------------
   reg [6:0]   mem[0:142];
    always@(posedge clock) begin
       if (wren)
         mem[wraddress] <= data;
    end



    //------------------------------------------------------------------
    // + rRdAddr
    //  - Read Address register
    //------------------------------------------------------------------
    reg [7:0] rRdAddr;
    always@(posedge clock) begin
       rRdAddr <= rdaddress;
    end



    //------------------------------------------------------------------
    // + rRdEn
    //  - リードイネーブ?
    //------------------------------------------------------------------
    reg  rRdEn;
    always@(posedge clock) begin
       rRdEn <= rden;
    end



    //------------------------------------------------------------------
    // + q
    //  - リード処理
    //------------------------------------------------------------------
    reg [6:0] q;
    always@(posedge clock) begin
       if (rRdEn)
          q <= mem[rRdAddr];
    end



 endmodule
