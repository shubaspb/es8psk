//===================================================================
// Module Name : RsDecodeDelay
// File Name   : RsDecodeDelay.v
// Function    : Rs DpRam Memory controller Module
// 
// Revision History:
// Date          By           Version    Change Description
//===================================================================
// 2009/02/03  Gael Sapience     1.0       Original
//
//===================================================================
// (C) COPYRIGHT 2009 SYSTEM LSI CO., Ltd.
//


module RsDecodeDelay(
   CLK,      // system clock
   RESET,    // system reset
   enable,   // enable signal
   dataIn,   // data input
   dataOut   // data output
);

   input          CLK;       // system clock
   input          RESET;     // system reset
   input          enable;    // enable signal
   input  [6:0]   dataIn;    // data input
   output [6:0]   dataOut;   // data output



   //------------------------------------------------------------------------
   //- registers
   //------------------------------------------------------------------------
   reg  [7:0]   writePointer;
   reg  [7:0]   readPointer;
   wire [6:0]   dpramRdData;



   //------------------------------------------------------------------------
   //- RAM memory instantiation
   //------------------------------------------------------------------------
   RsDecodeDpRam RsDecodeDpRam(
      // Outputs
      .q(dpramRdData),
      // Inputs
      .clock(CLK),
      .data(dataIn [6:0]),
      .rdaddress(readPointer),
      .rden(enable),
      .wraddress(writePointer),
      .wren(enable)
   );



   //------------------------------------------------------------------------
   //+ dataOut
   //------------------------------------------------------------------------
   assign dataOut[6:0] = dpramRdData;



   //------------------------------------------------------------------------
   //- Write Pointer
   //------------------------------------------------------------------------
   always @(posedge CLK or negedge RESET) begin
      if (~RESET) begin
         writePointer   <= 8'd142;
      end
      else if (enable == 1'b1) begin
         if (writePointer == 8'd142) begin
            writePointer <= 8'd0;
         end
         else begin
            writePointer <= writePointer + 8'd1;
         end
      end
   end



   //------------------------------------------------------------------------
   //- Read Pointer
   //------------------------------------------------------------------------
   always @(posedge CLK or negedge RESET) begin
      if (~RESET) begin
         readPointer  [7:0] <= 8'd0;
      end 
      else if (enable == 1'b1) begin
         if (readPointer == 8'd142) begin
            readPointer <= 8'd0;
         end
         else begin
            readPointer <= readPointer + 8'd1;
         end
      end
   end



endmodule
