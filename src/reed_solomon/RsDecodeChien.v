//===================================================================
// Module Name : RsDecodeChien
// File Name   : RsDecodeChien.v
// Function    : Rs Decoder Chien search algorithm Module
// 
// Revision History:
// Date          By           Version    Change Description
//===================================================================
// 2009/02/03  Gael Sapience     1.0       Original
//
//===================================================================
// (C) COPYRIGHT 2009 SYSTEM LSI CO., Ltd.
//


module RsDecodeChien(
   CLK,            // system clock
   RESET,          // system reset
   enable,         // enable signal
   sync,           // sync signal
   erasureIn,      // erasure input
   lambdaIn_0,     // lambda polynom 0
   lambdaIn_1,     // lambda polynom 1
   lambdaIn_2,     // lambda polynom 2
   lambdaIn_3,     // lambda polynom 3
   lambdaIn_4,     // lambda polynom 4
   lambdaIn_5,     // lambda polynom 5
   lambdaIn_6,     // lambda polynom 6
   lambdaIn_7,     // lambda polynom 7
   lambdaIn_8,     // lambda polynom 8
   lambdaIn_9,     // lambda polynom 9
   lambdaIn_10,    // lambda polynom 10
   lambdaIn_11,    // lambda polynom 11
   lambdaIn_12,    // lambda polynom 12
   lambdaIn_13,    // lambda polynom 13
   lambdaIn_14,    // lambda polynom 14
   lambdaIn_15,    // lambda polynom 15
   lambdaIn_16,    // lambda polynom 16
   lambdaIn_17,    // lambda polynom 17
   lambdaIn_18,    // lambda polynom 18
   lambdaIn_19,    // lambda polynom 19
   omegaIn_0,      // omega polynom 0
   omegaIn_1,      // omega polynom 1
   omegaIn_2,      // omega polynom 2
   omegaIn_3,      // omega polynom 3
   omegaIn_4,      // omega polynom 4
   omegaIn_5,      // omega polynom 5
   omegaIn_6,      // omega polynom 6
   omegaIn_7,      // omega polynom 7
   omegaIn_8,      // omega polynom 8
   omegaIn_9,      // omega polynom 9
   omegaIn_10,     // omega polynom 10
   omegaIn_11,     // omega polynom 11
   omegaIn_12,     // omega polynom 12
   omegaIn_13,     // omega polynom 13
   omegaIn_14,     // omega polynom 14
   omegaIn_15,     // omega polynom 15
   omegaIn_16,     // omega polynom 16
   omegaIn_17,     // omega polynom 17
   omegaIn_18,     // omega polynom 18
   omegaIn_19,     // omega polynom 19
   epsilonIn_0,    // epsilon polynom 0
   epsilonIn_1,    // epsilon polynom 1
   epsilonIn_2,    // epsilon polynom 2
   epsilonIn_3,    // epsilon polynom 3
   epsilonIn_4,    // epsilon polynom 4
   epsilonIn_5,    // epsilon polynom 5
   epsilonIn_6,    // epsilon polynom 6
   epsilonIn_7,    // epsilon polynom 7
   epsilonIn_8,    // epsilon polynom 8
   epsilonIn_9,    // epsilon polynom 9
   epsilonIn_10,   // epsilon polynom 10
   epsilonIn_11,   // epsilon polynom 11
   epsilonIn_12,   // epsilon polynom 12
   epsilonIn_13,   // epsilon polynom 13
   epsilonIn_14,   // epsilon polynom 14
   epsilonIn_15,   // epsilon polynom 15
   epsilonIn_16,   // epsilon polynom 16
   epsilonIn_17,   // epsilon polynom 17
   epsilonIn_18,   // epsilon polynom 18
   epsilonIn_19,   // epsilon polynom 19
   epsilonIn_20,   // epsilon polynom 20
   errorOut,       // error output
   numError,       // error amount
   done            // done signal
);


   input          CLK;            // system clock
   input          RESET;          // system reset
   input          enable;         // enable signal
   input          sync;           // sync signal
   input          erasureIn;      // erasure input
   input  [5:0]   lambdaIn_0;     // lambda polynom 0
   input  [5:0]   lambdaIn_1;     // lambda polynom 1
   input  [5:0]   lambdaIn_2;     // lambda polynom 2
   input  [5:0]   lambdaIn_3;     // lambda polynom 3
   input  [5:0]   lambdaIn_4;     // lambda polynom 4
   input  [5:0]   lambdaIn_5;     // lambda polynom 5
   input  [5:0]   lambdaIn_6;     // lambda polynom 6
   input  [5:0]   lambdaIn_7;     // lambda polynom 7
   input  [5:0]   lambdaIn_8;     // lambda polynom 8
   input  [5:0]   lambdaIn_9;     // lambda polynom 9
   input  [5:0]   lambdaIn_10;    // lambda polynom 10
   input  [5:0]   lambdaIn_11;    // lambda polynom 11
   input  [5:0]   lambdaIn_12;    // lambda polynom 12
   input  [5:0]   lambdaIn_13;    // lambda polynom 13
   input  [5:0]   lambdaIn_14;    // lambda polynom 14
   input  [5:0]   lambdaIn_15;    // lambda polynom 15
   input  [5:0]   lambdaIn_16;    // lambda polynom 16
   input  [5:0]   lambdaIn_17;    // lambda polynom 17
   input  [5:0]   lambdaIn_18;    // lambda polynom 18
   input  [5:0]   lambdaIn_19;    // lambda polynom 19
   input  [5:0]   omegaIn_0;      // omega polynom 0
   input  [5:0]   omegaIn_1;      // omega polynom 1
   input  [5:0]   omegaIn_2;      // omega polynom 2
   input  [5:0]   omegaIn_3;      // omega polynom 3
   input  [5:0]   omegaIn_4;      // omega polynom 4
   input  [5:0]   omegaIn_5;      // omega polynom 5
   input  [5:0]   omegaIn_6;      // omega polynom 6
   input  [5:0]   omegaIn_7;      // omega polynom 7
   input  [5:0]   omegaIn_8;      // omega polynom 8
   input  [5:0]   omegaIn_9;      // omega polynom 9
   input  [5:0]   omegaIn_10;     // omega polynom 10
   input  [5:0]   omegaIn_11;     // omega polynom 11
   input  [5:0]   omegaIn_12;     // omega polynom 12
   input  [5:0]   omegaIn_13;     // omega polynom 13
   input  [5:0]   omegaIn_14;     // omega polynom 14
   input  [5:0]   omegaIn_15;     // omega polynom 15
   input  [5:0]   omegaIn_16;     // omega polynom 16
   input  [5:0]   omegaIn_17;     // omega polynom 17
   input  [5:0]   omegaIn_18;     // omega polynom 18
   input  [5:0]   omegaIn_19;     // omega polynom 19

   input  [5:0]   epsilonIn_0;    // epsilon polynom 0
   input  [5:0]   epsilonIn_1;    // epsilon polynom 1
   input  [5:0]   epsilonIn_2;    // epsilon polynom 2
   input  [5:0]   epsilonIn_3;    // epsilon polynom 3
   input  [5:0]   epsilonIn_4;    // epsilon polynom 4
   input  [5:0]   epsilonIn_5;    // epsilon polynom 5
   input  [5:0]   epsilonIn_6;    // epsilon polynom 6
   input  [5:0]   epsilonIn_7;    // epsilon polynom 7
   input  [5:0]   epsilonIn_8;    // epsilon polynom 8
   input  [5:0]   epsilonIn_9;    // epsilon polynom 9
   input  [5:0]   epsilonIn_10;   // epsilon polynom 10
   input  [5:0]   epsilonIn_11;   // epsilon polynom 11
   input  [5:0]   epsilonIn_12;   // epsilon polynom 12
   input  [5:0]   epsilonIn_13;   // epsilon polynom 13
   input  [5:0]   epsilonIn_14;   // epsilon polynom 14
   input  [5:0]   epsilonIn_15;   // epsilon polynom 15
   input  [5:0]   epsilonIn_16;   // epsilon polynom 16
   input  [5:0]   epsilonIn_17;   // epsilon polynom 17
   input  [5:0]   epsilonIn_18;   // epsilon polynom 18
   input  [5:0]   epsilonIn_19;   // epsilon polynom 19
   input  [5:0]   epsilonIn_20;   // epsilon polynom 20
   output [5:0]   errorOut;       // error output
   output [4:0]   numError;       // error amount
   output         done;           // done signal



   //------------------------------------------------------------------------
   // + 
   //- registers
   //------------------------------------------------------------------------
   reg  [5:0]   lambdaSum;
   reg  [5:0]   lambdaSumReg;
   reg  [5:0]   lambdaEven;
   reg  [5:0]   lambdaEvenReg;
   reg  [5:0]   lambdaEvenReg2;
   reg  [5:0]   lambdaEvenReg3;
   reg  [5:0]   lambdaOdd;
   reg  [5:0]   lambdaOddReg;
   reg  [5:0]   lambdaOddReg2;
   reg  [5:0]   lambdaOddReg3;
   wire [5:0]   denomE0;
   wire [5:0]   denomE1;
   reg  [5:0]   denomE0Reg;
   reg  [5:0]   denomE1Reg;
   wire [5:0]   denomE0Inv;
   wire [5:0]   denomE1Inv;
   reg  [5:0]   denomE0InvReg;
   reg  [5:0]   denomE1InvReg;
   reg  [5:0]   omegaSum;
   reg  [5:0]   omegaSumReg;
   reg  [5:0]   numeReg;
   reg  [5:0]   numeReg2;
   reg  [5:0]   epsilonSum;
   reg  [5:0]   epsilonSumReg;
   reg  [5:0]   epsilonOdd;
   reg  [5:0]   epsilonOddReg;
   wire [5:0]   errorValueE0;
   wire [5:0]   errorValueE1;
   reg  [5:0]   count;
   reg          doneOrg;





   //------------------------------------------------------------------
   // + count
   //------------------------------------------------------------------
   always @(posedge CLK or negedge RESET) begin
      if (~RESET) begin
         count [5:0] <= 6'd0;
      end
      else if (enable == 1'b1) begin
         if (sync == 1'b1) begin
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



   //------------------------------------------------------------------
   // + doneOrg
   //------------------------------------------------------------------
   always @(count) begin
      if (count[5:0] == 6'd54) begin
         doneOrg   = 1'b1;
      end else begin
         doneOrg   = 1'b0;
      end
   end

   assign   done   = doneOrg;



   //------------------------------------------------------------------------
   //- lambdaIni
   //------------------------------------------------------------------------
   wire [5:0]   lambdaIni_0;
   wire [5:0]   lambdaIni_1;
   wire [5:0]   lambdaIni_2;
   wire [5:0]   lambdaIni_3;
   wire [5:0]   lambdaIni_4;
   wire [5:0]   lambdaIni_5;
   wire [5:0]   lambdaIni_6;
   wire [5:0]   lambdaIni_7;
   wire [5:0]   lambdaIni_8;
   wire [5:0]   lambdaIni_9;
   wire [5:0]   lambdaIni_10;
   wire [5:0]   lambdaIni_11;
   wire [5:0]   lambdaIni_12;
   wire [5:0]   lambdaIni_13;
   wire [5:0]   lambdaIni_14;
   wire [5:0]   lambdaIni_15;
   wire [5:0]   lambdaIni_16;
   wire [5:0]   lambdaIni_17;
   wire [5:0]   lambdaIni_18;
   wire [5:0]   lambdaIni_19;


   assign lambdaIni_0 [0] = lambdaIn_0[0];
   assign lambdaIni_0 [1] = lambdaIn_0[1];
   assign lambdaIni_0 [2] = lambdaIn_0[2];
   assign lambdaIni_0 [3] = lambdaIn_0[3];
   assign lambdaIni_0 [4] = lambdaIn_0[4];
   assign lambdaIni_0 [5] = lambdaIn_0[5];
   assign lambdaIni_1 [0] = lambdaIn_1[0] ^ lambdaIn_1[1] ^ lambdaIn_1[4] ^ lambdaIn_1[5];
   assign lambdaIni_1 [1] = lambdaIn_1[2] ^ lambdaIn_1[4];
   assign lambdaIni_1 [2] = lambdaIn_1[0] ^ lambdaIn_1[3] ^ lambdaIn_1[5];
   assign lambdaIni_1 [3] = lambdaIn_1[0] ^ lambdaIn_1[1] ^ lambdaIn_1[4];
   assign lambdaIni_1 [4] = lambdaIn_1[0] ^ lambdaIn_1[2] ^ lambdaIn_1[4];
   assign lambdaIni_1 [5] = lambdaIn_1[0] ^ lambdaIn_1[3] ^ lambdaIn_1[4];
   assign lambdaIni_2 [0] = lambdaIn_2[0] ^ lambdaIn_2[1] ^ lambdaIn_2[3] ^ lambdaIn_2[5];
   assign lambdaIni_2 [1] = lambdaIn_2[2] ^ lambdaIn_2[3] ^ lambdaIn_2[4] ^ lambdaIn_2[5];
   assign lambdaIni_2 [2] = lambdaIn_2[0] ^ lambdaIn_2[3] ^ lambdaIn_2[4] ^ lambdaIn_2[5];
   assign lambdaIni_2 [3] = lambdaIn_2[1] ^ lambdaIn_2[4] ^ lambdaIn_2[5];
   assign lambdaIni_2 [4] = lambdaIn_2[0] ^ lambdaIn_2[1] ^ lambdaIn_2[2] ^ lambdaIn_2[3];
   assign lambdaIni_2 [5] = lambdaIn_2[0] ^ lambdaIn_2[2] ^ lambdaIn_2[4] ^ lambdaIn_2[5];
   assign lambdaIni_3 [0] = lambdaIn_3[0] ^ lambdaIn_3[2] ^ lambdaIn_3[3] ^ lambdaIn_3[5];
   assign lambdaIni_3 [1] = lambdaIn_3[1] ^ lambdaIn_3[2] ^ lambdaIn_3[4] ^ lambdaIn_3[5];
   assign lambdaIni_3 [2] = lambdaIn_3[2] ^ lambdaIn_3[3] ^ lambdaIn_3[5];
   assign lambdaIni_3 [3] = lambdaIn_3[3] ^ lambdaIn_3[4];
   assign lambdaIni_3 [4] = lambdaIn_3[0] ^ lambdaIn_3[2] ^ lambdaIn_3[3] ^ lambdaIn_3[4];
   assign lambdaIni_3 [5] = lambdaIn_3[1] ^ lambdaIn_3[2] ^ lambdaIn_3[4];
   assign lambdaIni_4 [0] = lambdaIn_4[4];
   assign lambdaIni_4 [1] = lambdaIn_4[0] ^ lambdaIn_4[4] ^ lambdaIn_4[5];
   assign lambdaIni_4 [2] = lambdaIn_4[0] ^ lambdaIn_4[1] ^ lambdaIn_4[5];
   assign lambdaIni_4 [3] = lambdaIn_4[1] ^ lambdaIn_4[2];
   assign lambdaIni_4 [4] = lambdaIn_4[2] ^ lambdaIn_4[3] ^ lambdaIn_4[4];
   assign lambdaIni_4 [5] = lambdaIn_4[3] ^ lambdaIn_4[5];
   assign lambdaIni_5 [0] = lambdaIn_5[0] ^ lambdaIn_5[2] ^ lambdaIn_5[4];
   assign lambdaIni_5 [1] = lambdaIn_5[0] ^ lambdaIn_5[1] ^ lambdaIn_5[2] ^ lambdaIn_5[3] ^ lambdaIn_5[4] ^ lambdaIn_5[5];
   assign lambdaIni_5 [2] = lambdaIn_5[1] ^ lambdaIn_5[2] ^ lambdaIn_5[3] ^ lambdaIn_5[4] ^ lambdaIn_5[5];
   assign lambdaIni_5 [3] = lambdaIn_5[0] ^ lambdaIn_5[2] ^ lambdaIn_5[3] ^ lambdaIn_5[4] ^ lambdaIn_5[5];
   assign lambdaIni_5 [4] = lambdaIn_5[0] ^ lambdaIn_5[1] ^ lambdaIn_5[2] ^ lambdaIn_5[3] ^ lambdaIn_5[5];
   assign lambdaIni_5 [5] = lambdaIn_5[1] ^ lambdaIn_5[3];
   assign lambdaIni_6 [0] = lambdaIn_6[0] ^ lambdaIn_6[1] ^ lambdaIn_6[2] ^ lambdaIn_6[3];
   assign lambdaIni_6 [1] = lambdaIn_6[0] ^ lambdaIn_6[4];
   assign lambdaIni_6 [2] = lambdaIn_6[1] ^ lambdaIn_6[5];
   assign lambdaIni_6 [3] = lambdaIn_6[0] ^ lambdaIn_6[2];
   assign lambdaIni_6 [4] = lambdaIn_6[2];
   assign lambdaIni_6 [5] = lambdaIn_6[0] ^ lambdaIn_6[1] ^ lambdaIn_6[2];
   assign lambdaIni_7 [0] = lambdaIn_7[0] ^ lambdaIn_7[2] ^ lambdaIn_7[3] ^ lambdaIn_7[4];
   assign lambdaIni_7 [1] = lambdaIn_7[1] ^ lambdaIn_7[2] ^ lambdaIn_7[5];
   assign lambdaIni_7 [2] = lambdaIn_7[0] ^ lambdaIn_7[2] ^ lambdaIn_7[3];
   assign lambdaIni_7 [3] = lambdaIn_7[1] ^ lambdaIn_7[3] ^ lambdaIn_7[4];
   assign lambdaIni_7 [4] = lambdaIn_7[0] ^ lambdaIn_7[3] ^ lambdaIn_7[5];
   assign lambdaIni_7 [5] = lambdaIn_7[1] ^ lambdaIn_7[2] ^ lambdaIn_7[3];
   assign lambdaIni_8 [0] = lambdaIn_8[2] ^ lambdaIn_8[3] ^ lambdaIn_8[4];
   assign lambdaIni_8 [1] = lambdaIn_8[2] ^ lambdaIn_8[5];
   assign lambdaIni_8 [2] = lambdaIn_8[0] ^ lambdaIn_8[3];
   assign lambdaIni_8 [3] = lambdaIn_8[1] ^ lambdaIn_8[4];
   assign lambdaIni_8 [4] = lambdaIn_8[0] ^ lambdaIn_8[3] ^ lambdaIn_8[4] ^ lambdaIn_8[5];
   assign lambdaIni_8 [5] = lambdaIn_8[1] ^ lambdaIn_8[2] ^ lambdaIn_8[3] ^ lambdaIn_8[5];
   assign lambdaIni_9 [0] = lambdaIn_9[0] ^ lambdaIn_9[1] ^ lambdaIn_9[2] ^ lambdaIn_9[3] ^ lambdaIn_9[5];
   assign lambdaIni_9 [1] = lambdaIn_9[4] ^ lambdaIn_9[5];
   assign lambdaIni_9 [2] = lambdaIn_9[5];
   assign lambdaIni_9 [3] = lambdaIn_9[0];
   assign lambdaIni_9 [4] = lambdaIn_9[2] ^ lambdaIn_9[3] ^ lambdaIn_9[5];
   assign lambdaIni_9 [5] = lambdaIn_9[0] ^ lambdaIn_9[1] ^ lambdaIn_9[2] ^ lambdaIn_9[4] ^ lambdaIn_9[5];
   assign lambdaIni_10 [0] = lambdaIn_10[2];
   assign lambdaIni_10 [1] = lambdaIn_10[2] ^ lambdaIn_10[3];
   assign lambdaIni_10 [2] = lambdaIn_10[0] ^ lambdaIn_10[3] ^ lambdaIn_10[4];
   assign lambdaIni_10 [3] = lambdaIn_10[0] ^ lambdaIn_10[1] ^ lambdaIn_10[4] ^ lambdaIn_10[5];
   assign lambdaIni_10 [4] = lambdaIn_10[0] ^ lambdaIn_10[1] ^ lambdaIn_10[5];
   assign lambdaIni_10 [5] = lambdaIn_10[1];
   assign lambdaIni_11 [0] = lambdaIn_11[0] ^ lambdaIn_11[3] ^ lambdaIn_11[5];
   assign lambdaIni_11 [1] = lambdaIn_11[1] ^ lambdaIn_11[3] ^ lambdaIn_11[4] ^ lambdaIn_11[5];
   assign lambdaIni_11 [2] = lambdaIn_11[0] ^ lambdaIn_11[2] ^ lambdaIn_11[4] ^ lambdaIn_11[5];
   assign lambdaIni_11 [3] = lambdaIn_11[0] ^ lambdaIn_11[1] ^ lambdaIn_11[3] ^ lambdaIn_11[5];
   assign lambdaIni_11 [4] = lambdaIn_11[1] ^ lambdaIn_11[2] ^ lambdaIn_11[3] ^ lambdaIn_11[4] ^ lambdaIn_11[5];
   assign lambdaIni_11 [5] = lambdaIn_11[2] ^ lambdaIn_11[4];
   assign lambdaIni_12 [0] = lambdaIn_12[0] ^ lambdaIn_12[3] ^ lambdaIn_12[4] ^ lambdaIn_12[5];
   assign lambdaIni_12 [1] = lambdaIn_12[0] ^ lambdaIn_12[1] ^ lambdaIn_12[3];
   assign lambdaIni_12 [2] = lambdaIn_12[1] ^ lambdaIn_12[2] ^ lambdaIn_12[4];
   assign lambdaIni_12 [3] = lambdaIn_12[0] ^ lambdaIn_12[2] ^ lambdaIn_12[3] ^ lambdaIn_12[5];
   assign lambdaIni_12 [4] = lambdaIn_12[1] ^ lambdaIn_12[5];
   assign lambdaIni_12 [5] = lambdaIn_12[2] ^ lambdaIn_12[3] ^ lambdaIn_12[4] ^ lambdaIn_12[5];
   assign lambdaIni_13 [0] = lambdaIn_13[2] ^ lambdaIn_13[3] ^ lambdaIn_13[5];
   assign lambdaIni_13 [1] = lambdaIn_13[2] ^ lambdaIn_13[4] ^ lambdaIn_13[5];
   assign lambdaIni_13 [2] = lambdaIn_13[3] ^ lambdaIn_13[5];
   assign lambdaIni_13 [3] = lambdaIn_13[4];
   assign lambdaIni_13 [4] = lambdaIn_13[0] ^ lambdaIn_13[2] ^ lambdaIn_13[3];
   assign lambdaIni_13 [5] = lambdaIn_13[1] ^ lambdaIn_13[2] ^ lambdaIn_13[4] ^ lambdaIn_13[5];
   assign lambdaIni_14 [0] = lambdaIn_14[0] ^ lambdaIn_14[1] ^ lambdaIn_14[5];
   assign lambdaIni_14 [1] = lambdaIn_14[0] ^ lambdaIn_14[2] ^ lambdaIn_14[5];
   assign lambdaIni_14 [2] = lambdaIn_14[1] ^ lambdaIn_14[3];
   assign lambdaIni_14 [3] = lambdaIn_14[0] ^ lambdaIn_14[2] ^ lambdaIn_14[4];
   assign lambdaIni_14 [4] = lambdaIn_14[0] ^ lambdaIn_14[3];
   assign lambdaIni_14 [5] = lambdaIn_14[0] ^ lambdaIn_14[4] ^ lambdaIn_14[5];
   assign lambdaIni_15 [0] = lambdaIn_15[1] ^ lambdaIn_15[2] ^ lambdaIn_15[3] ^ lambdaIn_15[4] ^ lambdaIn_15[5];
   assign lambdaIni_15 [1] = lambdaIn_15[0] ^ lambdaIn_15[1];
   assign lambdaIni_15 [2] = lambdaIn_15[0] ^ lambdaIn_15[1] ^ lambdaIn_15[2];
   assign lambdaIni_15 [3] = lambdaIn_15[0] ^ lambdaIn_15[1] ^ lambdaIn_15[2] ^ lambdaIn_15[3];
   assign lambdaIni_15 [4] = lambdaIn_15[5];
   assign lambdaIni_15 [5] = lambdaIn_15[0] ^ lambdaIn_15[1] ^ lambdaIn_15[2] ^ lambdaIn_15[3] ^ lambdaIn_15[4] ^ lambdaIn_15[5];
   assign lambdaIni_16 [0] = lambdaIn_16[1] ^ lambdaIn_16[5];
   assign lambdaIni_16 [1] = lambdaIn_16[0] ^ lambdaIn_16[1] ^ lambdaIn_16[2] ^ lambdaIn_16[5];
   assign lambdaIni_16 [2] = lambdaIn_16[1] ^ lambdaIn_16[2] ^ lambdaIn_16[3];
   assign lambdaIni_16 [3] = lambdaIn_16[0] ^ lambdaIn_16[2] ^ lambdaIn_16[3] ^ lambdaIn_16[4];
   assign lambdaIni_16 [4] = lambdaIn_16[0] ^ lambdaIn_16[3] ^ lambdaIn_16[4];
   assign lambdaIni_16 [5] = lambdaIn_16[0] ^ lambdaIn_16[4];
   assign lambdaIni_17 [0] = lambdaIn_17[0] ^ lambdaIn_17[2] ^ lambdaIn_17[3];
   assign lambdaIni_17 [1] = lambdaIn_17[0] ^ lambdaIn_17[1] ^ lambdaIn_17[2] ^ lambdaIn_17[4];
   assign lambdaIni_17 [2] = lambdaIn_17[1] ^ lambdaIn_17[2] ^ lambdaIn_17[3] ^ lambdaIn_17[5];
   assign lambdaIni_17 [3] = lambdaIn_17[2] ^ lambdaIn_17[3] ^ lambdaIn_17[4];
   assign lambdaIni_17 [4] = lambdaIn_17[0] ^ lambdaIn_17[2] ^ lambdaIn_17[4] ^ lambdaIn_17[5];
   assign lambdaIni_17 [5] = lambdaIn_17[1] ^ lambdaIn_17[2] ^ lambdaIn_17[5];
   assign lambdaIni_18 [0] = lambdaIn_18[0] ^ lambdaIn_18[3];
   assign lambdaIni_18 [1] = lambdaIn_18[0] ^ lambdaIn_18[1] ^ lambdaIn_18[3] ^ lambdaIn_18[4];
   assign lambdaIni_18 [2] = lambdaIn_18[0] ^ lambdaIn_18[1] ^ lambdaIn_18[2] ^ lambdaIn_18[4] ^ lambdaIn_18[5];
   assign lambdaIni_18 [3] = lambdaIn_18[0] ^ lambdaIn_18[1] ^ lambdaIn_18[2] ^ lambdaIn_18[3] ^ lambdaIn_18[5];
   assign lambdaIni_18 [4] = lambdaIn_18[1] ^ lambdaIn_18[2] ^ lambdaIn_18[4];
   assign lambdaIni_18 [5] = lambdaIn_18[2] ^ lambdaIn_18[5];
   assign lambdaIni_19 [0] = lambdaIn_19[5];
   assign lambdaIni_19 [1] = lambdaIn_19[0] ^ lambdaIn_19[5];
   assign lambdaIni_19 [2] = lambdaIn_19[1];
   assign lambdaIni_19 [3] = lambdaIn_19[2];
   assign lambdaIni_19 [4] = lambdaIn_19[3] ^ lambdaIn_19[5];
   assign lambdaIni_19 [5] = lambdaIn_19[4] ^ lambdaIn_19[5];



   //------------------------------------------------------------------------
   //- lambdaNew
   //------------------------------------------------------------------------
   reg  [5:0]   lambdaReg_0;
   reg  [5:0]   lambdaReg_1;
   reg  [5:0]   lambdaReg_2;
   reg  [5:0]   lambdaReg_3;
   reg  [5:0]   lambdaReg_4;
   reg  [5:0]   lambdaReg_5;
   reg  [5:0]   lambdaReg_6;
   reg  [5:0]   lambdaReg_7;
   reg  [5:0]   lambdaReg_8;
   reg  [5:0]   lambdaReg_9;
   reg  [5:0]   lambdaReg_10;
   reg  [5:0]   lambdaReg_11;
   reg  [5:0]   lambdaReg_12;
   reg  [5:0]   lambdaReg_13;
   reg  [5:0]   lambdaReg_14;
   reg  [5:0]   lambdaReg_15;
   reg  [5:0]   lambdaReg_16;
   reg  [5:0]   lambdaReg_17;
   reg  [5:0]   lambdaReg_18;
   reg  [5:0]   lambdaReg_19;
   wire [5:0]   lambdaUp_0;
   wire [5:0]   lambdaUp_1;
   wire [5:0]   lambdaUp_2;
   wire [5:0]   lambdaUp_3;
   wire [5:0]   lambdaUp_4;
   wire [5:0]   lambdaUp_5;
   wire [5:0]   lambdaUp_6;
   wire [5:0]   lambdaUp_7;
   wire [5:0]   lambdaUp_8;
   wire [5:0]   lambdaUp_9;
   wire [5:0]   lambdaUp_10;
   wire [5:0]   lambdaUp_11;
   wire [5:0]   lambdaUp_12;
   wire [5:0]   lambdaUp_13;
   wire [5:0]   lambdaUp_14;
   wire [5:0]   lambdaUp_15;
   wire [5:0]   lambdaUp_16;
   wire [5:0]   lambdaUp_17;
   wire [5:0]   lambdaUp_18;
   wire [5:0]   lambdaUp_19;


   assign lambdaUp_0 [0] = lambdaReg_0[0];
   assign lambdaUp_0 [1] = lambdaReg_0[1];
   assign lambdaUp_0 [2] = lambdaReg_0[2];
   assign lambdaUp_0 [3] = lambdaReg_0[3];
   assign lambdaUp_0 [4] = lambdaReg_0[4];
   assign lambdaUp_0 [5] = lambdaReg_0[5];
   assign lambdaUp_1 [0] = lambdaReg_1[5];
   assign lambdaUp_1 [1] = lambdaReg_1[0] ^ lambdaReg_1[5];
   assign lambdaUp_1 [2] = lambdaReg_1[1];
   assign lambdaUp_1 [3] = lambdaReg_1[2];
   assign lambdaUp_1 [4] = lambdaReg_1[3] ^ lambdaReg_1[5];
   assign lambdaUp_1 [5] = lambdaReg_1[4] ^ lambdaReg_1[5];
   assign lambdaUp_2 [0] = lambdaReg_2[4] ^ lambdaReg_2[5];
   assign lambdaUp_2 [1] = lambdaReg_2[4];
   assign lambdaUp_2 [2] = lambdaReg_2[0] ^ lambdaReg_2[5];
   assign lambdaUp_2 [3] = lambdaReg_2[1];
   assign lambdaUp_2 [4] = lambdaReg_2[2] ^ lambdaReg_2[4] ^ lambdaReg_2[5];
   assign lambdaUp_2 [5] = lambdaReg_2[3] ^ lambdaReg_2[4];
   assign lambdaUp_3 [0] = lambdaReg_3[3] ^ lambdaReg_3[4];
   assign lambdaUp_3 [1] = lambdaReg_3[3] ^ lambdaReg_3[5];
   assign lambdaUp_3 [2] = lambdaReg_3[4];
   assign lambdaUp_3 [3] = lambdaReg_3[0] ^ lambdaReg_3[5];
   assign lambdaUp_3 [4] = lambdaReg_3[1] ^ lambdaReg_3[3] ^ lambdaReg_3[4];
   assign lambdaUp_3 [5] = lambdaReg_3[2] ^ lambdaReg_3[3] ^ lambdaReg_3[5];
   assign lambdaUp_4 [0] = lambdaReg_4[2] ^ lambdaReg_4[3] ^ lambdaReg_4[5];
   assign lambdaUp_4 [1] = lambdaReg_4[2] ^ lambdaReg_4[4] ^ lambdaReg_4[5];
   assign lambdaUp_4 [2] = lambdaReg_4[3] ^ lambdaReg_4[5];
   assign lambdaUp_4 [3] = lambdaReg_4[4];
   assign lambdaUp_4 [4] = lambdaReg_4[0] ^ lambdaReg_4[2] ^ lambdaReg_4[3];
   assign lambdaUp_4 [5] = lambdaReg_4[1] ^ lambdaReg_4[2] ^ lambdaReg_4[4] ^ lambdaReg_4[5];
   assign lambdaUp_5 [0] = lambdaReg_5[1] ^ lambdaReg_5[2] ^ lambdaReg_5[4] ^ lambdaReg_5[5];
   assign lambdaUp_5 [1] = lambdaReg_5[1] ^ lambdaReg_5[3] ^ lambdaReg_5[4];
   assign lambdaUp_5 [2] = lambdaReg_5[2] ^ lambdaReg_5[4] ^ lambdaReg_5[5];
   assign lambdaUp_5 [3] = lambdaReg_5[3] ^ lambdaReg_5[5];
   assign lambdaUp_5 [4] = lambdaReg_5[1] ^ lambdaReg_5[2] ^ lambdaReg_5[5];
   assign lambdaUp_5 [5] = lambdaReg_5[0] ^ lambdaReg_5[1] ^ lambdaReg_5[3] ^ lambdaReg_5[4] ^ lambdaReg_5[5];
   assign lambdaUp_6 [0] = lambdaReg_6[0] ^ lambdaReg_6[1] ^ lambdaReg_6[3] ^ lambdaReg_6[4] ^ lambdaReg_6[5];
   assign lambdaUp_6 [1] = lambdaReg_6[0] ^ lambdaReg_6[2] ^ lambdaReg_6[3];
   assign lambdaUp_6 [2] = lambdaReg_6[1] ^ lambdaReg_6[3] ^ lambdaReg_6[4];
   assign lambdaUp_6 [3] = lambdaReg_6[2] ^ lambdaReg_6[4] ^ lambdaReg_6[5];
   assign lambdaUp_6 [4] = lambdaReg_6[0] ^ lambdaReg_6[1] ^ lambdaReg_6[4];
   assign lambdaUp_6 [5] = lambdaReg_6[0] ^ lambdaReg_6[2] ^ lambdaReg_6[3] ^ lambdaReg_6[4];
   assign lambdaUp_7 [0] = lambdaReg_7[0] ^ lambdaReg_7[2] ^ lambdaReg_7[3] ^ lambdaReg_7[4];
   assign lambdaUp_7 [1] = lambdaReg_7[1] ^ lambdaReg_7[2] ^ lambdaReg_7[5];
   assign lambdaUp_7 [2] = lambdaReg_7[0] ^ lambdaReg_7[2] ^ lambdaReg_7[3];
   assign lambdaUp_7 [3] = lambdaReg_7[1] ^ lambdaReg_7[3] ^ lambdaReg_7[4];
   assign lambdaUp_7 [4] = lambdaReg_7[0] ^ lambdaReg_7[3] ^ lambdaReg_7[5];
   assign lambdaUp_7 [5] = lambdaReg_7[1] ^ lambdaReg_7[2] ^ lambdaReg_7[3];
   assign lambdaUp_8 [0] = lambdaReg_8[1] ^ lambdaReg_8[2] ^ lambdaReg_8[3];
   assign lambdaUp_8 [1] = lambdaReg_8[0] ^ lambdaReg_8[1] ^ lambdaReg_8[4];
   assign lambdaUp_8 [2] = lambdaReg_8[1] ^ lambdaReg_8[2] ^ lambdaReg_8[5];
   assign lambdaUp_8 [3] = lambdaReg_8[0] ^ lambdaReg_8[2] ^ lambdaReg_8[3];
   assign lambdaUp_8 [4] = lambdaReg_8[2] ^ lambdaReg_8[4];
   assign lambdaUp_8 [5] = lambdaReg_8[0] ^ lambdaReg_8[1] ^ lambdaReg_8[2] ^ lambdaReg_8[5];
   assign lambdaUp_9 [0] = lambdaReg_9[0] ^ lambdaReg_9[1] ^ lambdaReg_9[2] ^ lambdaReg_9[5];
   assign lambdaUp_9 [1] = lambdaReg_9[0] ^ lambdaReg_9[3] ^ lambdaReg_9[5];
   assign lambdaUp_9 [2] = lambdaReg_9[0] ^ lambdaReg_9[1] ^ lambdaReg_9[4];
   assign lambdaUp_9 [3] = lambdaReg_9[1] ^ lambdaReg_9[2] ^ lambdaReg_9[5];
   assign lambdaUp_9 [4] = lambdaReg_9[1] ^ lambdaReg_9[3] ^ lambdaReg_9[5];
   assign lambdaUp_9 [5] = lambdaReg_9[0] ^ lambdaReg_9[1] ^ lambdaReg_9[4] ^ lambdaReg_9[5];
   assign lambdaUp_10 [0] = lambdaReg_10[0] ^ lambdaReg_10[1] ^ lambdaReg_10[4] ^ lambdaReg_10[5];
   assign lambdaUp_10 [1] = lambdaReg_10[2] ^ lambdaReg_10[4];
   assign lambdaUp_10 [2] = lambdaReg_10[0] ^ lambdaReg_10[3] ^ lambdaReg_10[5];
   assign lambdaUp_10 [3] = lambdaReg_10[0] ^ lambdaReg_10[1] ^ lambdaReg_10[4];
   assign lambdaUp_10 [4] = lambdaReg_10[0] ^ lambdaReg_10[2] ^ lambdaReg_10[4];
   assign lambdaUp_10 [5] = lambdaReg_10[0] ^ lambdaReg_10[3] ^ lambdaReg_10[4];
   assign lambdaUp_11 [0] = lambdaReg_11[0] ^ lambdaReg_11[3] ^ lambdaReg_11[4];
   assign lambdaUp_11 [1] = lambdaReg_11[1] ^ lambdaReg_11[3] ^ lambdaReg_11[5];
   assign lambdaUp_11 [2] = lambdaReg_11[2] ^ lambdaReg_11[4];
   assign lambdaUp_11 [3] = lambdaReg_11[0] ^ lambdaReg_11[3] ^ lambdaReg_11[5];
   assign lambdaUp_11 [4] = lambdaReg_11[1] ^ lambdaReg_11[3];
   assign lambdaUp_11 [5] = lambdaReg_11[2] ^ lambdaReg_11[3];
   assign lambdaUp_12 [0] = lambdaReg_12[2] ^ lambdaReg_12[3];
   assign lambdaUp_12 [1] = lambdaReg_12[0] ^ lambdaReg_12[2] ^ lambdaReg_12[4];
   assign lambdaUp_12 [2] = lambdaReg_12[1] ^ lambdaReg_12[3] ^ lambdaReg_12[5];
   assign lambdaUp_12 [3] = lambdaReg_12[2] ^ lambdaReg_12[4];
   assign lambdaUp_12 [4] = lambdaReg_12[0] ^ lambdaReg_12[2] ^ lambdaReg_12[5];
   assign lambdaUp_12 [5] = lambdaReg_12[1] ^ lambdaReg_12[2];
   assign lambdaUp_13 [0] = lambdaReg_13[1] ^ lambdaReg_13[2];
   assign lambdaUp_13 [1] = lambdaReg_13[1] ^ lambdaReg_13[3];
   assign lambdaUp_13 [2] = lambdaReg_13[0] ^ lambdaReg_13[2] ^ lambdaReg_13[4];
   assign lambdaUp_13 [3] = lambdaReg_13[1] ^ lambdaReg_13[3] ^ lambdaReg_13[5];
   assign lambdaUp_13 [4] = lambdaReg_13[1] ^ lambdaReg_13[4];
   assign lambdaUp_13 [5] = lambdaReg_13[0] ^ lambdaReg_13[1] ^ lambdaReg_13[5];
   assign lambdaUp_14 [0] = lambdaReg_14[0] ^ lambdaReg_14[1] ^ lambdaReg_14[5];
   assign lambdaUp_14 [1] = lambdaReg_14[0] ^ lambdaReg_14[2] ^ lambdaReg_14[5];
   assign lambdaUp_14 [2] = lambdaReg_14[1] ^ lambdaReg_14[3];
   assign lambdaUp_14 [3] = lambdaReg_14[0] ^ lambdaReg_14[2] ^ lambdaReg_14[4];
   assign lambdaUp_14 [4] = lambdaReg_14[0] ^ lambdaReg_14[3];
   assign lambdaUp_14 [5] = lambdaReg_14[0] ^ lambdaReg_14[4] ^ lambdaReg_14[5];
   assign lambdaUp_15 [0] = lambdaReg_15[0] ^ lambdaReg_15[4] ^ lambdaReg_15[5];
   assign lambdaUp_15 [1] = lambdaReg_15[1] ^ lambdaReg_15[4];
   assign lambdaUp_15 [2] = lambdaReg_15[0] ^ lambdaReg_15[2] ^ lambdaReg_15[5];
   assign lambdaUp_15 [3] = lambdaReg_15[1] ^ lambdaReg_15[3];
   assign lambdaUp_15 [4] = lambdaReg_15[2] ^ lambdaReg_15[5];
   assign lambdaUp_15 [5] = lambdaReg_15[3] ^ lambdaReg_15[4] ^ lambdaReg_15[5];
   assign lambdaUp_16 [0] = lambdaReg_16[3] ^ lambdaReg_16[4] ^ lambdaReg_16[5];
   assign lambdaUp_16 [1] = lambdaReg_16[0] ^ lambdaReg_16[3];
   assign lambdaUp_16 [2] = lambdaReg_16[1] ^ lambdaReg_16[4];
   assign lambdaUp_16 [3] = lambdaReg_16[0] ^ lambdaReg_16[2] ^ lambdaReg_16[5];
   assign lambdaUp_16 [4] = lambdaReg_16[1] ^ lambdaReg_16[4] ^ lambdaReg_16[5];
   assign lambdaUp_16 [5] = lambdaReg_16[2] ^ lambdaReg_16[3] ^ lambdaReg_16[4];
   assign lambdaUp_17 [0] = lambdaReg_17[2] ^ lambdaReg_17[3] ^ lambdaReg_17[4];
   assign lambdaUp_17 [1] = lambdaReg_17[2] ^ lambdaReg_17[5];
   assign lambdaUp_17 [2] = lambdaReg_17[0] ^ lambdaReg_17[3];
   assign lambdaUp_17 [3] = lambdaReg_17[1] ^ lambdaReg_17[4];
   assign lambdaUp_17 [4] = lambdaReg_17[0] ^ lambdaReg_17[3] ^ lambdaReg_17[4] ^ lambdaReg_17[5];
   assign lambdaUp_17 [5] = lambdaReg_17[1] ^ lambdaReg_17[2] ^ lambdaReg_17[3] ^ lambdaReg_17[5];
   assign lambdaUp_18 [0] = lambdaReg_18[1] ^ lambdaReg_18[2] ^ lambdaReg_18[3] ^ lambdaReg_18[5];
   assign lambdaUp_18 [1] = lambdaReg_18[1] ^ lambdaReg_18[4] ^ lambdaReg_18[5];
   assign lambdaUp_18 [2] = lambdaReg_18[2] ^ lambdaReg_18[5];
   assign lambdaUp_18 [3] = lambdaReg_18[0] ^ lambdaReg_18[3];
   assign lambdaUp_18 [4] = lambdaReg_18[2] ^ lambdaReg_18[3] ^ lambdaReg_18[4] ^ lambdaReg_18[5];
   assign lambdaUp_18 [5] = lambdaReg_18[0] ^ lambdaReg_18[1] ^ lambdaReg_18[2] ^ lambdaReg_18[4];
   assign lambdaUp_19 [0] = lambdaReg_19[0] ^ lambdaReg_19[1] ^ lambdaReg_19[2] ^ lambdaReg_19[4];
   assign lambdaUp_19 [1] = lambdaReg_19[0] ^ lambdaReg_19[3] ^ lambdaReg_19[4] ^ lambdaReg_19[5];
   assign lambdaUp_19 [2] = lambdaReg_19[1] ^ lambdaReg_19[4] ^ lambdaReg_19[5];
   assign lambdaUp_19 [3] = lambdaReg_19[2] ^ lambdaReg_19[5];
   assign lambdaUp_19 [4] = lambdaReg_19[1] ^ lambdaReg_19[2] ^ lambdaReg_19[3] ^ lambdaReg_19[4];
   assign lambdaUp_19 [5] = lambdaReg_19[0] ^ lambdaReg_19[1] ^ lambdaReg_19[3] ^ lambdaReg_19[5];



   //------------------------------------------------------------------------
   // + lambdaReg_0,...,lambdaReg_19
   //- registers
   //------------------------------------------------------------------------
   always @(posedge CLK or negedge RESET) begin
      if (~RESET) begin
         lambdaReg_0 [5:0]  <= 6'd0;
         lambdaReg_1 [5:0]  <= 6'd0;
         lambdaReg_2 [5:0]  <= 6'd0;
         lambdaReg_3 [5:0]  <= 6'd0;
         lambdaReg_4 [5:0]  <= 6'd0;
         lambdaReg_5 [5:0]  <= 6'd0;
         lambdaReg_6 [5:0]  <= 6'd0;
         lambdaReg_7 [5:0]  <= 6'd0;
         lambdaReg_8 [5:0]  <= 6'd0;
         lambdaReg_9 [5:0]  <= 6'd0;
         lambdaReg_10 [5:0] <=  6'd0;
         lambdaReg_11 [5:0] <=  6'd0;
         lambdaReg_12 [5:0] <=  6'd0;
         lambdaReg_13 [5:0] <=  6'd0;
         lambdaReg_14 [5:0] <=  6'd0;
         lambdaReg_15 [5:0] <=  6'd0;
         lambdaReg_16 [5:0] <=  6'd0;
         lambdaReg_17 [5:0] <=  6'd0;
         lambdaReg_18 [5:0] <=  6'd0;
         lambdaReg_19 [5:0] <=  6'd0;
      end
      else if (enable == 1'b1) begin
         if (sync == 1'b1) begin
            lambdaReg_0 [5:0]  <= lambdaIni_0 [5:0];
            lambdaReg_1 [5:0]  <= lambdaIni_1 [5:0];
            lambdaReg_2 [5:0]  <= lambdaIni_2 [5:0];
            lambdaReg_3 [5:0]  <= lambdaIni_3 [5:0];
            lambdaReg_4 [5:0]  <= lambdaIni_4 [5:0];
            lambdaReg_5 [5:0]  <= lambdaIni_5 [5:0];
            lambdaReg_6 [5:0]  <= lambdaIni_6 [5:0];
            lambdaReg_7 [5:0]  <= lambdaIni_7 [5:0];
            lambdaReg_8 [5:0]  <= lambdaIni_8 [5:0];
            lambdaReg_9 [5:0]  <= lambdaIni_9 [5:0];
            lambdaReg_10 [5:0] <= lambdaIni_10 [5:0];
            lambdaReg_11 [5:0] <= lambdaIni_11 [5:0];
            lambdaReg_12 [5:0] <= lambdaIni_12 [5:0];
            lambdaReg_13 [5:0] <= lambdaIni_13 [5:0];
            lambdaReg_14 [5:0] <= lambdaIni_14 [5:0];
            lambdaReg_15 [5:0] <= lambdaIni_15 [5:0];
            lambdaReg_16 [5:0] <= lambdaIni_16 [5:0];
            lambdaReg_17 [5:0] <= lambdaIni_17 [5:0];
            lambdaReg_18 [5:0] <= lambdaIni_18 [5:0];
            lambdaReg_19 [5:0] <= lambdaIni_19 [5:0];
        end
        else begin
           lambdaReg_0 [5:0]  <= lambdaUp_0 [5:0];
           lambdaReg_1 [5:0]  <= lambdaUp_1 [5:0];
           lambdaReg_2 [5:0]  <= lambdaUp_2 [5:0];
           lambdaReg_3 [5:0]  <= lambdaUp_3 [5:0];
           lambdaReg_4 [5:0]  <= lambdaUp_4 [5:0];
           lambdaReg_5 [5:0]  <= lambdaUp_5 [5:0];
           lambdaReg_6 [5:0]  <= lambdaUp_6 [5:0];
           lambdaReg_7 [5:0]  <= lambdaUp_7 [5:0];
           lambdaReg_8 [5:0]  <= lambdaUp_8 [5:0];
           lambdaReg_9 [5:0]  <= lambdaUp_9 [5:0];
           lambdaReg_10 [5:0] <= lambdaUp_10 [5:0];
           lambdaReg_11 [5:0] <= lambdaUp_11 [5:0];
           lambdaReg_12 [5:0] <= lambdaUp_12 [5:0];
           lambdaReg_13 [5:0] <= lambdaUp_13 [5:0];
           lambdaReg_14 [5:0] <= lambdaUp_14 [5:0];
           lambdaReg_15 [5:0] <= lambdaUp_15 [5:0];
           lambdaReg_16 [5:0] <= lambdaUp_16 [5:0];
           lambdaReg_17 [5:0] <= lambdaUp_17 [5:0];
           lambdaReg_18 [5:0] <= lambdaUp_18 [5:0];
           lambdaReg_19 [5:0] <= lambdaUp_19 [5:0];
         end
      end
   end



   //------------------------------------------------------------------------
   //- omegaIni
   //------------------------------------------------------------------------
   wire [5:0]  omegaIni_0;
   wire [5:0]  omegaIni_1;
   wire [5:0]  omegaIni_2;
   wire [5:0]  omegaIni_3;
   wire [5:0]  omegaIni_4;
   wire [5:0]  omegaIni_5;
   wire [5:0]  omegaIni_6;
   wire [5:0]  omegaIni_7;
   wire [5:0]  omegaIni_8;
   wire [5:0]  omegaIni_9;
   wire [5:0]  omegaIni_10;
   wire [5:0]  omegaIni_11;
   wire [5:0]  omegaIni_12;
   wire [5:0]  omegaIni_13;
   wire [5:0]  omegaIni_14;
   wire [5:0]  omegaIni_15;
   wire [5:0]  omegaIni_16;
   wire [5:0]  omegaIni_17;
   wire [5:0]  omegaIni_18;
   wire [5:0]  omegaIni_19;


   assign omegaIni_0 [0] = omegaIn_0[0];
   assign omegaIni_0 [1] = omegaIn_0[1];
   assign omegaIni_0 [2] = omegaIn_0[2];
   assign omegaIni_0 [3] = omegaIn_0[3];
   assign omegaIni_0 [4] = omegaIn_0[4];
   assign omegaIni_0 [5] = omegaIn_0[5];
   assign omegaIni_1 [0] = omegaIn_1[0] ^ omegaIn_1[1] ^ omegaIn_1[4] ^ omegaIn_1[5];
   assign omegaIni_1 [1] = omegaIn_1[2] ^ omegaIn_1[4];
   assign omegaIni_1 [2] = omegaIn_1[0] ^ omegaIn_1[3] ^ omegaIn_1[5];
   assign omegaIni_1 [3] = omegaIn_1[0] ^ omegaIn_1[1] ^ omegaIn_1[4];
   assign omegaIni_1 [4] = omegaIn_1[0] ^ omegaIn_1[2] ^ omegaIn_1[4];
   assign omegaIni_1 [5] = omegaIn_1[0] ^ omegaIn_1[3] ^ omegaIn_1[4];
   assign omegaIni_2 [0] = omegaIn_2[0] ^ omegaIn_2[1] ^ omegaIn_2[3] ^ omegaIn_2[5];
   assign omegaIni_2 [1] = omegaIn_2[2] ^ omegaIn_2[3] ^ omegaIn_2[4] ^ omegaIn_2[5];
   assign omegaIni_2 [2] = omegaIn_2[0] ^ omegaIn_2[3] ^ omegaIn_2[4] ^ omegaIn_2[5];
   assign omegaIni_2 [3] = omegaIn_2[1] ^ omegaIn_2[4] ^ omegaIn_2[5];
   assign omegaIni_2 [4] = omegaIn_2[0] ^ omegaIn_2[1] ^ omegaIn_2[2] ^ omegaIn_2[3];
   assign omegaIni_2 [5] = omegaIn_2[0] ^ omegaIn_2[2] ^ omegaIn_2[4] ^ omegaIn_2[5];
   assign omegaIni_3 [0] = omegaIn_3[0] ^ omegaIn_3[2] ^ omegaIn_3[3] ^ omegaIn_3[5];
   assign omegaIni_3 [1] = omegaIn_3[1] ^ omegaIn_3[2] ^ omegaIn_3[4] ^ omegaIn_3[5];
   assign omegaIni_3 [2] = omegaIn_3[2] ^ omegaIn_3[3] ^ omegaIn_3[5];
   assign omegaIni_3 [3] = omegaIn_3[3] ^ omegaIn_3[4];
   assign omegaIni_3 [4] = omegaIn_3[0] ^ omegaIn_3[2] ^ omegaIn_3[3] ^ omegaIn_3[4];
   assign omegaIni_3 [5] = omegaIn_3[1] ^ omegaIn_3[2] ^ omegaIn_3[4];
   assign omegaIni_4 [0] = omegaIn_4[4];
   assign omegaIni_4 [1] = omegaIn_4[0] ^ omegaIn_4[4] ^ omegaIn_4[5];
   assign omegaIni_4 [2] = omegaIn_4[0] ^ omegaIn_4[1] ^ omegaIn_4[5];
   assign omegaIni_4 [3] = omegaIn_4[1] ^ omegaIn_4[2];
   assign omegaIni_4 [4] = omegaIn_4[2] ^ omegaIn_4[3] ^ omegaIn_4[4];
   assign omegaIni_4 [5] = omegaIn_4[3] ^ omegaIn_4[5];
   assign omegaIni_5 [0] = omegaIn_5[0] ^ omegaIn_5[2] ^ omegaIn_5[4];
   assign omegaIni_5 [1] = omegaIn_5[0] ^ omegaIn_5[1] ^ omegaIn_5[2] ^ omegaIn_5[3] ^ omegaIn_5[4] ^ omegaIn_5[5];
   assign omegaIni_5 [2] = omegaIn_5[1] ^ omegaIn_5[2] ^ omegaIn_5[3] ^ omegaIn_5[4] ^ omegaIn_5[5];
   assign omegaIni_5 [3] = omegaIn_5[0] ^ omegaIn_5[2] ^ omegaIn_5[3] ^ omegaIn_5[4] ^ omegaIn_5[5];
   assign omegaIni_5 [4] = omegaIn_5[0] ^ omegaIn_5[1] ^ omegaIn_5[2] ^ omegaIn_5[3] ^ omegaIn_5[5];
   assign omegaIni_5 [5] = omegaIn_5[1] ^ omegaIn_5[3];
   assign omegaIni_6 [0] = omegaIn_6[0] ^ omegaIn_6[1] ^ omegaIn_6[2] ^ omegaIn_6[3];
   assign omegaIni_6 [1] = omegaIn_6[0] ^ omegaIn_6[4];
   assign omegaIni_6 [2] = omegaIn_6[1] ^ omegaIn_6[5];
   assign omegaIni_6 [3] = omegaIn_6[0] ^ omegaIn_6[2];
   assign omegaIni_6 [4] = omegaIn_6[2];
   assign omegaIni_6 [5] = omegaIn_6[0] ^ omegaIn_6[1] ^ omegaIn_6[2];
   assign omegaIni_7 [0] = omegaIn_7[0] ^ omegaIn_7[2] ^ omegaIn_7[3] ^ omegaIn_7[4];
   assign omegaIni_7 [1] = omegaIn_7[1] ^ omegaIn_7[2] ^ omegaIn_7[5];
   assign omegaIni_7 [2] = omegaIn_7[0] ^ omegaIn_7[2] ^ omegaIn_7[3];
   assign omegaIni_7 [3] = omegaIn_7[1] ^ omegaIn_7[3] ^ omegaIn_7[4];
   assign omegaIni_7 [4] = omegaIn_7[0] ^ omegaIn_7[3] ^ omegaIn_7[5];
   assign omegaIni_7 [5] = omegaIn_7[1] ^ omegaIn_7[2] ^ omegaIn_7[3];
   assign omegaIni_8 [0] = omegaIn_8[2] ^ omegaIn_8[3] ^ omegaIn_8[4];
   assign omegaIni_8 [1] = omegaIn_8[2] ^ omegaIn_8[5];
   assign omegaIni_8 [2] = omegaIn_8[0] ^ omegaIn_8[3];
   assign omegaIni_8 [3] = omegaIn_8[1] ^ omegaIn_8[4];
   assign omegaIni_8 [4] = omegaIn_8[0] ^ omegaIn_8[3] ^ omegaIn_8[4] ^ omegaIn_8[5];
   assign omegaIni_8 [5] = omegaIn_8[1] ^ omegaIn_8[2] ^ omegaIn_8[3] ^ omegaIn_8[5];
   assign omegaIni_9 [0] = omegaIn_9[0] ^ omegaIn_9[1] ^ omegaIn_9[2] ^ omegaIn_9[3] ^ omegaIn_9[5];
   assign omegaIni_9 [1] = omegaIn_9[4] ^ omegaIn_9[5];
   assign omegaIni_9 [2] = omegaIn_9[5];
   assign omegaIni_9 [3] = omegaIn_9[0];
   assign omegaIni_9 [4] = omegaIn_9[2] ^ omegaIn_9[3] ^ omegaIn_9[5];
   assign omegaIni_9 [5] = omegaIn_9[0] ^ omegaIn_9[1] ^ omegaIn_9[2] ^ omegaIn_9[4] ^ omegaIn_9[5];
   assign omegaIni_10 [0] = omegaIn_10[2];
   assign omegaIni_10 [1] = omegaIn_10[2] ^ omegaIn_10[3];
   assign omegaIni_10 [2] = omegaIn_10[0] ^ omegaIn_10[3] ^ omegaIn_10[4];
   assign omegaIni_10 [3] = omegaIn_10[0] ^ omegaIn_10[1] ^ omegaIn_10[4] ^ omegaIn_10[5];
   assign omegaIni_10 [4] = omegaIn_10[0] ^ omegaIn_10[1] ^ omegaIn_10[5];
   assign omegaIni_10 [5] = omegaIn_10[1];
   assign omegaIni_11 [0] = omegaIn_11[0] ^ omegaIn_11[3] ^ omegaIn_11[5];
   assign omegaIni_11 [1] = omegaIn_11[1] ^ omegaIn_11[3] ^ omegaIn_11[4] ^ omegaIn_11[5];
   assign omegaIni_11 [2] = omegaIn_11[0] ^ omegaIn_11[2] ^ omegaIn_11[4] ^ omegaIn_11[5];
   assign omegaIni_11 [3] = omegaIn_11[0] ^ omegaIn_11[1] ^ omegaIn_11[3] ^ omegaIn_11[5];
   assign omegaIni_11 [4] = omegaIn_11[1] ^ omegaIn_11[2] ^ omegaIn_11[3] ^ omegaIn_11[4] ^ omegaIn_11[5];
   assign omegaIni_11 [5] = omegaIn_11[2] ^ omegaIn_11[4];
   assign omegaIni_12 [0] = omegaIn_12[0] ^ omegaIn_12[3] ^ omegaIn_12[4] ^ omegaIn_12[5];
   assign omegaIni_12 [1] = omegaIn_12[0] ^ omegaIn_12[1] ^ omegaIn_12[3];
   assign omegaIni_12 [2] = omegaIn_12[1] ^ omegaIn_12[2] ^ omegaIn_12[4];
   assign omegaIni_12 [3] = omegaIn_12[0] ^ omegaIn_12[2] ^ omegaIn_12[3] ^ omegaIn_12[5];
   assign omegaIni_12 [4] = omegaIn_12[1] ^ omegaIn_12[5];
   assign omegaIni_12 [5] = omegaIn_12[2] ^ omegaIn_12[3] ^ omegaIn_12[4] ^ omegaIn_12[5];
   assign omegaIni_13 [0] = omegaIn_13[2] ^ omegaIn_13[3] ^ omegaIn_13[5];
   assign omegaIni_13 [1] = omegaIn_13[2] ^ omegaIn_13[4] ^ omegaIn_13[5];
   assign omegaIni_13 [2] = omegaIn_13[3] ^ omegaIn_13[5];
   assign omegaIni_13 [3] = omegaIn_13[4];
   assign omegaIni_13 [4] = omegaIn_13[0] ^ omegaIn_13[2] ^ omegaIn_13[3];
   assign omegaIni_13 [5] = omegaIn_13[1] ^ omegaIn_13[2] ^ omegaIn_13[4] ^ omegaIn_13[5];
   assign omegaIni_14 [0] = omegaIn_14[0] ^ omegaIn_14[1] ^ omegaIn_14[5];
   assign omegaIni_14 [1] = omegaIn_14[0] ^ omegaIn_14[2] ^ omegaIn_14[5];
   assign omegaIni_14 [2] = omegaIn_14[1] ^ omegaIn_14[3];
   assign omegaIni_14 [3] = omegaIn_14[0] ^ omegaIn_14[2] ^ omegaIn_14[4];
   assign omegaIni_14 [4] = omegaIn_14[0] ^ omegaIn_14[3];
   assign omegaIni_14 [5] = omegaIn_14[0] ^ omegaIn_14[4] ^ omegaIn_14[5];
   assign omegaIni_15 [0] = omegaIn_15[1] ^ omegaIn_15[2] ^ omegaIn_15[3] ^ omegaIn_15[4] ^ omegaIn_15[5];
   assign omegaIni_15 [1] = omegaIn_15[0] ^ omegaIn_15[1];
   assign omegaIni_15 [2] = omegaIn_15[0] ^ omegaIn_15[1] ^ omegaIn_15[2];
   assign omegaIni_15 [3] = omegaIn_15[0] ^ omegaIn_15[1] ^ omegaIn_15[2] ^ omegaIn_15[3];
   assign omegaIni_15 [4] = omegaIn_15[5];
   assign omegaIni_15 [5] = omegaIn_15[0] ^ omegaIn_15[1] ^ omegaIn_15[2] ^ omegaIn_15[3] ^ omegaIn_15[4] ^ omegaIn_15[5];
   assign omegaIni_16 [0] = omegaIn_16[1] ^ omegaIn_16[5];
   assign omegaIni_16 [1] = omegaIn_16[0] ^ omegaIn_16[1] ^ omegaIn_16[2] ^ omegaIn_16[5];
   assign omegaIni_16 [2] = omegaIn_16[1] ^ omegaIn_16[2] ^ omegaIn_16[3];
   assign omegaIni_16 [3] = omegaIn_16[0] ^ omegaIn_16[2] ^ omegaIn_16[3] ^ omegaIn_16[4];
   assign omegaIni_16 [4] = omegaIn_16[0] ^ omegaIn_16[3] ^ omegaIn_16[4];
   assign omegaIni_16 [5] = omegaIn_16[0] ^ omegaIn_16[4];
   assign omegaIni_17 [0] = omegaIn_17[0] ^ omegaIn_17[2] ^ omegaIn_17[3];
   assign omegaIni_17 [1] = omegaIn_17[0] ^ omegaIn_17[1] ^ omegaIn_17[2] ^ omegaIn_17[4];
   assign omegaIni_17 [2] = omegaIn_17[1] ^ omegaIn_17[2] ^ omegaIn_17[3] ^ omegaIn_17[5];
   assign omegaIni_17 [3] = omegaIn_17[2] ^ omegaIn_17[3] ^ omegaIn_17[4];
   assign omegaIni_17 [4] = omegaIn_17[0] ^ omegaIn_17[2] ^ omegaIn_17[4] ^ omegaIn_17[5];
   assign omegaIni_17 [5] = omegaIn_17[1] ^ omegaIn_17[2] ^ omegaIn_17[5];
   assign omegaIni_18 [0] = omegaIn_18[0] ^ omegaIn_18[3];
   assign omegaIni_18 [1] = omegaIn_18[0] ^ omegaIn_18[1] ^ omegaIn_18[3] ^ omegaIn_18[4];
   assign omegaIni_18 [2] = omegaIn_18[0] ^ omegaIn_18[1] ^ omegaIn_18[2] ^ omegaIn_18[4] ^ omegaIn_18[5];
   assign omegaIni_18 [3] = omegaIn_18[0] ^ omegaIn_18[1] ^ omegaIn_18[2] ^ omegaIn_18[3] ^ omegaIn_18[5];
   assign omegaIni_18 [4] = omegaIn_18[1] ^ omegaIn_18[2] ^ omegaIn_18[4];
   assign omegaIni_18 [5] = omegaIn_18[2] ^ omegaIn_18[5];
   assign omegaIni_19 [0] = omegaIn_19[5];
   assign omegaIni_19 [1] = omegaIn_19[0] ^ omegaIn_19[5];
   assign omegaIni_19 [2] = omegaIn_19[1];
   assign omegaIni_19 [3] = omegaIn_19[2];
   assign omegaIni_19 [4] = omegaIn_19[3] ^ omegaIn_19[5];
   assign omegaIni_19 [5] = omegaIn_19[4] ^ omegaIn_19[5];



   //------------------------------------------------------------------------
   //- omegaNew
   //------------------------------------------------------------------------
   reg [5:0]  omegaReg_0;
   reg [5:0]  omegaReg_1;
   reg [5:0]  omegaReg_2;
   reg [5:0]  omegaReg_3;
   reg [5:0]  omegaReg_4;
   reg [5:0]  omegaReg_5;
   reg [5:0]  omegaReg_6;
   reg [5:0]  omegaReg_7;
   reg [5:0]  omegaReg_8;
   reg [5:0]  omegaReg_9;
   reg [5:0]  omegaReg_10;
   reg [5:0]  omegaReg_11;
   reg [5:0]  omegaReg_12;
   reg [5:0]  omegaReg_13;
   reg [5:0]  omegaReg_14;
   reg [5:0]  omegaReg_15;
   reg [5:0]  omegaReg_16;
   reg [5:0]  omegaReg_17;
   reg [5:0]  omegaReg_18;
   reg [5:0]  omegaReg_19;
   wire [5:0]  omegaNew_0;
   wire [5:0]  omegaNew_1;
   wire [5:0]  omegaNew_2;
   wire [5:0]  omegaNew_3;
   wire [5:0]  omegaNew_4;
   wire [5:0]  omegaNew_5;
   wire [5:0]  omegaNew_6;
   wire [5:0]  omegaNew_7;
   wire [5:0]  omegaNew_8;
   wire [5:0]  omegaNew_9;
   wire [5:0]  omegaNew_10;
   wire [5:0]  omegaNew_11;
   wire [5:0]  omegaNew_12;
   wire [5:0]  omegaNew_13;
   wire [5:0]  omegaNew_14;
   wire [5:0]  omegaNew_15;
   wire [5:0]  omegaNew_16;
   wire [5:0]  omegaNew_17;
   wire [5:0]  omegaNew_18;
   wire [5:0]  omegaNew_19;


   assign omegaNew_0 [0] = omegaReg_0[0];
   assign omegaNew_0 [1] = omegaReg_0[1];
   assign omegaNew_0 [2] = omegaReg_0[2];
   assign omegaNew_0 [3] = omegaReg_0[3];
   assign omegaNew_0 [4] = omegaReg_0[4];
   assign omegaNew_0 [5] = omegaReg_0[5];
   assign omegaNew_1 [0] = omegaReg_1[5];
   assign omegaNew_1 [1] = omegaReg_1[0] ^ omegaReg_1[5];
   assign omegaNew_1 [2] = omegaReg_1[1];
   assign omegaNew_1 [3] = omegaReg_1[2];
   assign omegaNew_1 [4] = omegaReg_1[3] ^ omegaReg_1[5];
   assign omegaNew_1 [5] = omegaReg_1[4] ^ omegaReg_1[5];
   assign omegaNew_2 [0] = omegaReg_2[4] ^ omegaReg_2[5];
   assign omegaNew_2 [1] = omegaReg_2[4];
   assign omegaNew_2 [2] = omegaReg_2[0] ^ omegaReg_2[5];
   assign omegaNew_2 [3] = omegaReg_2[1];
   assign omegaNew_2 [4] = omegaReg_2[2] ^ omegaReg_2[4] ^ omegaReg_2[5];
   assign omegaNew_2 [5] = omegaReg_2[3] ^ omegaReg_2[4];
   assign omegaNew_3 [0] = omegaReg_3[3] ^ omegaReg_3[4];
   assign omegaNew_3 [1] = omegaReg_3[3] ^ omegaReg_3[5];
   assign omegaNew_3 [2] = omegaReg_3[4];
   assign omegaNew_3 [3] = omegaReg_3[0] ^ omegaReg_3[5];
   assign omegaNew_3 [4] = omegaReg_3[1] ^ omegaReg_3[3] ^ omegaReg_3[4];
   assign omegaNew_3 [5] = omegaReg_3[2] ^ omegaReg_3[3] ^ omegaReg_3[5];
   assign omegaNew_4 [0] = omegaReg_4[2] ^ omegaReg_4[3] ^ omegaReg_4[5];
   assign omegaNew_4 [1] = omegaReg_4[2] ^ omegaReg_4[4] ^ omegaReg_4[5];
   assign omegaNew_4 [2] = omegaReg_4[3] ^ omegaReg_4[5];
   assign omegaNew_4 [3] = omegaReg_4[4];
   assign omegaNew_4 [4] = omegaReg_4[0] ^ omegaReg_4[2] ^ omegaReg_4[3];
   assign omegaNew_4 [5] = omegaReg_4[1] ^ omegaReg_4[2] ^ omegaReg_4[4] ^ omegaReg_4[5];
   assign omegaNew_5 [0] = omegaReg_5[1] ^ omegaReg_5[2] ^ omegaReg_5[4] ^ omegaReg_5[5];
   assign omegaNew_5 [1] = omegaReg_5[1] ^ omegaReg_5[3] ^ omegaReg_5[4];
   assign omegaNew_5 [2] = omegaReg_5[2] ^ omegaReg_5[4] ^ omegaReg_5[5];
   assign omegaNew_5 [3] = omegaReg_5[3] ^ omegaReg_5[5];
   assign omegaNew_5 [4] = omegaReg_5[1] ^ omegaReg_5[2] ^ omegaReg_5[5];
   assign omegaNew_5 [5] = omegaReg_5[0] ^ omegaReg_5[1] ^ omegaReg_5[3] ^ omegaReg_5[4] ^ omegaReg_5[5];
   assign omegaNew_6 [0] = omegaReg_6[0] ^ omegaReg_6[1] ^ omegaReg_6[3] ^ omegaReg_6[4] ^ omegaReg_6[5];
   assign omegaNew_6 [1] = omegaReg_6[0] ^ omegaReg_6[2] ^ omegaReg_6[3];
   assign omegaNew_6 [2] = omegaReg_6[1] ^ omegaReg_6[3] ^ omegaReg_6[4];
   assign omegaNew_6 [3] = omegaReg_6[2] ^ omegaReg_6[4] ^ omegaReg_6[5];
   assign omegaNew_6 [4] = omegaReg_6[0] ^ omegaReg_6[1] ^ omegaReg_6[4];
   assign omegaNew_6 [5] = omegaReg_6[0] ^ omegaReg_6[2] ^ omegaReg_6[3] ^ omegaReg_6[4];
   assign omegaNew_7 [0] = omegaReg_7[0] ^ omegaReg_7[2] ^ omegaReg_7[3] ^ omegaReg_7[4];
   assign omegaNew_7 [1] = omegaReg_7[1] ^ omegaReg_7[2] ^ omegaReg_7[5];
   assign omegaNew_7 [2] = omegaReg_7[0] ^ omegaReg_7[2] ^ omegaReg_7[3];
   assign omegaNew_7 [3] = omegaReg_7[1] ^ omegaReg_7[3] ^ omegaReg_7[4];
   assign omegaNew_7 [4] = omegaReg_7[0] ^ omegaReg_7[3] ^ omegaReg_7[5];
   assign omegaNew_7 [5] = omegaReg_7[1] ^ omegaReg_7[2] ^ omegaReg_7[3];
   assign omegaNew_8 [0] = omegaReg_8[1] ^ omegaReg_8[2] ^ omegaReg_8[3];
   assign omegaNew_8 [1] = omegaReg_8[0] ^ omegaReg_8[1] ^ omegaReg_8[4];
   assign omegaNew_8 [2] = omegaReg_8[1] ^ omegaReg_8[2] ^ omegaReg_8[5];
   assign omegaNew_8 [3] = omegaReg_8[0] ^ omegaReg_8[2] ^ omegaReg_8[3];
   assign omegaNew_8 [4] = omegaReg_8[2] ^ omegaReg_8[4];
   assign omegaNew_8 [5] = omegaReg_8[0] ^ omegaReg_8[1] ^ omegaReg_8[2] ^ omegaReg_8[5];
   assign omegaNew_9 [0] = omegaReg_9[0] ^ omegaReg_9[1] ^ omegaReg_9[2] ^ omegaReg_9[5];
   assign omegaNew_9 [1] = omegaReg_9[0] ^ omegaReg_9[3] ^ omegaReg_9[5];
   assign omegaNew_9 [2] = omegaReg_9[0] ^ omegaReg_9[1] ^ omegaReg_9[4];
   assign omegaNew_9 [3] = omegaReg_9[1] ^ omegaReg_9[2] ^ omegaReg_9[5];
   assign omegaNew_9 [4] = omegaReg_9[1] ^ omegaReg_9[3] ^ omegaReg_9[5];
   assign omegaNew_9 [5] = omegaReg_9[0] ^ omegaReg_9[1] ^ omegaReg_9[4] ^ omegaReg_9[5];
   assign omegaNew_10 [0] = omegaReg_10[0] ^ omegaReg_10[1] ^ omegaReg_10[4] ^ omegaReg_10[5];
   assign omegaNew_10 [1] = omegaReg_10[2] ^ omegaReg_10[4];
   assign omegaNew_10 [2] = omegaReg_10[0] ^ omegaReg_10[3] ^ omegaReg_10[5];
   assign omegaNew_10 [3] = omegaReg_10[0] ^ omegaReg_10[1] ^ omegaReg_10[4];
   assign omegaNew_10 [4] = omegaReg_10[0] ^ omegaReg_10[2] ^ omegaReg_10[4];
   assign omegaNew_10 [5] = omegaReg_10[0] ^ omegaReg_10[3] ^ omegaReg_10[4];
   assign omegaNew_11 [0] = omegaReg_11[0] ^ omegaReg_11[3] ^ omegaReg_11[4];
   assign omegaNew_11 [1] = omegaReg_11[1] ^ omegaReg_11[3] ^ omegaReg_11[5];
   assign omegaNew_11 [2] = omegaReg_11[2] ^ omegaReg_11[4];
   assign omegaNew_11 [3] = omegaReg_11[0] ^ omegaReg_11[3] ^ omegaReg_11[5];
   assign omegaNew_11 [4] = omegaReg_11[1] ^ omegaReg_11[3];
   assign omegaNew_11 [5] = omegaReg_11[2] ^ omegaReg_11[3];
   assign omegaNew_12 [0] = omegaReg_12[2] ^ omegaReg_12[3];
   assign omegaNew_12 [1] = omegaReg_12[0] ^ omegaReg_12[2] ^ omegaReg_12[4];
   assign omegaNew_12 [2] = omegaReg_12[1] ^ omegaReg_12[3] ^ omegaReg_12[5];
   assign omegaNew_12 [3] = omegaReg_12[2] ^ omegaReg_12[4];
   assign omegaNew_12 [4] = omegaReg_12[0] ^ omegaReg_12[2] ^ omegaReg_12[5];
   assign omegaNew_12 [5] = omegaReg_12[1] ^ omegaReg_12[2];
   assign omegaNew_13 [0] = omegaReg_13[1] ^ omegaReg_13[2];
   assign omegaNew_13 [1] = omegaReg_13[1] ^ omegaReg_13[3];
   assign omegaNew_13 [2] = omegaReg_13[0] ^ omegaReg_13[2] ^ omegaReg_13[4];
   assign omegaNew_13 [3] = omegaReg_13[1] ^ omegaReg_13[3] ^ omegaReg_13[5];
   assign omegaNew_13 [4] = omegaReg_13[1] ^ omegaReg_13[4];
   assign omegaNew_13 [5] = omegaReg_13[0] ^ omegaReg_13[1] ^ omegaReg_13[5];
   assign omegaNew_14 [0] = omegaReg_14[0] ^ omegaReg_14[1] ^ omegaReg_14[5];
   assign omegaNew_14 [1] = omegaReg_14[0] ^ omegaReg_14[2] ^ omegaReg_14[5];
   assign omegaNew_14 [2] = omegaReg_14[1] ^ omegaReg_14[3];
   assign omegaNew_14 [3] = omegaReg_14[0] ^ omegaReg_14[2] ^ omegaReg_14[4];
   assign omegaNew_14 [4] = omegaReg_14[0] ^ omegaReg_14[3];
   assign omegaNew_14 [5] = omegaReg_14[0] ^ omegaReg_14[4] ^ omegaReg_14[5];
   assign omegaNew_15 [0] = omegaReg_15[0] ^ omegaReg_15[4] ^ omegaReg_15[5];
   assign omegaNew_15 [1] = omegaReg_15[1] ^ omegaReg_15[4];
   assign omegaNew_15 [2] = omegaReg_15[0] ^ omegaReg_15[2] ^ omegaReg_15[5];
   assign omegaNew_15 [3] = omegaReg_15[1] ^ omegaReg_15[3];
   assign omegaNew_15 [4] = omegaReg_15[2] ^ omegaReg_15[5];
   assign omegaNew_15 [5] = omegaReg_15[3] ^ omegaReg_15[4] ^ omegaReg_15[5];
   assign omegaNew_16 [0] = omegaReg_16[3] ^ omegaReg_16[4] ^ omegaReg_16[5];
   assign omegaNew_16 [1] = omegaReg_16[0] ^ omegaReg_16[3];
   assign omegaNew_16 [2] = omegaReg_16[1] ^ omegaReg_16[4];
   assign omegaNew_16 [3] = omegaReg_16[0] ^ omegaReg_16[2] ^ omegaReg_16[5];
   assign omegaNew_16 [4] = omegaReg_16[1] ^ omegaReg_16[4] ^ omegaReg_16[5];
   assign omegaNew_16 [5] = omegaReg_16[2] ^ omegaReg_16[3] ^ omegaReg_16[4];
   assign omegaNew_17 [0] = omegaReg_17[2] ^ omegaReg_17[3] ^ omegaReg_17[4];
   assign omegaNew_17 [1] = omegaReg_17[2] ^ omegaReg_17[5];
   assign omegaNew_17 [2] = omegaReg_17[0] ^ omegaReg_17[3];
   assign omegaNew_17 [3] = omegaReg_17[1] ^ omegaReg_17[4];
   assign omegaNew_17 [4] = omegaReg_17[0] ^ omegaReg_17[3] ^ omegaReg_17[4] ^ omegaReg_17[5];
   assign omegaNew_17 [5] = omegaReg_17[1] ^ omegaReg_17[2] ^ omegaReg_17[3] ^ omegaReg_17[5];
   assign omegaNew_18 [0] = omegaReg_18[1] ^ omegaReg_18[2] ^ omegaReg_18[3] ^ omegaReg_18[5];
   assign omegaNew_18 [1] = omegaReg_18[1] ^ omegaReg_18[4] ^ omegaReg_18[5];
   assign omegaNew_18 [2] = omegaReg_18[2] ^ omegaReg_18[5];
   assign omegaNew_18 [3] = omegaReg_18[0] ^ omegaReg_18[3];
   assign omegaNew_18 [4] = omegaReg_18[2] ^ omegaReg_18[3] ^ omegaReg_18[4] ^ omegaReg_18[5];
   assign omegaNew_18 [5] = omegaReg_18[0] ^ omegaReg_18[1] ^ omegaReg_18[2] ^ omegaReg_18[4];
   assign omegaNew_19 [0] = omegaReg_19[0] ^ omegaReg_19[1] ^ omegaReg_19[2] ^ omegaReg_19[4];
   assign omegaNew_19 [1] = omegaReg_19[0] ^ omegaReg_19[3] ^ omegaReg_19[4] ^ omegaReg_19[5];
   assign omegaNew_19 [2] = omegaReg_19[1] ^ omegaReg_19[4] ^ omegaReg_19[5];
   assign omegaNew_19 [3] = omegaReg_19[2] ^ omegaReg_19[5];
   assign omegaNew_19 [4] = omegaReg_19[1] ^ omegaReg_19[2] ^ omegaReg_19[3] ^ omegaReg_19[4];
   assign omegaNew_19 [5] = omegaReg_19[0] ^ omegaReg_19[1] ^ omegaReg_19[3] ^ omegaReg_19[5];



   //------------------------------------------------------------------
   // + omegaReg_0,..., omegaReg_19
   //- registers
   //------------------------------------------------------------------
   always @(posedge CLK or negedge RESET) begin
      if (~RESET) begin
         omegaReg_0 [5:0]  <= 6'd0;
         omegaReg_1 [5:0]  <= 6'd0;
         omegaReg_2 [5:0]  <= 6'd0;
         omegaReg_3 [5:0]  <= 6'd0;
         omegaReg_4 [5:0]  <= 6'd0;
         omegaReg_5 [5:0]  <= 6'd0;
         omegaReg_6 [5:0]  <= 6'd0;
         omegaReg_7 [5:0]  <= 6'd0;
         omegaReg_8 [5:0]  <= 6'd0;
         omegaReg_9 [5:0]  <= 6'd0;
         omegaReg_10 [5:0] <= 6'd0;
         omegaReg_11 [5:0] <= 6'd0;
         omegaReg_12 [5:0] <= 6'd0;
         omegaReg_13 [5:0] <= 6'd0;
         omegaReg_14 [5:0] <= 6'd0;
         omegaReg_15 [5:0] <= 6'd0;
         omegaReg_16 [5:0] <= 6'd0;
         omegaReg_17 [5:0] <= 6'd0;
         omegaReg_18 [5:0] <= 6'd0;
         omegaReg_19 [5:0] <= 6'd0;
      end
      else if (enable == 1'b1) begin
         if (sync == 1'b1) begin
            omegaReg_0 [5:0]  <= omegaIni_0 [5:0];
            omegaReg_1 [5:0]  <= omegaIni_1 [5:0];
            omegaReg_2 [5:0]  <= omegaIni_2 [5:0];
            omegaReg_3 [5:0]  <= omegaIni_3 [5:0];
            omegaReg_4 [5:0]  <= omegaIni_4 [5:0];
            omegaReg_5 [5:0]  <= omegaIni_5 [5:0];
            omegaReg_6 [5:0]  <= omegaIni_6 [5:0];
            omegaReg_7 [5:0]  <= omegaIni_7 [5:0];
            omegaReg_8 [5:0]  <= omegaIni_8 [5:0];
            omegaReg_9 [5:0]  <= omegaIni_9 [5:0];
            omegaReg_10 [5:0] <= omegaIni_10 [5:0];
            omegaReg_11 [5:0] <= omegaIni_11 [5:0];
            omegaReg_12 [5:0] <= omegaIni_12 [5:0];
            omegaReg_13 [5:0] <= omegaIni_13 [5:0];
            omegaReg_14 [5:0] <= omegaIni_14 [5:0];
            omegaReg_15 [5:0] <= omegaIni_15 [5:0];
            omegaReg_16 [5:0] <= omegaIni_16 [5:0];
            omegaReg_17 [5:0] <= omegaIni_17 [5:0];
            omegaReg_18 [5:0] <= omegaIni_18 [5:0];
            omegaReg_19 [5:0] <= omegaIni_19 [5:0];
         end
         else begin
            omegaReg_0 [5:0]  <= omegaNew_0 [5:0];
            omegaReg_1 [5:0]  <= omegaNew_1 [5:0];
            omegaReg_2 [5:0]  <= omegaNew_2 [5:0];
            omegaReg_3 [5:0]  <= omegaNew_3 [5:0];
            omegaReg_4 [5:0]  <= omegaNew_4 [5:0];
            omegaReg_5 [5:0]  <= omegaNew_5 [5:0];
            omegaReg_6 [5:0]  <= omegaNew_6 [5:0];
            omegaReg_7 [5:0]  <= omegaNew_7 [5:0];
            omegaReg_8 [5:0]  <= omegaNew_8 [5:0];
            omegaReg_9 [5:0]  <= omegaNew_9 [5:0];
            omegaReg_10 [5:0] <= omegaNew_10 [5:0];
            omegaReg_11 [5:0] <= omegaNew_11 [5:0];
            omegaReg_12 [5:0] <= omegaNew_12 [5:0];
            omegaReg_13 [5:0] <= omegaNew_13 [5:0];
            omegaReg_14 [5:0] <= omegaNew_14 [5:0];
            omegaReg_15 [5:0] <= omegaNew_15 [5:0];
            omegaReg_16 [5:0] <= omegaNew_16 [5:0];
            omegaReg_17 [5:0] <= omegaNew_17 [5:0];
            omegaReg_18 [5:0] <= omegaNew_18 [5:0];
            omegaReg_19 [5:0] <= omegaNew_19 [5:0];
         end
      end
   end



   //------------------------------------------------------------------------
   //- epsilonIni
   //------------------------------------------------------------------------
   wire [5:0]  epsilonIni_0;
   wire [5:0]  epsilonIni_1;
   wire [5:0]  epsilonIni_2;
   wire [5:0]  epsilonIni_3;
   wire [5:0]  epsilonIni_4;
   wire [5:0]  epsilonIni_5;
   wire [5:0]  epsilonIni_6;
   wire [5:0]  epsilonIni_7;
   wire [5:0]  epsilonIni_8;
   wire [5:0]  epsilonIni_9;
   wire [5:0]  epsilonIni_10;
   wire [5:0]  epsilonIni_11;
   wire [5:0]  epsilonIni_12;
   wire [5:0]  epsilonIni_13;
   wire [5:0]  epsilonIni_14;
   wire [5:0]  epsilonIni_15;
   wire [5:0]  epsilonIni_16;
   wire [5:0]  epsilonIni_17;
   wire [5:0]  epsilonIni_18;
   wire [5:0]  epsilonIni_19;
   wire [5:0]  epsilonIni_20;


   assign epsilonIni_0 [0] = epsilonIn_0[0];
   assign epsilonIni_0 [1] = epsilonIn_0[1];
   assign epsilonIni_0 [2] = epsilonIn_0[2];
   assign epsilonIni_0 [3] = epsilonIn_0[3];
   assign epsilonIni_0 [4] = epsilonIn_0[4];
   assign epsilonIni_0 [5] = epsilonIn_0[5];
   assign epsilonIni_1 [0] = epsilonIn_1[0] ^ epsilonIn_1[1] ^ epsilonIn_1[4] ^ epsilonIn_1[5];
   assign epsilonIni_1 [1] = epsilonIn_1[2] ^ epsilonIn_1[4];
   assign epsilonIni_1 [2] = epsilonIn_1[0] ^ epsilonIn_1[3] ^ epsilonIn_1[5];
   assign epsilonIni_1 [3] = epsilonIn_1[0] ^ epsilonIn_1[1] ^ epsilonIn_1[4];
   assign epsilonIni_1 [4] = epsilonIn_1[0] ^ epsilonIn_1[2] ^ epsilonIn_1[4];
   assign epsilonIni_1 [5] = epsilonIn_1[0] ^ epsilonIn_1[3] ^ epsilonIn_1[4];
   assign epsilonIni_2 [0] = epsilonIn_2[0] ^ epsilonIn_2[1] ^ epsilonIn_2[3] ^ epsilonIn_2[5];
   assign epsilonIni_2 [1] = epsilonIn_2[2] ^ epsilonIn_2[3] ^ epsilonIn_2[4] ^ epsilonIn_2[5];
   assign epsilonIni_2 [2] = epsilonIn_2[0] ^ epsilonIn_2[3] ^ epsilonIn_2[4] ^ epsilonIn_2[5];
   assign epsilonIni_2 [3] = epsilonIn_2[1] ^ epsilonIn_2[4] ^ epsilonIn_2[5];
   assign epsilonIni_2 [4] = epsilonIn_2[0] ^ epsilonIn_2[1] ^ epsilonIn_2[2] ^ epsilonIn_2[3];
   assign epsilonIni_2 [5] = epsilonIn_2[0] ^ epsilonIn_2[2] ^ epsilonIn_2[4] ^ epsilonIn_2[5];
   assign epsilonIni_3 [0] = epsilonIn_3[0] ^ epsilonIn_3[2] ^ epsilonIn_3[3] ^ epsilonIn_3[5];
   assign epsilonIni_3 [1] = epsilonIn_3[1] ^ epsilonIn_3[2] ^ epsilonIn_3[4] ^ epsilonIn_3[5];
   assign epsilonIni_3 [2] = epsilonIn_3[2] ^ epsilonIn_3[3] ^ epsilonIn_3[5];
   assign epsilonIni_3 [3] = epsilonIn_3[3] ^ epsilonIn_3[4];
   assign epsilonIni_3 [4] = epsilonIn_3[0] ^ epsilonIn_3[2] ^ epsilonIn_3[3] ^ epsilonIn_3[4];
   assign epsilonIni_3 [5] = epsilonIn_3[1] ^ epsilonIn_3[2] ^ epsilonIn_3[4];
   assign epsilonIni_4 [0] = epsilonIn_4[4];
   assign epsilonIni_4 [1] = epsilonIn_4[0] ^ epsilonIn_4[4] ^ epsilonIn_4[5];
   assign epsilonIni_4 [2] = epsilonIn_4[0] ^ epsilonIn_4[1] ^ epsilonIn_4[5];
   assign epsilonIni_4 [3] = epsilonIn_4[1] ^ epsilonIn_4[2];
   assign epsilonIni_4 [4] = epsilonIn_4[2] ^ epsilonIn_4[3] ^ epsilonIn_4[4];
   assign epsilonIni_4 [5] = epsilonIn_4[3] ^ epsilonIn_4[5];
   assign epsilonIni_5 [0] = epsilonIn_5[0] ^ epsilonIn_5[2] ^ epsilonIn_5[4];
   assign epsilonIni_5 [1] = epsilonIn_5[0] ^ epsilonIn_5[1] ^ epsilonIn_5[2] ^ epsilonIn_5[3] ^ epsilonIn_5[4] ^ epsilonIn_5[5];
   assign epsilonIni_5 [2] = epsilonIn_5[1] ^ epsilonIn_5[2] ^ epsilonIn_5[3] ^ epsilonIn_5[4] ^ epsilonIn_5[5];
   assign epsilonIni_5 [3] = epsilonIn_5[0] ^ epsilonIn_5[2] ^ epsilonIn_5[3] ^ epsilonIn_5[4] ^ epsilonIn_5[5];
   assign epsilonIni_5 [4] = epsilonIn_5[0] ^ epsilonIn_5[1] ^ epsilonIn_5[2] ^ epsilonIn_5[3] ^ epsilonIn_5[5];
   assign epsilonIni_5 [5] = epsilonIn_5[1] ^ epsilonIn_5[3];
   assign epsilonIni_6 [0] = epsilonIn_6[0] ^ epsilonIn_6[1] ^ epsilonIn_6[2] ^ epsilonIn_6[3];
   assign epsilonIni_6 [1] = epsilonIn_6[0] ^ epsilonIn_6[4];
   assign epsilonIni_6 [2] = epsilonIn_6[1] ^ epsilonIn_6[5];
   assign epsilonIni_6 [3] = epsilonIn_6[0] ^ epsilonIn_6[2];
   assign epsilonIni_6 [4] = epsilonIn_6[2];
   assign epsilonIni_6 [5] = epsilonIn_6[0] ^ epsilonIn_6[1] ^ epsilonIn_6[2];
   assign epsilonIni_7 [0] = epsilonIn_7[0] ^ epsilonIn_7[2] ^ epsilonIn_7[3] ^ epsilonIn_7[4];
   assign epsilonIni_7 [1] = epsilonIn_7[1] ^ epsilonIn_7[2] ^ epsilonIn_7[5];
   assign epsilonIni_7 [2] = epsilonIn_7[0] ^ epsilonIn_7[2] ^ epsilonIn_7[3];
   assign epsilonIni_7 [3] = epsilonIn_7[1] ^ epsilonIn_7[3] ^ epsilonIn_7[4];
   assign epsilonIni_7 [4] = epsilonIn_7[0] ^ epsilonIn_7[3] ^ epsilonIn_7[5];
   assign epsilonIni_7 [5] = epsilonIn_7[1] ^ epsilonIn_7[2] ^ epsilonIn_7[3];
   assign epsilonIni_8 [0] = epsilonIn_8[2] ^ epsilonIn_8[3] ^ epsilonIn_8[4];
   assign epsilonIni_8 [1] = epsilonIn_8[2] ^ epsilonIn_8[5];
   assign epsilonIni_8 [2] = epsilonIn_8[0] ^ epsilonIn_8[3];
   assign epsilonIni_8 [3] = epsilonIn_8[1] ^ epsilonIn_8[4];
   assign epsilonIni_8 [4] = epsilonIn_8[0] ^ epsilonIn_8[3] ^ epsilonIn_8[4] ^ epsilonIn_8[5];
   assign epsilonIni_8 [5] = epsilonIn_8[1] ^ epsilonIn_8[2] ^ epsilonIn_8[3] ^ epsilonIn_8[5];
   assign epsilonIni_9 [0] = epsilonIn_9[0] ^ epsilonIn_9[1] ^ epsilonIn_9[2] ^ epsilonIn_9[3] ^ epsilonIn_9[5];
   assign epsilonIni_9 [1] = epsilonIn_9[4] ^ epsilonIn_9[5];
   assign epsilonIni_9 [2] = epsilonIn_9[5];
   assign epsilonIni_9 [3] = epsilonIn_9[0];
   assign epsilonIni_9 [4] = epsilonIn_9[2] ^ epsilonIn_9[3] ^ epsilonIn_9[5];
   assign epsilonIni_9 [5] = epsilonIn_9[0] ^ epsilonIn_9[1] ^ epsilonIn_9[2] ^ epsilonIn_9[4] ^ epsilonIn_9[5];
   assign epsilonIni_10 [0] = epsilonIn_10[2];
   assign epsilonIni_10 [1] = epsilonIn_10[2] ^ epsilonIn_10[3];
   assign epsilonIni_10 [2] = epsilonIn_10[0] ^ epsilonIn_10[3] ^ epsilonIn_10[4];
   assign epsilonIni_10 [3] = epsilonIn_10[0] ^ epsilonIn_10[1] ^ epsilonIn_10[4] ^ epsilonIn_10[5];
   assign epsilonIni_10 [4] = epsilonIn_10[0] ^ epsilonIn_10[1] ^ epsilonIn_10[5];
   assign epsilonIni_10 [5] = epsilonIn_10[1];
   assign epsilonIni_11 [0] = epsilonIn_11[0] ^ epsilonIn_11[3] ^ epsilonIn_11[5];
   assign epsilonIni_11 [1] = epsilonIn_11[1] ^ epsilonIn_11[3] ^ epsilonIn_11[4] ^ epsilonIn_11[5];
   assign epsilonIni_11 [2] = epsilonIn_11[0] ^ epsilonIn_11[2] ^ epsilonIn_11[4] ^ epsilonIn_11[5];
   assign epsilonIni_11 [3] = epsilonIn_11[0] ^ epsilonIn_11[1] ^ epsilonIn_11[3] ^ epsilonIn_11[5];
   assign epsilonIni_11 [4] = epsilonIn_11[1] ^ epsilonIn_11[2] ^ epsilonIn_11[3] ^ epsilonIn_11[4] ^ epsilonIn_11[5];
   assign epsilonIni_11 [5] = epsilonIn_11[2] ^ epsilonIn_11[4];
   assign epsilonIni_12 [0] = epsilonIn_12[0] ^ epsilonIn_12[3] ^ epsilonIn_12[4] ^ epsilonIn_12[5];
   assign epsilonIni_12 [1] = epsilonIn_12[0] ^ epsilonIn_12[1] ^ epsilonIn_12[3];
   assign epsilonIni_12 [2] = epsilonIn_12[1] ^ epsilonIn_12[2] ^ epsilonIn_12[4];
   assign epsilonIni_12 [3] = epsilonIn_12[0] ^ epsilonIn_12[2] ^ epsilonIn_12[3] ^ epsilonIn_12[5];
   assign epsilonIni_12 [4] = epsilonIn_12[1] ^ epsilonIn_12[5];
   assign epsilonIni_12 [5] = epsilonIn_12[2] ^ epsilonIn_12[3] ^ epsilonIn_12[4] ^ epsilonIn_12[5];
   assign epsilonIni_13 [0] = epsilonIn_13[2] ^ epsilonIn_13[3] ^ epsilonIn_13[5];
   assign epsilonIni_13 [1] = epsilonIn_13[2] ^ epsilonIn_13[4] ^ epsilonIn_13[5];
   assign epsilonIni_13 [2] = epsilonIn_13[3] ^ epsilonIn_13[5];
   assign epsilonIni_13 [3] = epsilonIn_13[4];
   assign epsilonIni_13 [4] = epsilonIn_13[0] ^ epsilonIn_13[2] ^ epsilonIn_13[3];
   assign epsilonIni_13 [5] = epsilonIn_13[1] ^ epsilonIn_13[2] ^ epsilonIn_13[4] ^ epsilonIn_13[5];
   assign epsilonIni_14 [0] = epsilonIn_14[0] ^ epsilonIn_14[1] ^ epsilonIn_14[5];
   assign epsilonIni_14 [1] = epsilonIn_14[0] ^ epsilonIn_14[2] ^ epsilonIn_14[5];
   assign epsilonIni_14 [2] = epsilonIn_14[1] ^ epsilonIn_14[3];
   assign epsilonIni_14 [3] = epsilonIn_14[0] ^ epsilonIn_14[2] ^ epsilonIn_14[4];
   assign epsilonIni_14 [4] = epsilonIn_14[0] ^ epsilonIn_14[3];
   assign epsilonIni_14 [5] = epsilonIn_14[0] ^ epsilonIn_14[4] ^ epsilonIn_14[5];
   assign epsilonIni_15 [0] = epsilonIn_15[1] ^ epsilonIn_15[2] ^ epsilonIn_15[3] ^ epsilonIn_15[4] ^ epsilonIn_15[5];
   assign epsilonIni_15 [1] = epsilonIn_15[0] ^ epsilonIn_15[1];
   assign epsilonIni_15 [2] = epsilonIn_15[0] ^ epsilonIn_15[1] ^ epsilonIn_15[2];
   assign epsilonIni_15 [3] = epsilonIn_15[0] ^ epsilonIn_15[1] ^ epsilonIn_15[2] ^ epsilonIn_15[3];
   assign epsilonIni_15 [4] = epsilonIn_15[5];
   assign epsilonIni_15 [5] = epsilonIn_15[0] ^ epsilonIn_15[1] ^ epsilonIn_15[2] ^ epsilonIn_15[3] ^ epsilonIn_15[4] ^ epsilonIn_15[5];
   assign epsilonIni_16 [0] = epsilonIn_16[1] ^ epsilonIn_16[5];
   assign epsilonIni_16 [1] = epsilonIn_16[0] ^ epsilonIn_16[1] ^ epsilonIn_16[2] ^ epsilonIn_16[5];
   assign epsilonIni_16 [2] = epsilonIn_16[1] ^ epsilonIn_16[2] ^ epsilonIn_16[3];
   assign epsilonIni_16 [3] = epsilonIn_16[0] ^ epsilonIn_16[2] ^ epsilonIn_16[3] ^ epsilonIn_16[4];
   assign epsilonIni_16 [4] = epsilonIn_16[0] ^ epsilonIn_16[3] ^ epsilonIn_16[4];
   assign epsilonIni_16 [5] = epsilonIn_16[0] ^ epsilonIn_16[4];
   assign epsilonIni_17 [0] = epsilonIn_17[0] ^ epsilonIn_17[2] ^ epsilonIn_17[3];
   assign epsilonIni_17 [1] = epsilonIn_17[0] ^ epsilonIn_17[1] ^ epsilonIn_17[2] ^ epsilonIn_17[4];
   assign epsilonIni_17 [2] = epsilonIn_17[1] ^ epsilonIn_17[2] ^ epsilonIn_17[3] ^ epsilonIn_17[5];
   assign epsilonIni_17 [3] = epsilonIn_17[2] ^ epsilonIn_17[3] ^ epsilonIn_17[4];
   assign epsilonIni_17 [4] = epsilonIn_17[0] ^ epsilonIn_17[2] ^ epsilonIn_17[4] ^ epsilonIn_17[5];
   assign epsilonIni_17 [5] = epsilonIn_17[1] ^ epsilonIn_17[2] ^ epsilonIn_17[5];
   assign epsilonIni_18 [0] = epsilonIn_18[0] ^ epsilonIn_18[3];
   assign epsilonIni_18 [1] = epsilonIn_18[0] ^ epsilonIn_18[1] ^ epsilonIn_18[3] ^ epsilonIn_18[4];
   assign epsilonIni_18 [2] = epsilonIn_18[0] ^ epsilonIn_18[1] ^ epsilonIn_18[2] ^ epsilonIn_18[4] ^ epsilonIn_18[5];
   assign epsilonIni_18 [3] = epsilonIn_18[0] ^ epsilonIn_18[1] ^ epsilonIn_18[2] ^ epsilonIn_18[3] ^ epsilonIn_18[5];
   assign epsilonIni_18 [4] = epsilonIn_18[1] ^ epsilonIn_18[2] ^ epsilonIn_18[4];
   assign epsilonIni_18 [5] = epsilonIn_18[2] ^ epsilonIn_18[5];
   assign epsilonIni_19 [0] = epsilonIn_19[5];
   assign epsilonIni_19 [1] = epsilonIn_19[0] ^ epsilonIn_19[5];
   assign epsilonIni_19 [2] = epsilonIn_19[1];
   assign epsilonIni_19 [3] = epsilonIn_19[2];
   assign epsilonIni_19 [4] = epsilonIn_19[3] ^ epsilonIn_19[5];
   assign epsilonIni_19 [5] = epsilonIn_19[4] ^ epsilonIn_19[5];
   assign epsilonIni_20 [0] = epsilonIn_20[0] ^ epsilonIn_20[3] ^ epsilonIn_20[4];
   assign epsilonIni_20 [1] = epsilonIn_20[1] ^ epsilonIn_20[3] ^ epsilonIn_20[5];
   assign epsilonIni_20 [2] = epsilonIn_20[2] ^ epsilonIn_20[4];
   assign epsilonIni_20 [3] = epsilonIn_20[0] ^ epsilonIn_20[3] ^ epsilonIn_20[5];
   assign epsilonIni_20 [4] = epsilonIn_20[1] ^ epsilonIn_20[3];
   assign epsilonIni_20 [5] = epsilonIn_20[2] ^ epsilonIn_20[3];



   //------------------------------------------------------------------------
   //- epsilonNew
   //------------------------------------------------------------------------
   reg  [5:0]  epsilonReg_0;
   reg  [5:0]  epsilonReg_1;
   reg  [5:0]  epsilonReg_2;
   reg  [5:0]  epsilonReg_3;
   reg  [5:0]  epsilonReg_4;
   reg  [5:0]  epsilonReg_5;
   reg  [5:0]  epsilonReg_6;
   reg  [5:0]  epsilonReg_7;
   reg  [5:0]  epsilonReg_8;
   reg  [5:0]  epsilonReg_9;
   reg  [5:0]  epsilonReg_10;
   reg  [5:0]  epsilonReg_11;
   reg  [5:0]  epsilonReg_12;
   reg  [5:0]  epsilonReg_13;
   reg  [5:0]  epsilonReg_14;
   reg  [5:0]  epsilonReg_15;
   reg  [5:0]  epsilonReg_16;
   reg  [5:0]  epsilonReg_17;
   reg  [5:0]  epsilonReg_18;
   reg  [5:0]  epsilonReg_19;
   reg  [5:0]  epsilonReg_20;
   wire [5:0]  epsilonNew_0;
   wire [5:0]  epsilonNew_1;
   wire [5:0]  epsilonNew_2;
   wire [5:0]  epsilonNew_3;
   wire [5:0]  epsilonNew_4;
   wire [5:0]  epsilonNew_5;
   wire [5:0]  epsilonNew_6;
   wire [5:0]  epsilonNew_7;
   wire [5:0]  epsilonNew_8;
   wire [5:0]  epsilonNew_9;
   wire [5:0]  epsilonNew_10;
   wire [5:0]  epsilonNew_11;
   wire [5:0]  epsilonNew_12;
   wire [5:0]  epsilonNew_13;
   wire [5:0]  epsilonNew_14;
   wire [5:0]  epsilonNew_15;
   wire [5:0]  epsilonNew_16;
   wire [5:0]  epsilonNew_17;
   wire [5:0]  epsilonNew_18;
   wire [5:0]  epsilonNew_19;
   wire [5:0]  epsilonNew_20;


   assign epsilonNew_0 [0] = epsilonReg_0[0];
   assign epsilonNew_0 [1] = epsilonReg_0[1];
   assign epsilonNew_0 [2] = epsilonReg_0[2];
   assign epsilonNew_0 [3] = epsilonReg_0[3];
   assign epsilonNew_0 [4] = epsilonReg_0[4];
   assign epsilonNew_0 [5] = epsilonReg_0[5];
   assign epsilonNew_1 [0] = epsilonReg_1[5];
   assign epsilonNew_1 [1] = epsilonReg_1[0] ^ epsilonReg_1[5];
   assign epsilonNew_1 [2] = epsilonReg_1[1];
   assign epsilonNew_1 [3] = epsilonReg_1[2];
   assign epsilonNew_1 [4] = epsilonReg_1[3] ^ epsilonReg_1[5];
   assign epsilonNew_1 [5] = epsilonReg_1[4] ^ epsilonReg_1[5];
   assign epsilonNew_2 [0] = epsilonReg_2[4] ^ epsilonReg_2[5];
   assign epsilonNew_2 [1] = epsilonReg_2[4];
   assign epsilonNew_2 [2] = epsilonReg_2[0] ^ epsilonReg_2[5];
   assign epsilonNew_2 [3] = epsilonReg_2[1];
   assign epsilonNew_2 [4] = epsilonReg_2[2] ^ epsilonReg_2[4] ^ epsilonReg_2[5];
   assign epsilonNew_2 [5] = epsilonReg_2[3] ^ epsilonReg_2[4];
   assign epsilonNew_3 [0] = epsilonReg_3[3] ^ epsilonReg_3[4];
   assign epsilonNew_3 [1] = epsilonReg_3[3] ^ epsilonReg_3[5];
   assign epsilonNew_3 [2] = epsilonReg_3[4];
   assign epsilonNew_3 [3] = epsilonReg_3[0] ^ epsilonReg_3[5];
   assign epsilonNew_3 [4] = epsilonReg_3[1] ^ epsilonReg_3[3] ^ epsilonReg_3[4];
   assign epsilonNew_3 [5] = epsilonReg_3[2] ^ epsilonReg_3[3] ^ epsilonReg_3[5];
   assign epsilonNew_4 [0] = epsilonReg_4[2] ^ epsilonReg_4[3] ^ epsilonReg_4[5];
   assign epsilonNew_4 [1] = epsilonReg_4[2] ^ epsilonReg_4[4] ^ epsilonReg_4[5];
   assign epsilonNew_4 [2] = epsilonReg_4[3] ^ epsilonReg_4[5];
   assign epsilonNew_4 [3] = epsilonReg_4[4];
   assign epsilonNew_4 [4] = epsilonReg_4[0] ^ epsilonReg_4[2] ^ epsilonReg_4[3];
   assign epsilonNew_4 [5] = epsilonReg_4[1] ^ epsilonReg_4[2] ^ epsilonReg_4[4] ^ epsilonReg_4[5];
   assign epsilonNew_5 [0] = epsilonReg_5[1] ^ epsilonReg_5[2] ^ epsilonReg_5[4] ^ epsilonReg_5[5];
   assign epsilonNew_5 [1] = epsilonReg_5[1] ^ epsilonReg_5[3] ^ epsilonReg_5[4];
   assign epsilonNew_5 [2] = epsilonReg_5[2] ^ epsilonReg_5[4] ^ epsilonReg_5[5];
   assign epsilonNew_5 [3] = epsilonReg_5[3] ^ epsilonReg_5[5];
   assign epsilonNew_5 [4] = epsilonReg_5[1] ^ epsilonReg_5[2] ^ epsilonReg_5[5];
   assign epsilonNew_5 [5] = epsilonReg_5[0] ^ epsilonReg_5[1] ^ epsilonReg_5[3] ^ epsilonReg_5[4] ^ epsilonReg_5[5];
   assign epsilonNew_6 [0] = epsilonReg_6[0] ^ epsilonReg_6[1] ^ epsilonReg_6[3] ^ epsilonReg_6[4] ^ epsilonReg_6[5];
   assign epsilonNew_6 [1] = epsilonReg_6[0] ^ epsilonReg_6[2] ^ epsilonReg_6[3];
   assign epsilonNew_6 [2] = epsilonReg_6[1] ^ epsilonReg_6[3] ^ epsilonReg_6[4];
   assign epsilonNew_6 [3] = epsilonReg_6[2] ^ epsilonReg_6[4] ^ epsilonReg_6[5];
   assign epsilonNew_6 [4] = epsilonReg_6[0] ^ epsilonReg_6[1] ^ epsilonReg_6[4];
   assign epsilonNew_6 [5] = epsilonReg_6[0] ^ epsilonReg_6[2] ^ epsilonReg_6[3] ^ epsilonReg_6[4];
   assign epsilonNew_7 [0] = epsilonReg_7[0] ^ epsilonReg_7[2] ^ epsilonReg_7[3] ^ epsilonReg_7[4];
   assign epsilonNew_7 [1] = epsilonReg_7[1] ^ epsilonReg_7[2] ^ epsilonReg_7[5];
   assign epsilonNew_7 [2] = epsilonReg_7[0] ^ epsilonReg_7[2] ^ epsilonReg_7[3];
   assign epsilonNew_7 [3] = epsilonReg_7[1] ^ epsilonReg_7[3] ^ epsilonReg_7[4];
   assign epsilonNew_7 [4] = epsilonReg_7[0] ^ epsilonReg_7[3] ^ epsilonReg_7[5];
   assign epsilonNew_7 [5] = epsilonReg_7[1] ^ epsilonReg_7[2] ^ epsilonReg_7[3];
   assign epsilonNew_8 [0] = epsilonReg_8[1] ^ epsilonReg_8[2] ^ epsilonReg_8[3];
   assign epsilonNew_8 [1] = epsilonReg_8[0] ^ epsilonReg_8[1] ^ epsilonReg_8[4];
   assign epsilonNew_8 [2] = epsilonReg_8[1] ^ epsilonReg_8[2] ^ epsilonReg_8[5];
   assign epsilonNew_8 [3] = epsilonReg_8[0] ^ epsilonReg_8[2] ^ epsilonReg_8[3];
   assign epsilonNew_8 [4] = epsilonReg_8[2] ^ epsilonReg_8[4];
   assign epsilonNew_8 [5] = epsilonReg_8[0] ^ epsilonReg_8[1] ^ epsilonReg_8[2] ^ epsilonReg_8[5];
   assign epsilonNew_9 [0] = epsilonReg_9[0] ^ epsilonReg_9[1] ^ epsilonReg_9[2] ^ epsilonReg_9[5];
   assign epsilonNew_9 [1] = epsilonReg_9[0] ^ epsilonReg_9[3] ^ epsilonReg_9[5];
   assign epsilonNew_9 [2] = epsilonReg_9[0] ^ epsilonReg_9[1] ^ epsilonReg_9[4];
   assign epsilonNew_9 [3] = epsilonReg_9[1] ^ epsilonReg_9[2] ^ epsilonReg_9[5];
   assign epsilonNew_9 [4] = epsilonReg_9[1] ^ epsilonReg_9[3] ^ epsilonReg_9[5];
   assign epsilonNew_9 [5] = epsilonReg_9[0] ^ epsilonReg_9[1] ^ epsilonReg_9[4] ^ epsilonReg_9[5];
   assign epsilonNew_10 [0] = epsilonReg_10[0] ^ epsilonReg_10[1] ^ epsilonReg_10[4] ^ epsilonReg_10[5];
   assign epsilonNew_10 [1] = epsilonReg_10[2] ^ epsilonReg_10[4];
   assign epsilonNew_10 [2] = epsilonReg_10[0] ^ epsilonReg_10[3] ^ epsilonReg_10[5];
   assign epsilonNew_10 [3] = epsilonReg_10[0] ^ epsilonReg_10[1] ^ epsilonReg_10[4];
   assign epsilonNew_10 [4] = epsilonReg_10[0] ^ epsilonReg_10[2] ^ epsilonReg_10[4];
   assign epsilonNew_10 [5] = epsilonReg_10[0] ^ epsilonReg_10[3] ^ epsilonReg_10[4];
   assign epsilonNew_11 [0] = epsilonReg_11[0] ^ epsilonReg_11[3] ^ epsilonReg_11[4];
   assign epsilonNew_11 [1] = epsilonReg_11[1] ^ epsilonReg_11[3] ^ epsilonReg_11[5];
   assign epsilonNew_11 [2] = epsilonReg_11[2] ^ epsilonReg_11[4];
   assign epsilonNew_11 [3] = epsilonReg_11[0] ^ epsilonReg_11[3] ^ epsilonReg_11[5];
   assign epsilonNew_11 [4] = epsilonReg_11[1] ^ epsilonReg_11[3];
   assign epsilonNew_11 [5] = epsilonReg_11[2] ^ epsilonReg_11[3];
   assign epsilonNew_12 [0] = epsilonReg_12[2] ^ epsilonReg_12[3];
   assign epsilonNew_12 [1] = epsilonReg_12[0] ^ epsilonReg_12[2] ^ epsilonReg_12[4];
   assign epsilonNew_12 [2] = epsilonReg_12[1] ^ epsilonReg_12[3] ^ epsilonReg_12[5];
   assign epsilonNew_12 [3] = epsilonReg_12[2] ^ epsilonReg_12[4];
   assign epsilonNew_12 [4] = epsilonReg_12[0] ^ epsilonReg_12[2] ^ epsilonReg_12[5];
   assign epsilonNew_12 [5] = epsilonReg_12[1] ^ epsilonReg_12[2];
   assign epsilonNew_13 [0] = epsilonReg_13[1] ^ epsilonReg_13[2];
   assign epsilonNew_13 [1] = epsilonReg_13[1] ^ epsilonReg_13[3];
   assign epsilonNew_13 [2] = epsilonReg_13[0] ^ epsilonReg_13[2] ^ epsilonReg_13[4];
   assign epsilonNew_13 [3] = epsilonReg_13[1] ^ epsilonReg_13[3] ^ epsilonReg_13[5];
   assign epsilonNew_13 [4] = epsilonReg_13[1] ^ epsilonReg_13[4];
   assign epsilonNew_13 [5] = epsilonReg_13[0] ^ epsilonReg_13[1] ^ epsilonReg_13[5];
   assign epsilonNew_14 [0] = epsilonReg_14[0] ^ epsilonReg_14[1] ^ epsilonReg_14[5];
   assign epsilonNew_14 [1] = epsilonReg_14[0] ^ epsilonReg_14[2] ^ epsilonReg_14[5];
   assign epsilonNew_14 [2] = epsilonReg_14[1] ^ epsilonReg_14[3];
   assign epsilonNew_14 [3] = epsilonReg_14[0] ^ epsilonReg_14[2] ^ epsilonReg_14[4];
   assign epsilonNew_14 [4] = epsilonReg_14[0] ^ epsilonReg_14[3];
   assign epsilonNew_14 [5] = epsilonReg_14[0] ^ epsilonReg_14[4] ^ epsilonReg_14[5];
   assign epsilonNew_15 [0] = epsilonReg_15[0] ^ epsilonReg_15[4] ^ epsilonReg_15[5];
   assign epsilonNew_15 [1] = epsilonReg_15[1] ^ epsilonReg_15[4];
   assign epsilonNew_15 [2] = epsilonReg_15[0] ^ epsilonReg_15[2] ^ epsilonReg_15[5];
   assign epsilonNew_15 [3] = epsilonReg_15[1] ^ epsilonReg_15[3];
   assign epsilonNew_15 [4] = epsilonReg_15[2] ^ epsilonReg_15[5];
   assign epsilonNew_15 [5] = epsilonReg_15[3] ^ epsilonReg_15[4] ^ epsilonReg_15[5];
   assign epsilonNew_16 [0] = epsilonReg_16[3] ^ epsilonReg_16[4] ^ epsilonReg_16[5];
   assign epsilonNew_16 [1] = epsilonReg_16[0] ^ epsilonReg_16[3];
   assign epsilonNew_16 [2] = epsilonReg_16[1] ^ epsilonReg_16[4];
   assign epsilonNew_16 [3] = epsilonReg_16[0] ^ epsilonReg_16[2] ^ epsilonReg_16[5];
   assign epsilonNew_16 [4] = epsilonReg_16[1] ^ epsilonReg_16[4] ^ epsilonReg_16[5];
   assign epsilonNew_16 [5] = epsilonReg_16[2] ^ epsilonReg_16[3] ^ epsilonReg_16[4];
   assign epsilonNew_17 [0] = epsilonReg_17[2] ^ epsilonReg_17[3] ^ epsilonReg_17[4];
   assign epsilonNew_17 [1] = epsilonReg_17[2] ^ epsilonReg_17[5];
   assign epsilonNew_17 [2] = epsilonReg_17[0] ^ epsilonReg_17[3];
   assign epsilonNew_17 [3] = epsilonReg_17[1] ^ epsilonReg_17[4];
   assign epsilonNew_17 [4] = epsilonReg_17[0] ^ epsilonReg_17[3] ^ epsilonReg_17[4] ^ epsilonReg_17[5];
   assign epsilonNew_17 [5] = epsilonReg_17[1] ^ epsilonReg_17[2] ^ epsilonReg_17[3] ^ epsilonReg_17[5];
   assign epsilonNew_18 [0] = epsilonReg_18[1] ^ epsilonReg_18[2] ^ epsilonReg_18[3] ^ epsilonReg_18[5];
   assign epsilonNew_18 [1] = epsilonReg_18[1] ^ epsilonReg_18[4] ^ epsilonReg_18[5];
   assign epsilonNew_18 [2] = epsilonReg_18[2] ^ epsilonReg_18[5];
   assign epsilonNew_18 [3] = epsilonReg_18[0] ^ epsilonReg_18[3];
   assign epsilonNew_18 [4] = epsilonReg_18[2] ^ epsilonReg_18[3] ^ epsilonReg_18[4] ^ epsilonReg_18[5];
   assign epsilonNew_18 [5] = epsilonReg_18[0] ^ epsilonReg_18[1] ^ epsilonReg_18[2] ^ epsilonReg_18[4];
   assign epsilonNew_19 [0] = epsilonReg_19[0] ^ epsilonReg_19[1] ^ epsilonReg_19[2] ^ epsilonReg_19[4];
   assign epsilonNew_19 [1] = epsilonReg_19[0] ^ epsilonReg_19[3] ^ epsilonReg_19[4] ^ epsilonReg_19[5];
   assign epsilonNew_19 [2] = epsilonReg_19[1] ^ epsilonReg_19[4] ^ epsilonReg_19[5];
   assign epsilonNew_19 [3] = epsilonReg_19[2] ^ epsilonReg_19[5];
   assign epsilonNew_19 [4] = epsilonReg_19[1] ^ epsilonReg_19[2] ^ epsilonReg_19[3] ^ epsilonReg_19[4];
   assign epsilonNew_19 [5] = epsilonReg_19[0] ^ epsilonReg_19[1] ^ epsilonReg_19[3] ^ epsilonReg_19[5];
   assign epsilonNew_20 [0] = epsilonReg_20[0] ^ epsilonReg_20[1] ^ epsilonReg_20[3] ^ epsilonReg_20[5];
   assign epsilonNew_20 [1] = epsilonReg_20[2] ^ epsilonReg_20[3] ^ epsilonReg_20[4] ^ epsilonReg_20[5];
   assign epsilonNew_20 [2] = epsilonReg_20[0] ^ epsilonReg_20[3] ^ epsilonReg_20[4] ^ epsilonReg_20[5];
   assign epsilonNew_20 [3] = epsilonReg_20[1] ^ epsilonReg_20[4] ^ epsilonReg_20[5];
   assign epsilonNew_20 [4] = epsilonReg_20[0] ^ epsilonReg_20[1] ^ epsilonReg_20[2] ^ epsilonReg_20[3];
   assign epsilonNew_20 [5] = epsilonReg_20[0] ^ epsilonReg_20[2] ^ epsilonReg_20[4] ^ epsilonReg_20[5];



   //------------------------------------------------------------------
   // + epsilonReg_0,..., epsilonReg_20
   //- registers
   //------------------------------------------------------------------
   always @(posedge CLK or negedge RESET) begin
      if (~RESET) begin
         epsilonReg_0 [5:0]  <= 6'd0;
         epsilonReg_1 [5:0]  <= 6'd0;
         epsilonReg_2 [5:0]  <= 6'd0;
         epsilonReg_3 [5:0]  <= 6'd0;
         epsilonReg_4 [5:0]  <= 6'd0;
         epsilonReg_5 [5:0]  <= 6'd0;
         epsilonReg_6 [5:0]  <= 6'd0;
         epsilonReg_7 [5:0]  <= 6'd0;
         epsilonReg_8 [5:0]  <= 6'd0;
         epsilonReg_9 [5:0]  <= 6'd0;
         epsilonReg_10 [5:0] <= 6'd0;
         epsilonReg_11 [5:0] <= 6'd0;
         epsilonReg_12 [5:0] <= 6'd0;
         epsilonReg_13 [5:0] <= 6'd0;
         epsilonReg_14 [5:0] <= 6'd0;
         epsilonReg_15 [5:0] <= 6'd0;
         epsilonReg_16 [5:0] <= 6'd0;
         epsilonReg_17 [5:0] <= 6'd0;
         epsilonReg_18 [5:0] <= 6'd0;
         epsilonReg_19 [5:0] <= 6'd0;
         epsilonReg_20 [5:0] <= 6'd0;
      end
      else if (enable == 1'b1) begin
         if (sync == 1'b1) begin
            epsilonReg_0 [5:0]  <= epsilonIni_0 [5:0];
            epsilonReg_1 [5:0]  <= epsilonIni_1 [5:0];
            epsilonReg_2 [5:0]  <= epsilonIni_2 [5:0];
            epsilonReg_3 [5:0]  <= epsilonIni_3 [5:0];
            epsilonReg_4 [5:0]  <= epsilonIni_4 [5:0];
            epsilonReg_5 [5:0]  <= epsilonIni_5 [5:0];
            epsilonReg_6 [5:0]  <= epsilonIni_6 [5:0];
            epsilonReg_7 [5:0]  <= epsilonIni_7 [5:0];
            epsilonReg_8 [5:0]  <= epsilonIni_8 [5:0];
            epsilonReg_9 [5:0]  <= epsilonIni_9 [5:0];
            epsilonReg_10 [5:0] <= epsilonIni_10 [5:0];
            epsilonReg_11 [5:0] <= epsilonIni_11 [5:0];
            epsilonReg_12 [5:0] <= epsilonIni_12 [5:0];
            epsilonReg_13 [5:0] <= epsilonIni_13 [5:0];
            epsilonReg_14 [5:0] <= epsilonIni_14 [5:0];
            epsilonReg_15 [5:0] <= epsilonIni_15 [5:0];
            epsilonReg_16 [5:0] <= epsilonIni_16 [5:0];
            epsilonReg_17 [5:0] <= epsilonIni_17 [5:0];
            epsilonReg_18 [5:0] <= epsilonIni_18 [5:0];
            epsilonReg_19 [5:0] <= epsilonIni_19 [5:0];
            epsilonReg_20 [5:0] <= epsilonIni_20 [5:0];
         end
         else begin
            epsilonReg_0 [5:0]  <= epsilonNew_0 [5:0];
            epsilonReg_1 [5:0]  <= epsilonNew_1 [5:0];
            epsilonReg_2 [5:0]  <= epsilonNew_2 [5:0];
            epsilonReg_3 [5:0]  <= epsilonNew_3 [5:0];
            epsilonReg_4 [5:0]  <= epsilonNew_4 [5:0];
            epsilonReg_5 [5:0]  <= epsilonNew_5 [5:0];
            epsilonReg_6 [5:0]  <= epsilonNew_6 [5:0];
            epsilonReg_7 [5:0]  <= epsilonNew_7 [5:0];
            epsilonReg_8 [5:0]  <= epsilonNew_8 [5:0];
            epsilonReg_9 [5:0]  <= epsilonNew_9 [5:0];
            epsilonReg_10 [5:0] <= epsilonNew_10 [5:0];
            epsilonReg_11 [5:0] <= epsilonNew_11 [5:0];
            epsilonReg_12 [5:0] <= epsilonNew_12 [5:0];
            epsilonReg_13 [5:0] <= epsilonNew_13 [5:0];
            epsilonReg_14 [5:0] <= epsilonNew_14 [5:0];
            epsilonReg_15 [5:0] <= epsilonNew_15 [5:0];
            epsilonReg_16 [5:0] <= epsilonNew_16 [5:0];
            epsilonReg_17 [5:0] <= epsilonNew_17 [5:0];
            epsilonReg_18 [5:0] <= epsilonNew_18 [5:0];
            epsilonReg_19 [5:0] <= epsilonNew_19 [5:0];
            epsilonReg_20 [5:0] <= epsilonNew_20 [5:0];
         end
      end
   end



   //------------------------------------------------------------------------
   // Generate Error Pattern: Lambda
   //------------------------------------------------------------------------
   always @( lambdaReg_0   or lambdaReg_1   or lambdaReg_2   or lambdaReg_3   or lambdaReg_4   or lambdaReg_5   or lambdaReg_6   or lambdaReg_7   or lambdaReg_8   or lambdaReg_9   or lambdaReg_10   or lambdaReg_11   or lambdaReg_12   or lambdaReg_13   or lambdaReg_14   or lambdaReg_15   or lambdaReg_16   or lambdaReg_17   or lambdaReg_18   or lambdaReg_19 ) begin
      lambdaSum [5:0] = lambdaReg_0[5:0]   ^ lambdaReg_1[5:0]   ^ lambdaReg_2[5:0]   ^ lambdaReg_3[5:0]   ^ lambdaReg_4[5:0]   ^ lambdaReg_5[5:0]   ^ lambdaReg_6[5:0]   ^ lambdaReg_7[5:0]   ^ lambdaReg_8[5:0]   ^ lambdaReg_9[5:0]   ^ lambdaReg_10[5:0]   ^ lambdaReg_11[5:0]   ^ lambdaReg_12[5:0]   ^ lambdaReg_13[5:0]   ^ lambdaReg_14[5:0]   ^ lambdaReg_15[5:0]   ^ lambdaReg_16[5:0]   ^ lambdaReg_17[5:0]   ^ lambdaReg_18[5:0]   ^ lambdaReg_19[5:0];
      lambdaEven [5:0] = lambdaReg_0[5:0]   ^ lambdaReg_2[5:0]   ^ lambdaReg_4[5:0]   ^ lambdaReg_6[5:0]   ^ lambdaReg_8[5:0]   ^ lambdaReg_10[5:0]   ^ lambdaReg_12[5:0]   ^ lambdaReg_14[5:0]   ^ lambdaReg_16[5:0]   ^ lambdaReg_18[5:0];
      lambdaOdd [5:0] =  lambdaReg_1[5:0]   ^ lambdaReg_3[5:0]   ^ lambdaReg_5[5:0]   ^ lambdaReg_7[5:0]   ^ lambdaReg_9[5:0]   ^ lambdaReg_11[5:0]   ^ lambdaReg_13[5:0]   ^ lambdaReg_15[5:0]   ^ lambdaReg_17[5:0]   ^ lambdaReg_19[5:0];
   end



   //------------------------------------------------------------------------
   // Generate Error Pattern: Omega
   //------------------------------------------------------------------------
   always @( omegaReg_0   or omegaReg_1   or omegaReg_2   or omegaReg_3   or omegaReg_4   or omegaReg_5   or omegaReg_6   or omegaReg_7   or omegaReg_8   or omegaReg_9   or omegaReg_10   or omegaReg_11   or omegaReg_12   or omegaReg_13   or omegaReg_14   or omegaReg_15   or omegaReg_16   or omegaReg_17   or omegaReg_18   or omegaReg_19 ) begin
      omegaSum [5:0] = omegaReg_0[5:0]   ^ omegaReg_1[5:0]   ^ omegaReg_2[5:0]   ^ omegaReg_3[5:0]   ^ omegaReg_4[5:0]   ^ omegaReg_5[5:0]   ^ omegaReg_6[5:0]   ^ omegaReg_7[5:0]   ^ omegaReg_8[5:0]   ^ omegaReg_9[5:0]   ^ omegaReg_10[5:0]   ^ omegaReg_11[5:0]   ^ omegaReg_12[5:0]   ^ omegaReg_13[5:0]   ^ omegaReg_14[5:0]   ^ omegaReg_15[5:0]   ^ omegaReg_16[5:0]   ^ omegaReg_17[5:0]   ^ omegaReg_18[5:0]   ^ omegaReg_19[5:0];
   end



   //------------------------------------------------------------------------
   //- Generate Error Pattern: Epsilon
   //------------------------------------------------------------------------
   always @( epsilonReg_0   or epsilonReg_1   or epsilonReg_2   or epsilonReg_3   or epsilonReg_4   or epsilonReg_5   or epsilonReg_6   or epsilonReg_7   or epsilonReg_8   or epsilonReg_9   or epsilonReg_10   or epsilonReg_11   or epsilonReg_12   or epsilonReg_13   or epsilonReg_14   or epsilonReg_15   or epsilonReg_16   or epsilonReg_17   or epsilonReg_18   or epsilonReg_19   or epsilonReg_20 ) begin
      epsilonSum [5:0] = epsilonReg_0[5:0]   ^ epsilonReg_1[5:0]   ^ epsilonReg_2[5:0]   ^ epsilonReg_3[5:0]   ^ epsilonReg_4[5:0]   ^ epsilonReg_5[5:0]   ^ epsilonReg_6[5:0]   ^ epsilonReg_7[5:0]   ^ epsilonReg_8[5:0]   ^ epsilonReg_9[5:0]   ^ epsilonReg_10[5:0]   ^ epsilonReg_11[5:0]   ^ epsilonReg_12[5:0]   ^ epsilonReg_13[5:0]   ^ epsilonReg_14[5:0]   ^ epsilonReg_15[5:0]   ^ epsilonReg_16[5:0]   ^ epsilonReg_17[5:0]   ^ epsilonReg_18[5:0]   ^ epsilonReg_19[5:0]   ^ epsilonReg_20[5:0];
      epsilonOdd [5:0] =  epsilonReg_1[5:0]   ^ epsilonReg_3[5:0]   ^ epsilonReg_5[5:0]   ^ epsilonReg_7[5:0]   ^ epsilonReg_9[5:0]   ^ epsilonReg_11[5:0]   ^ epsilonReg_13[5:0]   ^ epsilonReg_15[5:0]   ^ epsilonReg_17[5:0]   ^ epsilonReg_19[5:0];
   end



   //------------------------------------------------------------------------
   //- RsDecodeMult instantiation, RsDecodeMult_MuldE0 && RsDecodeMult_MuldE1
   //------------------------------------------------------------------------
   RsDecodeMult RsDecodeMult_MuldE0 (.A(lambdaOddReg[5:0]), .B(epsilonSumReg[5:0]), .P(denomE0[5:0]));
   RsDecodeMult RsDecodeMult_MuldE1 (.A(lambdaSumReg[5:0]), .B(epsilonOddReg[5:0]), .P(denomE1[5:0]));


   //------------------------------------------------------------------------
   //- RsDecodeInv instantiation, RsDecodeInv_InvE0 && RsDecodeInv_InvE1
   //------------------------------------------------------------------------
   RsDecodeInv RsDecodeInv_InvE0 (.B(denomE0Reg[5:0]), .R(denomE0Inv[5:0]));
   RsDecodeInv RsDecodeInv_InvE1 (.B(denomE1Reg[5:0]), .R(denomE1Inv[5:0]));


   //------------------------------------------------------------------------
   //- RsDecodeMult instantiation, RsDecodeMult_MulE0 && RsDecodeMult_MulE1 
   //------------------------------------------------------------------------
   RsDecodeMult RsDecodeMult_MulE0 (.A(numeReg2[5:0]), .B(denomE0InvReg[5:0]), .P(errorValueE0[5:0]));
   RsDecodeMult RsDecodeMult_MulE1 (.A(numeReg2[5:0]), .B(denomE1InvReg[5:0]), .P(errorValueE1[5:0]));




   //------------------------------------------------------------------------
   // + lambdaSumReg, denomE1Reg, denomE1InvReg, epsilonSumReg, epsilonOddReg
   // + lambdaEvenReg, lambdaEvenReg2, lambdaEvenReg3, lambdaOddReg, lambdaOddReg2, lambdaOddReg3, denomE0Reg, denomE0InvReg
   // + omegaSumReg, numeReg, numeReg2
   //------------------------------------------------------------------------
   always @(posedge CLK or negedge RESET) begin
      if (~RESET) begin
         lambdaSumReg   [5:0] <= 6'd0;
         lambdaEvenReg  [5:0] <= 6'd0;
         lambdaEvenReg2 [5:0] <= 6'd0;
         lambdaEvenReg3 [5:0] <= 6'd0;
         lambdaOddReg   [5:0] <= 6'd0;
         lambdaOddReg2  [5:0] <= 6'd0;
         lambdaOddReg3  [5:0] <= 6'd0;
         denomE0Reg     [5:0] <= 6'd0;
         denomE1Reg     [5:0] <= 6'd0;
         denomE0InvReg  [5:0] <= 6'd0;
         denomE1InvReg  [5:0] <= 6'd0;
         omegaSumReg    [5:0] <= 6'd0;
         numeReg        [5:0] <= 6'd0;
         numeReg2       [5:0] <= 6'd0;
         epsilonSumReg  [5:0] <= 6'd0;
         epsilonOddReg  [5:0] <= 6'd0;
      end
      else if (enable == 1'b1) begin
         lambdaSumReg   <= lambdaSum;
         lambdaEvenReg3 <= lambdaEvenReg2;
         lambdaEvenReg2 <= lambdaEvenReg;
         lambdaEvenReg  <= lambdaEven;
         lambdaOddReg3  <= lambdaOddReg2;
         lambdaOddReg2  <= lambdaOddReg;
         lambdaOddReg   <= lambdaOdd;
         denomE0Reg     <= denomE0;
         denomE1Reg     <= denomE1;
         denomE0InvReg  <= denomE0Inv;
         denomE1InvReg  <= denomE1Inv;
         numeReg2       <= numeReg;
         numeReg        <= omegaSumReg;
         omegaSumReg    <= omegaSum;
         epsilonSumReg  <= epsilonSum;
         epsilonOddReg  <= epsilonOdd;
      end
   end



   //------------------------------------------------------------------
   // + errorOut
   //- 
   //------------------------------------------------------------------
   reg   [5:0]  errorOut;
   always @(erasureIn or lambdaEvenReg3 or lambdaOddReg3 or errorValueE0 or errorValueE1) begin
      if (erasureIn == 1'b1) begin
         errorOut = errorValueE1;
      end
      else if (lambdaEvenReg3 == lambdaOddReg3) begin
         errorOut = errorValueE0;
      end
      else begin
         errorOut = 6'd0;
      end
   end



   //------------------------------------------------------------------------
   // + numErrorReg
   //- Count Error
   //------------------------------------------------------------------------
   reg    [4:0]   numErrorReg;
   always @(posedge CLK or negedge RESET) begin
      if (~RESET) begin
         numErrorReg [4:0]   <= 5'd0;
      end
      else if (enable == 1'b1) begin
         if (sync == 1'b1) begin
            numErrorReg <= 5'd0;
         end
         else if (lambdaEven == lambdaOdd) begin
            numErrorReg <= numErrorReg + 5'd1;
         end
      end
   end



   //------------------------------------------------------------------
   // + numErrorReg2
   //------------------------------------------------------------------
   reg    [4:0]   numErrorReg2;
   always @(posedge CLK or negedge RESET) begin
      if (~RESET) begin
         numErrorReg2 <=  5'd0;
      end
      else if ((enable == 1'b1) && (doneOrg == 1'b1)) begin
         if (lambdaEven == lambdaOdd) begin
            numErrorReg2 <= numErrorReg + 5'd1;
         end
         else begin
            numErrorReg2 <= numErrorReg;
         end
      end
   end
   //------------------------------------------------------------------------
   //- Output Ports
   //------------------------------------------------------------------------
   assign   numError = numErrorReg2;


endmodule
