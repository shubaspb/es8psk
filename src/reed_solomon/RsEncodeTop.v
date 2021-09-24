//===================================================================
// Module Name : RsEncodeTop
// File Name   : RsEncodeTop.v
// Function    : Rs Encoder Top Module
// 
// Revision History:
// Date          By           Version    Change Description
//===================================================================
// 2009/02/03  Gael Sapience     1.0       Original
//
//===================================================================
// (C) COPYRIGHT 2009 SYSTEM LSI CO., Ltd.
//


module RsEncodeTop(
   CLK,        // system clock
   RESET,      // system reset
   enable,     // rs encoder enable signal
   startPls,   // rs encoder sync signal
   dataIn,     // rs encoder data in
   dataOut     // rs encoder data out
);


   input          CLK;        // system clock
   input          RESET;      // system reset
   input          enable;     // rs encoder enable signal
   input          startPls;   // rs encoder sync signal
   input  [5:0]   dataIn;     // rs encoder data in
   output [5:0]   dataOut;    // rs encoder data out



   //---------------------------------------------------------------
   //- registers
   //---------------------------------------------------------------
   reg  [5:0]   count;
   reg          dataValid;
   reg  [5:0]   feedbackReg;
   wire [5:0]   mult_0;
   wire [5:0]   mult_1;
   wire [5:0]   mult_2;
   wire [5:0]   mult_3;
   wire [5:0]   mult_4;
   wire [5:0]   mult_5;
   wire [5:0]   mult_6;
   wire [5:0]   mult_7;
   wire [5:0]   mult_8;
   wire [5:0]   mult_9;
   wire [5:0]   mult_10;
   wire [5:0]   mult_11;
   wire [5:0]   mult_12;
   wire [5:0]   mult_13;
   wire [5:0]   mult_14;
   wire [5:0]   mult_15;
   wire [5:0]   mult_16;
   wire [5:0]   mult_17;
   wire [5:0]   mult_18;
   wire [5:0]   mult_19;
   reg  [5:0]   syndromeReg_0;
   reg  [5:0]   syndromeReg_1;
   reg  [5:0]   syndromeReg_2;
   reg  [5:0]   syndromeReg_3;
   reg  [5:0]   syndromeReg_4;
   reg  [5:0]   syndromeReg_5;
   reg  [5:0]   syndromeReg_6;
   reg  [5:0]   syndromeReg_7;
   reg  [5:0]   syndromeReg_8;
   reg  [5:0]   syndromeReg_9;
   reg  [5:0]   syndromeReg_10;
   reg  [5:0]   syndromeReg_11;
   reg  [5:0]   syndromeReg_12;
   reg  [5:0]   syndromeReg_13;
   reg  [5:0]   syndromeReg_14;
   reg  [5:0]   syndromeReg_15;
   reg  [5:0]   syndromeReg_16;
   reg  [5:0]   syndromeReg_17;
   reg  [5:0]   syndromeReg_18;
   reg  [5:0]   syndromeReg_19;
   reg  [5:0]   dataReg;
   reg  [5:0]   syndromeRegFF;
   reg  [5:0]   wireOut;



   //---------------------------------------------------------------
   //- count
   //---------------------------------------------------------------
   always @(posedge CLK or negedge RESET) begin
      if (~RESET) begin
         count [5:0] <= 6'd0;
      end
      else if (enable == 1'b1) begin
         if (startPls == 1'b1) begin
            count[5:0] <= 6'd1;
         end
         else if ((count[5:0] ==6'd0) || (count[5:0] ==6'd54)) begin
            count[5:0] <= 6'd0;
         end
         else begin
            count[5:0] <= count[5:0] + 6'd1;
         end
      end
   end



   //---------------------------------------------------------------
   //- dataValid
   //---------------------------------------------------------------
   always @(count or startPls) begin
      if (startPls == 1'b1 || (count[5:0] < 6'd34)) begin
         dataValid = 1'b1;
      end
      else begin
         dataValid = 1'b0;
      end
   end




   //---------------------------------------------------------------
   //- Multipliers
   //---------------------------------------------------------------
   assign mult_0[0] =  feedbackReg[5];
   assign mult_0[1] =  feedbackReg[0] ^ feedbackReg[5];
   assign mult_0[2] =  feedbackReg[1];
   assign mult_0[3] =  feedbackReg[2];
   assign mult_0[4] =  feedbackReg[3] ^ feedbackReg[5];
   assign mult_0[5] =  feedbackReg[4] ^ feedbackReg[5];
   assign mult_13[0] =  feedbackReg[3] ^ feedbackReg[4];
   assign mult_13[1] =  feedbackReg[3] ^ feedbackReg[5];
   assign mult_13[2] =  feedbackReg[4];
   assign mult_13[3] =  feedbackReg[0] ^ feedbackReg[5];
   assign mult_13[4] =  feedbackReg[1] ^ feedbackReg[3] ^ feedbackReg[4];
   assign mult_13[5] =  feedbackReg[2] ^ feedbackReg[3] ^ feedbackReg[5];
   assign mult_19[0] =  feedbackReg[0] ^ feedbackReg[1] ^ feedbackReg[4] ^ feedbackReg[5];
   assign mult_19[1] =  feedbackReg[2] ^ feedbackReg[4];
   assign mult_19[2] =  feedbackReg[0] ^ feedbackReg[3] ^ feedbackReg[5];
   assign mult_19[3] =  feedbackReg[0] ^ feedbackReg[1] ^ feedbackReg[4];
   assign mult_19[4] =  feedbackReg[0] ^ feedbackReg[2] ^ feedbackReg[4];
   assign mult_19[5] =  feedbackReg[0] ^ feedbackReg[3] ^ feedbackReg[4];
   assign mult_12[0] =  feedbackReg[0] ^ feedbackReg[3] ^ feedbackReg[4];
   assign mult_12[1] =  feedbackReg[1] ^ feedbackReg[3] ^ feedbackReg[5];
   assign mult_12[2] =  feedbackReg[2] ^ feedbackReg[4];
   assign mult_12[3] =  feedbackReg[0] ^ feedbackReg[3] ^ feedbackReg[5];
   assign mult_12[4] =  feedbackReg[1] ^ feedbackReg[3];
   assign mult_12[5] =  feedbackReg[2] ^ feedbackReg[3];
   assign mult_4[0] =  feedbackReg[1] ^ feedbackReg[2];
   assign mult_4[1] =  feedbackReg[1] ^ feedbackReg[3];
   assign mult_4[2] =  feedbackReg[0] ^ feedbackReg[2] ^ feedbackReg[4];
   assign mult_4[3] =  feedbackReg[1] ^ feedbackReg[3] ^ feedbackReg[5];
   assign mult_4[4] =  feedbackReg[1] ^ feedbackReg[4];
   assign mult_4[5] =  feedbackReg[0] ^ feedbackReg[1] ^ feedbackReg[5];
   assign mult_11[0] =  feedbackReg[1] ^ feedbackReg[2] ^ feedbackReg[3] ^ feedbackReg[5];
   assign mult_11[1] =  feedbackReg[1] ^ feedbackReg[4] ^ feedbackReg[5];
   assign mult_11[2] =  feedbackReg[2] ^ feedbackReg[5];
   assign mult_11[3] =  feedbackReg[0] ^ feedbackReg[3];
   assign mult_11[4] =  feedbackReg[2] ^ feedbackReg[3] ^ feedbackReg[4] ^ feedbackReg[5];
   assign mult_11[5] =  feedbackReg[0] ^ feedbackReg[1] ^ feedbackReg[2] ^ feedbackReg[4];
   assign mult_16[0] =  feedbackReg[0] ^ feedbackReg[1] ^ feedbackReg[2] ^ feedbackReg[3] ^ feedbackReg[4] ^ feedbackReg[5];
   assign mult_16[1] =  feedbackReg[0];
   assign mult_16[2] =  feedbackReg[0] ^ feedbackReg[1];
   assign mult_16[3] =  feedbackReg[0] ^ feedbackReg[1] ^ feedbackReg[2];
   assign mult_16[4] =  feedbackReg[4] ^ feedbackReg[5];
   assign mult_16[5] =  feedbackReg[0] ^ feedbackReg[1] ^ feedbackReg[2] ^ feedbackReg[3] ^ feedbackReg[4];
   assign mult_5[0] =  feedbackReg[0] ^ feedbackReg[1] ^ feedbackReg[2] ^ feedbackReg[3] ^ feedbackReg[5];
   assign mult_5[1] =  feedbackReg[4] ^ feedbackReg[5];
   assign mult_5[2] =  feedbackReg[5];
   assign mult_5[3] =  feedbackReg[0];
   assign mult_5[4] =  feedbackReg[2] ^ feedbackReg[3] ^ feedbackReg[5];
   assign mult_5[5] =  feedbackReg[0] ^ feedbackReg[1] ^ feedbackReg[2] ^ feedbackReg[4] ^ feedbackReg[5];
   assign mult_18[0] =  feedbackReg[0] ^ feedbackReg[1] ^ feedbackReg[2] ^ feedbackReg[3] ^ feedbackReg[5];
   assign mult_18[1] =  feedbackReg[4] ^ feedbackReg[5];
   assign mult_18[2] =  feedbackReg[5];
   assign mult_18[3] =  feedbackReg[0];
   assign mult_18[4] =  feedbackReg[2] ^ feedbackReg[3] ^ feedbackReg[5];
   assign mult_18[5] =  feedbackReg[0] ^ feedbackReg[1] ^ feedbackReg[2] ^ feedbackReg[4] ^ feedbackReg[5];
   assign mult_9[0] =  feedbackReg[2];
   assign mult_9[1] =  feedbackReg[2] ^ feedbackReg[3];
   assign mult_9[2] =  feedbackReg[0] ^ feedbackReg[3] ^ feedbackReg[4];
   assign mult_9[3] =  feedbackReg[0] ^ feedbackReg[1] ^ feedbackReg[4] ^ feedbackReg[5];
   assign mult_9[4] =  feedbackReg[0] ^ feedbackReg[1] ^ feedbackReg[5];
   assign mult_9[5] =  feedbackReg[1];
   assign mult_10[0] =  feedbackReg[2];
   assign mult_10[1] =  feedbackReg[2] ^ feedbackReg[3];
   assign mult_10[2] =  feedbackReg[0] ^ feedbackReg[3] ^ feedbackReg[4];
   assign mult_10[3] =  feedbackReg[0] ^ feedbackReg[1] ^ feedbackReg[4] ^ feedbackReg[5];
   assign mult_10[4] =  feedbackReg[0] ^ feedbackReg[1] ^ feedbackReg[5];
   assign mult_10[5] =  feedbackReg[1];
   assign mult_14[0] =  feedbackReg[1] ^ feedbackReg[3] ^ feedbackReg[4];
   assign mult_14[1] =  feedbackReg[1] ^ feedbackReg[2] ^ feedbackReg[3] ^ feedbackReg[5];
   assign mult_14[2] =  feedbackReg[2] ^ feedbackReg[3] ^ feedbackReg[4];
   assign mult_14[3] =  feedbackReg[3] ^ feedbackReg[4] ^ feedbackReg[5];
   assign mult_14[4] =  feedbackReg[0] ^ feedbackReg[1] ^ feedbackReg[3] ^ feedbackReg[5];
   assign mult_14[5] =  feedbackReg[0] ^ feedbackReg[2] ^ feedbackReg[3];
   assign mult_17[0] =  feedbackReg[1] ^ feedbackReg[2] ^ feedbackReg[5];
   assign mult_17[1] =  feedbackReg[0] ^ feedbackReg[1] ^ feedbackReg[3] ^ feedbackReg[5];
   assign mult_17[2] =  feedbackReg[0] ^ feedbackReg[1] ^ feedbackReg[2] ^ feedbackReg[4];
   assign mult_17[3] =  feedbackReg[1] ^ feedbackReg[2] ^ feedbackReg[3] ^ feedbackReg[5];
   assign mult_17[4] =  feedbackReg[1] ^ feedbackReg[3] ^ feedbackReg[4] ^ feedbackReg[5];
   assign mult_17[5] =  feedbackReg[0] ^ feedbackReg[1] ^ feedbackReg[4];
   assign mult_8[0] =  feedbackReg[1] ^ feedbackReg[3] ^ feedbackReg[5];
   assign mult_8[1] =  feedbackReg[1] ^ feedbackReg[2] ^ feedbackReg[3] ^ feedbackReg[4] ^ feedbackReg[5];
   assign mult_8[2] =  feedbackReg[0] ^ feedbackReg[2] ^ feedbackReg[3] ^ feedbackReg[4] ^ feedbackReg[5];
   assign mult_8[3] =  feedbackReg[1] ^ feedbackReg[3] ^ feedbackReg[4] ^ feedbackReg[5];
   assign mult_8[4] =  feedbackReg[0] ^ feedbackReg[1] ^ feedbackReg[2] ^ feedbackReg[3] ^ feedbackReg[4];
   assign mult_8[5] =  feedbackReg[0] ^ feedbackReg[2] ^ feedbackReg[4];
   assign mult_3[0] =  feedbackReg[0] ^ feedbackReg[2] ^ feedbackReg[5];
   assign mult_3[1] =  feedbackReg[0] ^ feedbackReg[1] ^ feedbackReg[2] ^ feedbackReg[3] ^ feedbackReg[5];
   assign mult_3[2] =  feedbackReg[0] ^ feedbackReg[1] ^ feedbackReg[2] ^ feedbackReg[3] ^ feedbackReg[4];
   assign mult_3[3] =  feedbackReg[0] ^ feedbackReg[1] ^ feedbackReg[2] ^ feedbackReg[3] ^ feedbackReg[4] ^ feedbackReg[5];
   assign mult_3[4] =  feedbackReg[0] ^ feedbackReg[1] ^ feedbackReg[3] ^ feedbackReg[4];
   assign mult_3[5] =  feedbackReg[1] ^ feedbackReg[4];
   assign mult_2[0] =  feedbackReg[1] ^ feedbackReg[4];
   assign mult_2[1] =  feedbackReg[0] ^ feedbackReg[1] ^ feedbackReg[2] ^ feedbackReg[4] ^ feedbackReg[5];
   assign mult_2[2] =  feedbackReg[0] ^ feedbackReg[1] ^ feedbackReg[2] ^ feedbackReg[3] ^ feedbackReg[5];
   assign mult_2[3] =  feedbackReg[0] ^ feedbackReg[1] ^ feedbackReg[2] ^ feedbackReg[3] ^ feedbackReg[4];
   assign mult_2[4] =  feedbackReg[0] ^ feedbackReg[2] ^ feedbackReg[3] ^ feedbackReg[5];
   assign mult_2[5] =  feedbackReg[0] ^ feedbackReg[3];
   assign mult_1[0] =  feedbackReg[2] ^ feedbackReg[5];
   assign mult_1[1] =  feedbackReg[0] ^ feedbackReg[2] ^ feedbackReg[3] ^ feedbackReg[5];
   assign mult_1[2] =  feedbackReg[0] ^ feedbackReg[1] ^ feedbackReg[3] ^ feedbackReg[4];
   assign mult_1[3] =  feedbackReg[0] ^ feedbackReg[1] ^ feedbackReg[2] ^ feedbackReg[4] ^ feedbackReg[5];
   assign mult_1[4] =  feedbackReg[0] ^ feedbackReg[1] ^ feedbackReg[3];
   assign mult_1[5] =  feedbackReg[1] ^ feedbackReg[4] ^ feedbackReg[5];
   assign mult_6[0] =  feedbackReg[1] ^ feedbackReg[4] ^ feedbackReg[5];
   assign mult_6[1] =  feedbackReg[1] ^ feedbackReg[2] ^ feedbackReg[4];
   assign mult_6[2] =  feedbackReg[0] ^ feedbackReg[2] ^ feedbackReg[3] ^ feedbackReg[5];
   assign mult_6[3] =  feedbackReg[0] ^ feedbackReg[1] ^ feedbackReg[3] ^ feedbackReg[4];
   assign mult_6[4] =  feedbackReg[0] ^ feedbackReg[2];
   assign mult_6[5] =  feedbackReg[0] ^ feedbackReg[3] ^ feedbackReg[4] ^ feedbackReg[5];
   assign mult_15[0] =  feedbackReg[2] ^ feedbackReg[3] ^ feedbackReg[4] ^ feedbackReg[5];
   assign mult_15[1] =  feedbackReg[0] ^ feedbackReg[2];
   assign mult_15[2] =  feedbackReg[0] ^ feedbackReg[1] ^ feedbackReg[3];
   assign mult_15[3] =  feedbackReg[1] ^ feedbackReg[2] ^ feedbackReg[4];
   assign mult_15[4] =  feedbackReg[0] ^ feedbackReg[4];
   assign mult_15[5] =  feedbackReg[1] ^ feedbackReg[2] ^ feedbackReg[3] ^ feedbackReg[4];
   assign mult_7[0] =  feedbackReg[0] ^ feedbackReg[1] ^ feedbackReg[2] ^ feedbackReg[3];
   assign mult_7[1] =  feedbackReg[0] ^ feedbackReg[4];
   assign mult_7[2] =  feedbackReg[1] ^ feedbackReg[5];
   assign mult_7[3] =  feedbackReg[0] ^ feedbackReg[2];
   assign mult_7[4] =  feedbackReg[2];
   assign mult_7[5] =  feedbackReg[0] ^ feedbackReg[1] ^ feedbackReg[2];



   //---------------------------------------------------------------
   //- syndromeReg
   //---------------------------------------------------------------
   always @(posedge CLK or negedge RESET) begin
      if (~RESET) begin
         syndromeReg_0 [5:0]  <= 6'd0;
         syndromeReg_1 [5:0]  <= 6'd0;
         syndromeReg_2 [5:0]  <= 6'd0;
         syndromeReg_3 [5:0]  <= 6'd0;
         syndromeReg_4 [5:0]  <= 6'd0;
         syndromeReg_5 [5:0]  <= 6'd0;
         syndromeReg_6 [5:0]  <= 6'd0;
         syndromeReg_7 [5:0]  <= 6'd0;
         syndromeReg_8 [5:0]  <= 6'd0;
         syndromeReg_9 [5:0]  <= 6'd0;
         syndromeReg_10 [5:0] <= 6'd0;
         syndromeReg_11 [5:0] <= 6'd0;
         syndromeReg_12 [5:0] <= 6'd0;
         syndromeReg_13 [5:0] <= 6'd0;
         syndromeReg_14 [5:0] <= 6'd0;
         syndromeReg_15 [5:0] <= 6'd0;
         syndromeReg_16 [5:0] <= 6'd0;
         syndromeReg_17 [5:0] <= 6'd0;
         syndromeReg_18 [5:0] <= 6'd0;
         syndromeReg_19 [5:0] <= 6'd0;
      end
      else if (enable == 1'b1) begin
         if (startPls == 1'b1) begin
            syndromeReg_0 [5:0]  <= mult_0 [5:0];
            syndromeReg_1 [5:0]  <= mult_1 [5:0];
            syndromeReg_2 [5:0]  <= mult_2 [5:0];
            syndromeReg_3 [5:0]  <= mult_3 [5:0];
            syndromeReg_4 [5:0]  <= mult_4 [5:0];
            syndromeReg_5 [5:0]  <= mult_5 [5:0];
            syndromeReg_6 [5:0]  <= mult_6 [5:0];
            syndromeReg_7 [5:0]  <= mult_7 [5:0];
            syndromeReg_8 [5:0]  <= mult_8 [5:0];
            syndromeReg_9 [5:0]  <= mult_9 [5:0];
            syndromeReg_10 [5:0] <= mult_10 [5:0];
            syndromeReg_11 [5:0] <= mult_11 [5:0];
            syndromeReg_12 [5:0] <= mult_12 [5:0];
            syndromeReg_13 [5:0] <= mult_13 [5:0];
            syndromeReg_14 [5:0] <= mult_14 [5:0];
            syndromeReg_15 [5:0] <= mult_15 [5:0];
            syndromeReg_16 [5:0] <= mult_16 [5:0];
            syndromeReg_17 [5:0] <= mult_17 [5:0];
            syndromeReg_18 [5:0] <= mult_18 [5:0];
            syndromeReg_19 [5:0] <= mult_19 [5:0];
         end
         else begin
            syndromeReg_0 [5:0]  <= mult_0 [5:0];
            syndromeReg_1 [5:0]  <= (syndromeReg_0 [5:0] ^ mult_1 [5:0]);
            syndromeReg_2 [5:0]  <= (syndromeReg_1 [5:0] ^ mult_2 [5:0]);
            syndromeReg_3 [5:0]  <= (syndromeReg_2 [5:0] ^ mult_3 [5:0]);
            syndromeReg_4 [5:0]  <= (syndromeReg_3 [5:0] ^ mult_4 [5:0]);
            syndromeReg_5 [5:0]  <= (syndromeReg_4 [5:0] ^ mult_5 [5:0]);
            syndromeReg_6 [5:0]  <= (syndromeReg_5 [5:0] ^ mult_6 [5:0]);
            syndromeReg_7 [5:0]  <= (syndromeReg_6 [5:0] ^ mult_7 [5:0]);
            syndromeReg_8 [5:0]  <= (syndromeReg_7 [5:0] ^ mult_8 [5:0]);
            syndromeReg_9 [5:0]  <= (syndromeReg_8 [5:0] ^ mult_9 [5:0]);
            syndromeReg_10 [5:0] <= (syndromeReg_9 [5:0] ^ mult_10 [5:0]);
            syndromeReg_11 [5:0] <= (syndromeReg_10 [5:0] ^ mult_11 [5:0]);
            syndromeReg_12 [5:0] <= (syndromeReg_11 [5:0] ^ mult_12 [5:0]);
            syndromeReg_13 [5:0] <= (syndromeReg_12 [5:0] ^ mult_13 [5:0]);
            syndromeReg_14 [5:0] <= (syndromeReg_13 [5:0] ^ mult_14 [5:0]);
            syndromeReg_15 [5:0] <= (syndromeReg_14 [5:0] ^ mult_15 [5:0]);
            syndromeReg_16 [5:0] <= (syndromeReg_15 [5:0] ^ mult_16 [5:0]);
            syndromeReg_17 [5:0] <= (syndromeReg_16 [5:0] ^ mult_17 [5:0]);
            syndromeReg_18 [5:0] <= (syndromeReg_17 [5:0] ^ mult_18 [5:0]);
            syndromeReg_19 [5:0] <= (syndromeReg_18 [5:0] ^ mult_19 [5:0]);
         end
      end
   end



   //---------------------------------------------------------------
   //- feedbackReg
   //---------------------------------------------------------------
   always @( startPls, dataValid, dataIn, syndromeReg_19 ) begin
      if (startPls == 1'b1) begin
         feedbackReg[5:0] = dataIn[5:0];
      end
      else if (dataValid == 1'b1) begin
         feedbackReg [5:0] = dataIn[5:0] ^  syndromeReg_19 [5:0];
      end
      else begin
         feedbackReg [5:0] =  6'd0;
      end
   end



   //---------------------------------------------------------------
   //- dataReg syndromeRegFF
   //---------------------------------------------------------------
   always @(posedge CLK, negedge RESET) begin
      if (~RESET) begin
         dataReg [5:0] <= 6'd0;
         syndromeRegFF  [5:0] <= 6'd0;
      end
      else if (enable == 1'b1) begin
         dataReg [5:0] <=  dataIn [5:0];
         syndromeRegFF  [5:0] <=  syndromeReg_19 [5:0];
      end
   end



   //---------------------------------------------------------------
   //- wireOut
   //---------------------------------------------------------------
   always @( count, dataReg, syndromeRegFF) begin
      if (count [5:0]<= 6'd34) begin
         wireOut[5:0] = dataReg[5:0];
      end
      else begin
         wireOut[5:0] = syndromeRegFF[5:0];
      end
   end



   //---------------------------------------------------------------
   //- dataOutInner
   //---------------------------------------------------------------
   reg [5:0]   dataOutInner;
   always @(posedge CLK, negedge RESET) begin
      if (~RESET) begin
         dataOutInner <= 6'd0;
      end
      else begin
         dataOutInner <= wireOut;
      end
   end



   //---------------------------------------------------------------
   //- Output ports
   //---------------------------------------------------------------
   assign dataOut = dataOutInner;



endmodule
