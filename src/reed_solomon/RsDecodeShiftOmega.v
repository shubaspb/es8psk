//===================================================================
// Module Name : RsDecodeShiftOmega
// File Name   : RsDecodeShiftOmega.v
// Function    : Rs Decoder Shift Omega Module
// 
// Revision History:
// Date          By           Version    Change Description
//===================================================================
// 2009/02/03  Gael Sapience     1.0       Original
//
//===================================================================
// (C) COPYRIGHT 2009 SYSTEM LSI CO., Ltd.
//


module RsDecodeShiftOmega(
   omega_0,           // omega polynom 0
   omega_1,           // omega polynom 1
   omega_2,           // omega polynom 2
   omega_3,           // omega polynom 3
   omega_4,           // omega polynom 4
   omega_5,           // omega polynom 5
   omega_6,           // omega polynom 6
   omega_7,           // omega polynom 7
   omega_8,           // omega polynom 8
   omega_9,           // omega polynom 9
   omega_10,          // omega polynom 10
   omega_11,          // omega polynom 11
   omega_12,          // omega polynom 12
   omega_13,          // omega polynom 13
   omega_14,          // omega polynom 14
   omega_15,          // omega polynom 15
   omega_16,          // omega polynom 16
   omega_17,          // omega polynom 17
   omega_18,          // omega polynom 18
   omega_19,          // omega polynom 19
   omegaShifted_0,    // omega shifted polynom 0
   omegaShifted_1,    // omega shifted polynom 1
   omegaShifted_2,    // omega shifted polynom 2
   omegaShifted_3,    // omega shifted polynom 3
   omegaShifted_4,    // omega shifted polynom 4
   omegaShifted_5,    // omega shifted polynom 5
   omegaShifted_6,    // omega shifted polynom 6
   omegaShifted_7,    // omega shifted polynom 7
   omegaShifted_8,    // omega shifted polynom 8
   omegaShifted_9,    // omega shifted polynom 9
   omegaShifted_10,   // omega shifted polynom 10
   omegaShifted_11,   // omega shifted polynom 11
   omegaShifted_12,   // omega shifted polynom 12
   omegaShifted_13,   // omega shifted polynom 13
   omegaShifted_14,   // omega shifted polynom 14
   omegaShifted_15,   // omega shifted polynom 15
   omegaShifted_16,   // omega shifted polynom 16
   omegaShifted_17,   // omega shifted polynom 17
   omegaShifted_18,   // omega shifted polynom 18
   omegaShifted_19,   // omega shifted polynom 19
   numShifted         // shift amount
);


   input [5:0] omega_0;            // omega polynom 0
   input [5:0] omega_1;            // omega polynom 1
   input [5:0] omega_2;            // omega polynom 2
   input [5:0] omega_3;            // omega polynom 3
   input [5:0] omega_4;            // omega polynom 4
   input [5:0] omega_5;            // omega polynom 5
   input [5:0] omega_6;            // omega polynom 6
   input [5:0] omega_7;            // omega polynom 7
   input [5:0] omega_8;            // omega polynom 8
   input [5:0] omega_9;            // omega polynom 9
   input [5:0] omega_10;           // omega polynom 10
   input [5:0] omega_11;           // omega polynom 11
   input [5:0] omega_12;           // omega polynom 12
   input [5:0] omega_13;           // omega polynom 13
   input [5:0] omega_14;           // omega polynom 14
   input [5:0] omega_15;           // omega polynom 15
   input [5:0] omega_16;           // omega polynom 16
   input [5:0] omega_17;           // omega polynom 17
   input [5:0] omega_18;           // omega polynom 18
   input [5:0] omega_19;           // omega polynom 19
   input [4:0] numShifted;         // shift amount

   output [5:0] omegaShifted_0;    // omega shifted polynom 0
   output [5:0] omegaShifted_1;    // omega shifted polynom 1
   output [5:0] omegaShifted_2;    // omega shifted polynom 2
   output [5:0] omegaShifted_3;    // omega shifted polynom 3
   output [5:0] omegaShifted_4;    // omega shifted polynom 4
   output [5:0] omegaShifted_5;    // omega shifted polynom 5
   output [5:0] omegaShifted_6;    // omega shifted polynom 6
   output [5:0] omegaShifted_7;    // omega shifted polynom 7
   output [5:0] omegaShifted_8;    // omega shifted polynom 8
   output [5:0] omegaShifted_9;    // omega shifted polynom 9
   output [5:0] omegaShifted_10;   // omega shifted polynom 10
   output [5:0] omegaShifted_11;   // omega shifted polynom 11
   output [5:0] omegaShifted_12;   // omega shifted polynom 12
   output [5:0] omegaShifted_13;   // omega shifted polynom 13
   output [5:0] omegaShifted_14;   // omega shifted polynom 14
   output [5:0] omegaShifted_15;   // omega shifted polynom 15
   output [5:0] omegaShifted_16;   // omega shifted polynom 16
   output [5:0] omegaShifted_17;   // omega shifted polynom 17
   output [5:0] omegaShifted_18;   // omega shifted polynom 18
   output [5:0] omegaShifted_19;   // omega shifted polynom 19



   //------------------------------------------------------------------------
   //+ omegaShifted_0,..., omegaShifted_19
   //- omegaShifted registers
   //------------------------------------------------------------------------
   reg [5:0]   omegaShiftedInner_0;
   reg [5:0]   omegaShiftedInner_1;
   reg [5:0]   omegaShiftedInner_2;
   reg [5:0]   omegaShiftedInner_3;
   reg [5:0]   omegaShiftedInner_4;
   reg [5:0]   omegaShiftedInner_5;
   reg [5:0]   omegaShiftedInner_6;
   reg [5:0]   omegaShiftedInner_7;
   reg [5:0]   omegaShiftedInner_8;
   reg [5:0]   omegaShiftedInner_9;
   reg [5:0]   omegaShiftedInner_10;
   reg [5:0]   omegaShiftedInner_11;
   reg [5:0]   omegaShiftedInner_12;
   reg [5:0]   omegaShiftedInner_13;
   reg [5:0]   omegaShiftedInner_14;
   reg [5:0]   omegaShiftedInner_15;
   reg [5:0]   omegaShiftedInner_16;
   reg [5:0]   omegaShiftedInner_17;
   reg [5:0]   omegaShiftedInner_18;
   reg [5:0]   omegaShiftedInner_19;


   always @ (numShifted or omega_0 or omega_1 or omega_2 or omega_3 or omega_4 or omega_5 or omega_6 or omega_7 or omega_8 or omega_9 or omega_10 or omega_11 or omega_12 or omega_13 or omega_14 or omega_15 or omega_16 or omega_17 or omega_18 or omega_19 ) begin
      case (numShifted)
         (5'd0): begin
            omegaShiftedInner_0 [5:0]  = omega_0 [5:0];
            omegaShiftedInner_1 [5:0]  = omega_1 [5:0];
            omegaShiftedInner_2 [5:0]  = omega_2 [5:0];
            omegaShiftedInner_3 [5:0]  = omega_3 [5:0];
            omegaShiftedInner_4 [5:0]  = omega_4 [5:0];
            omegaShiftedInner_5 [5:0]  = omega_5 [5:0];
            omegaShiftedInner_6 [5:0]  = omega_6 [5:0];
            omegaShiftedInner_7 [5:0]  = omega_7 [5:0];
            omegaShiftedInner_8 [5:0]  = omega_8 [5:0];
            omegaShiftedInner_9 [5:0]  = omega_9 [5:0];
            omegaShiftedInner_10 [5:0] = omega_10 [5:0];
            omegaShiftedInner_11 [5:0] = omega_11 [5:0];
            omegaShiftedInner_12 [5:0] = omega_12 [5:0];
            omegaShiftedInner_13 [5:0] = omega_13 [5:0];
            omegaShiftedInner_14 [5:0] = omega_14 [5:0];
            omegaShiftedInner_15 [5:0] = omega_15 [5:0];
            omegaShiftedInner_16 [5:0] = omega_16 [5:0];
            omegaShiftedInner_17 [5:0] = omega_17 [5:0];
            omegaShiftedInner_18 [5:0] = omega_18 [5:0];
            omegaShiftedInner_19 [5:0] = omega_19 [5:0];
         end
         (5'd1): begin
            omegaShiftedInner_0 [5:0]  = omega_1 [5:0];
            omegaShiftedInner_1 [5:0]  = omega_2 [5:0];
            omegaShiftedInner_2 [5:0]  = omega_3 [5:0];
            omegaShiftedInner_3 [5:0]  = omega_4 [5:0];
            omegaShiftedInner_4 [5:0]  = omega_5 [5:0];
            omegaShiftedInner_5 [5:0]  = omega_6 [5:0];
            omegaShiftedInner_6 [5:0]  = omega_7 [5:0];
            omegaShiftedInner_7 [5:0]  = omega_8 [5:0];
            omegaShiftedInner_8 [5:0]  = omega_9 [5:0];
            omegaShiftedInner_9 [5:0]  = omega_10 [5:0];
            omegaShiftedInner_10 [5:0] = omega_11 [5:0];
            omegaShiftedInner_11 [5:0] = omega_12 [5:0];
            omegaShiftedInner_12 [5:0] = omega_13 [5:0];
            omegaShiftedInner_13 [5:0] = omega_14 [5:0];
            omegaShiftedInner_14 [5:0] = omega_15 [5:0];
            omegaShiftedInner_15 [5:0] = omega_16 [5:0];
            omegaShiftedInner_16 [5:0] = omega_17 [5:0];
            omegaShiftedInner_17 [5:0] = omega_18 [5:0];
            omegaShiftedInner_18 [5:0] = omega_19 [5:0];
            omegaShiftedInner_19 [5:0] = 6'd0;
         end
         (5'd2): begin
            omegaShiftedInner_0 [5:0]  = omega_2 [5:0];
            omegaShiftedInner_1 [5:0]  = omega_3 [5:0];
            omegaShiftedInner_2 [5:0]  = omega_4 [5:0];
            omegaShiftedInner_3 [5:0]  = omega_5 [5:0];
            omegaShiftedInner_4 [5:0]  = omega_6 [5:0];
            omegaShiftedInner_5 [5:0]  = omega_7 [5:0];
            omegaShiftedInner_6 [5:0]  = omega_8 [5:0];
            omegaShiftedInner_7 [5:0]  = omega_9 [5:0];
            omegaShiftedInner_8 [5:0]  = omega_10 [5:0];
            omegaShiftedInner_9 [5:0]  = omega_11 [5:0];
            omegaShiftedInner_10 [5:0] = omega_12 [5:0];
            omegaShiftedInner_11 [5:0] = omega_13 [5:0];
            omegaShiftedInner_12 [5:0] = omega_14 [5:0];
            omegaShiftedInner_13 [5:0] = omega_15 [5:0];
            omegaShiftedInner_14 [5:0] = omega_16 [5:0];
            omegaShiftedInner_15 [5:0] = omega_17 [5:0];
            omegaShiftedInner_16 [5:0] = omega_18 [5:0];
            omegaShiftedInner_17 [5:0] = omega_19 [5:0];
            omegaShiftedInner_18 [5:0] = 6'd0;
            omegaShiftedInner_19 [5:0] = 6'd0;
         end
         (5'd3): begin
            omegaShiftedInner_0 [5:0]  = omega_3 [5:0];
            omegaShiftedInner_1 [5:0]  = omega_4 [5:0];
            omegaShiftedInner_2 [5:0]  = omega_5 [5:0];
            omegaShiftedInner_3 [5:0]  = omega_6 [5:0];
            omegaShiftedInner_4 [5:0]  = omega_7 [5:0];
            omegaShiftedInner_5 [5:0]  = omega_8 [5:0];
            omegaShiftedInner_6 [5:0]  = omega_9 [5:0];
            omegaShiftedInner_7 [5:0]  = omega_10 [5:0];
            omegaShiftedInner_8 [5:0]  = omega_11 [5:0];
            omegaShiftedInner_9 [5:0]  = omega_12 [5:0];
            omegaShiftedInner_10 [5:0] = omega_13 [5:0];
            omegaShiftedInner_11 [5:0] = omega_14 [5:0];
            omegaShiftedInner_12 [5:0] = omega_15 [5:0];
            omegaShiftedInner_13 [5:0] = omega_16 [5:0];
            omegaShiftedInner_14 [5:0] = omega_17 [5:0];
            omegaShiftedInner_15 [5:0] = omega_18 [5:0];
            omegaShiftedInner_16 [5:0] = omega_19 [5:0];
            omegaShiftedInner_17 [5:0] = 6'd0;
            omegaShiftedInner_18 [5:0] = 6'd0;
            omegaShiftedInner_19 [5:0] = 6'd0;
         end
         (5'd4): begin
            omegaShiftedInner_0 [5:0]  = omega_4 [5:0];
            omegaShiftedInner_1 [5:0]  = omega_5 [5:0];
            omegaShiftedInner_2 [5:0]  = omega_6 [5:0];
            omegaShiftedInner_3 [5:0]  = omega_7 [5:0];
            omegaShiftedInner_4 [5:0]  = omega_8 [5:0];
            omegaShiftedInner_5 [5:0]  = omega_9 [5:0];
            omegaShiftedInner_6 [5:0]  = omega_10 [5:0];
            omegaShiftedInner_7 [5:0]  = omega_11 [5:0];
            omegaShiftedInner_8 [5:0]  = omega_12 [5:0];
            omegaShiftedInner_9 [5:0]  = omega_13 [5:0];
            omegaShiftedInner_10 [5:0] = omega_14 [5:0];
            omegaShiftedInner_11 [5:0] = omega_15 [5:0];
            omegaShiftedInner_12 [5:0] = omega_16 [5:0];
            omegaShiftedInner_13 [5:0] = omega_17 [5:0];
            omegaShiftedInner_14 [5:0] = omega_18 [5:0];
            omegaShiftedInner_15 [5:0] = omega_19 [5:0];
            omegaShiftedInner_16 [5:0] = 6'd0;
            omegaShiftedInner_17 [5:0] = 6'd0;
            omegaShiftedInner_18 [5:0] = 6'd0;
            omegaShiftedInner_19 [5:0] = 6'd0;
         end
         (5'd5): begin
            omegaShiftedInner_0 [5:0]  = omega_5 [5:0];
            omegaShiftedInner_1 [5:0]  = omega_6 [5:0];
            omegaShiftedInner_2 [5:0]  = omega_7 [5:0];
            omegaShiftedInner_3 [5:0]  = omega_8 [5:0];
            omegaShiftedInner_4 [5:0]  = omega_9 [5:0];
            omegaShiftedInner_5 [5:0]  = omega_10 [5:0];
            omegaShiftedInner_6 [5:0]  = omega_11 [5:0];
            omegaShiftedInner_7 [5:0]  = omega_12 [5:0];
            omegaShiftedInner_8 [5:0]  = omega_13 [5:0];
            omegaShiftedInner_9 [5:0]  = omega_14 [5:0];
            omegaShiftedInner_10 [5:0] = omega_15 [5:0];
            omegaShiftedInner_11 [5:0] = omega_16 [5:0];
            omegaShiftedInner_12 [5:0] = omega_17 [5:0];
            omegaShiftedInner_13 [5:0] = omega_18 [5:0];
            omegaShiftedInner_14 [5:0] = omega_19 [5:0];
            omegaShiftedInner_15 [5:0] = 6'd0;
            omegaShiftedInner_16 [5:0] = 6'd0;
            omegaShiftedInner_17 [5:0] = 6'd0;
            omegaShiftedInner_18 [5:0] = 6'd0;
            omegaShiftedInner_19 [5:0] = 6'd0;
         end
         (5'd6): begin
            omegaShiftedInner_0 [5:0]  = omega_6 [5:0];
            omegaShiftedInner_1 [5:0]  = omega_7 [5:0];
            omegaShiftedInner_2 [5:0]  = omega_8 [5:0];
            omegaShiftedInner_3 [5:0]  = omega_9 [5:0];
            omegaShiftedInner_4 [5:0]  = omega_10 [5:0];
            omegaShiftedInner_5 [5:0]  = omega_11 [5:0];
            omegaShiftedInner_6 [5:0]  = omega_12 [5:0];
            omegaShiftedInner_7 [5:0]  = omega_13 [5:0];
            omegaShiftedInner_8 [5:0]  = omega_14 [5:0];
            omegaShiftedInner_9 [5:0]  = omega_15 [5:0];
            omegaShiftedInner_10 [5:0] = omega_16 [5:0];
            omegaShiftedInner_11 [5:0] = omega_17 [5:0];
            omegaShiftedInner_12 [5:0] = omega_18 [5:0];
            omegaShiftedInner_13 [5:0] = omega_19 [5:0];
            omegaShiftedInner_14 [5:0] = 6'd0;
            omegaShiftedInner_15 [5:0] = 6'd0;
            omegaShiftedInner_16 [5:0] = 6'd0;
            omegaShiftedInner_17 [5:0] = 6'd0;
            omegaShiftedInner_18 [5:0] = 6'd0;
            omegaShiftedInner_19 [5:0] = 6'd0;
         end
         (5'd7): begin
            omegaShiftedInner_0 [5:0]  = omega_7 [5:0];
            omegaShiftedInner_1 [5:0]  = omega_8 [5:0];
            omegaShiftedInner_2 [5:0]  = omega_9 [5:0];
            omegaShiftedInner_3 [5:0]  = omega_10 [5:0];
            omegaShiftedInner_4 [5:0]  = omega_11 [5:0];
            omegaShiftedInner_5 [5:0]  = omega_12 [5:0];
            omegaShiftedInner_6 [5:0]  = omega_13 [5:0];
            omegaShiftedInner_7 [5:0]  = omega_14 [5:0];
            omegaShiftedInner_8 [5:0]  = omega_15 [5:0];
            omegaShiftedInner_9 [5:0]  = omega_16 [5:0];
            omegaShiftedInner_10 [5:0] = omega_17 [5:0];
            omegaShiftedInner_11 [5:0] = omega_18 [5:0];
            omegaShiftedInner_12 [5:0] = omega_19 [5:0];
            omegaShiftedInner_13 [5:0] = 6'd0;
            omegaShiftedInner_14 [5:0] = 6'd0;
            omegaShiftedInner_15 [5:0] = 6'd0;
            omegaShiftedInner_16 [5:0] = 6'd0;
            omegaShiftedInner_17 [5:0] = 6'd0;
            omegaShiftedInner_18 [5:0] = 6'd0;
            omegaShiftedInner_19 [5:0] = 6'd0;
         end
         (5'd8): begin
            omegaShiftedInner_0 [5:0]  = omega_8 [5:0];
            omegaShiftedInner_1 [5:0]  = omega_9 [5:0];
            omegaShiftedInner_2 [5:0]  = omega_10 [5:0];
            omegaShiftedInner_3 [5:0]  = omega_11 [5:0];
            omegaShiftedInner_4 [5:0]  = omega_12 [5:0];
            omegaShiftedInner_5 [5:0]  = omega_13 [5:0];
            omegaShiftedInner_6 [5:0]  = omega_14 [5:0];
            omegaShiftedInner_7 [5:0]  = omega_15 [5:0];
            omegaShiftedInner_8 [5:0]  = omega_16 [5:0];
            omegaShiftedInner_9 [5:0]  = omega_17 [5:0];
            omegaShiftedInner_10 [5:0] = omega_18 [5:0];
            omegaShiftedInner_11 [5:0] = omega_19 [5:0];
            omegaShiftedInner_12 [5:0] = 6'd0;
            omegaShiftedInner_13 [5:0] = 6'd0;
            omegaShiftedInner_14 [5:0] = 6'd0;
            omegaShiftedInner_15 [5:0] = 6'd0;
            omegaShiftedInner_16 [5:0] = 6'd0;
            omegaShiftedInner_17 [5:0] = 6'd0;
            omegaShiftedInner_18 [5:0] = 6'd0;
            omegaShiftedInner_19 [5:0] = 6'd0;
         end
         (5'd9): begin
            omegaShiftedInner_0 [5:0]  = omega_9 [5:0];
            omegaShiftedInner_1 [5:0]  = omega_10 [5:0];
            omegaShiftedInner_2 [5:0]  = omega_11 [5:0];
            omegaShiftedInner_3 [5:0]  = omega_12 [5:0];
            omegaShiftedInner_4 [5:0]  = omega_13 [5:0];
            omegaShiftedInner_5 [5:0]  = omega_14 [5:0];
            omegaShiftedInner_6 [5:0]  = omega_15 [5:0];
            omegaShiftedInner_7 [5:0]  = omega_16 [5:0];
            omegaShiftedInner_8 [5:0]  = omega_17 [5:0];
            omegaShiftedInner_9 [5:0]  = omega_18 [5:0];
            omegaShiftedInner_10 [5:0] = omega_19 [5:0];
            omegaShiftedInner_11 [5:0] = 6'd0;
            omegaShiftedInner_12 [5:0] = 6'd0;
            omegaShiftedInner_13 [5:0] = 6'd0;
            omegaShiftedInner_14 [5:0] = 6'd0;
            omegaShiftedInner_15 [5:0] = 6'd0;
            omegaShiftedInner_16 [5:0] = 6'd0;
            omegaShiftedInner_17 [5:0] = 6'd0;
            omegaShiftedInner_18 [5:0] = 6'd0;
            omegaShiftedInner_19 [5:0] = 6'd0;
         end
         (5'd10): begin
            omegaShiftedInner_0 [5:0]  = omega_10 [5:0];
            omegaShiftedInner_1 [5:0]  = omega_11 [5:0];
            omegaShiftedInner_2 [5:0]  = omega_12 [5:0];
            omegaShiftedInner_3 [5:0]  = omega_13 [5:0];
            omegaShiftedInner_4 [5:0]  = omega_14 [5:0];
            omegaShiftedInner_5 [5:0]  = omega_15 [5:0];
            omegaShiftedInner_6 [5:0]  = omega_16 [5:0];
            omegaShiftedInner_7 [5:0]  = omega_17 [5:0];
            omegaShiftedInner_8 [5:0]  = omega_18 [5:0];
            omegaShiftedInner_9 [5:0]  = omega_19 [5:0];
            omegaShiftedInner_10 [5:0] = 6'd0;
            omegaShiftedInner_11 [5:0] = 6'd0;
            omegaShiftedInner_12 [5:0] = 6'd0;
            omegaShiftedInner_13 [5:0] = 6'd0;
            omegaShiftedInner_14 [5:0] = 6'd0;
            omegaShiftedInner_15 [5:0] = 6'd0;
            omegaShiftedInner_16 [5:0] = 6'd0;
            omegaShiftedInner_17 [5:0] = 6'd0;
            omegaShiftedInner_18 [5:0] = 6'd0;
            omegaShiftedInner_19 [5:0] = 6'd0;
         end
         (5'd11): begin
            omegaShiftedInner_0 [5:0]  = omega_11 [5:0];
            omegaShiftedInner_1 [5:0]  = omega_12 [5:0];
            omegaShiftedInner_2 [5:0]  = omega_13 [5:0];
            omegaShiftedInner_3 [5:0]  = omega_14 [5:0];
            omegaShiftedInner_4 [5:0]  = omega_15 [5:0];
            omegaShiftedInner_5 [5:0]  = omega_16 [5:0];
            omegaShiftedInner_6 [5:0]  = omega_17 [5:0];
            omegaShiftedInner_7 [5:0]  = omega_18 [5:0];
            omegaShiftedInner_8 [5:0]  = omega_19 [5:0];
            omegaShiftedInner_9 [5:0]  = 6'd0;
            omegaShiftedInner_10 [5:0] = 6'd0;
            omegaShiftedInner_11 [5:0] = 6'd0;
            omegaShiftedInner_12 [5:0] = 6'd0;
            omegaShiftedInner_13 [5:0] = 6'd0;
            omegaShiftedInner_14 [5:0] = 6'd0;
            omegaShiftedInner_15 [5:0] = 6'd0;
            omegaShiftedInner_16 [5:0] = 6'd0;
            omegaShiftedInner_17 [5:0] = 6'd0;
            omegaShiftedInner_18 [5:0] = 6'd0;
            omegaShiftedInner_19 [5:0] = 6'd0;
         end
         (5'd12): begin
            omegaShiftedInner_0 [5:0]  = omega_12 [5:0];
            omegaShiftedInner_1 [5:0]  = omega_13 [5:0];
            omegaShiftedInner_2 [5:0]  = omega_14 [5:0];
            omegaShiftedInner_3 [5:0]  = omega_15 [5:0];
            omegaShiftedInner_4 [5:0]  = omega_16 [5:0];
            omegaShiftedInner_5 [5:0]  = omega_17 [5:0];
            omegaShiftedInner_6 [5:0]  = omega_18 [5:0];
            omegaShiftedInner_7 [5:0]  = omega_19 [5:0];
            omegaShiftedInner_8 [5:0]  = 6'd0;
            omegaShiftedInner_9 [5:0]  = 6'd0;
            omegaShiftedInner_10 [5:0] = 6'd0;
            omegaShiftedInner_11 [5:0] = 6'd0;
            omegaShiftedInner_12 [5:0] = 6'd0;
            omegaShiftedInner_13 [5:0] = 6'd0;
            omegaShiftedInner_14 [5:0] = 6'd0;
            omegaShiftedInner_15 [5:0] = 6'd0;
            omegaShiftedInner_16 [5:0] = 6'd0;
            omegaShiftedInner_17 [5:0] = 6'd0;
            omegaShiftedInner_18 [5:0] = 6'd0;
            omegaShiftedInner_19 [5:0] = 6'd0;
         end
         (5'd13): begin
            omegaShiftedInner_0 [5:0]  = omega_13 [5:0];
            omegaShiftedInner_1 [5:0]  = omega_14 [5:0];
            omegaShiftedInner_2 [5:0]  = omega_15 [5:0];
            omegaShiftedInner_3 [5:0]  = omega_16 [5:0];
            omegaShiftedInner_4 [5:0]  = omega_17 [5:0];
            omegaShiftedInner_5 [5:0]  = omega_18 [5:0];
            omegaShiftedInner_6 [5:0]  = omega_19 [5:0];
            omegaShiftedInner_7 [5:0]  = 6'd0;
            omegaShiftedInner_8 [5:0]  = 6'd0;
            omegaShiftedInner_9 [5:0]  = 6'd0;
            omegaShiftedInner_10 [5:0] = 6'd0;
            omegaShiftedInner_11 [5:0] = 6'd0;
            omegaShiftedInner_12 [5:0] = 6'd0;
            omegaShiftedInner_13 [5:0] = 6'd0;
            omegaShiftedInner_14 [5:0] = 6'd0;
            omegaShiftedInner_15 [5:0] = 6'd0;
            omegaShiftedInner_16 [5:0] = 6'd0;
            omegaShiftedInner_17 [5:0] = 6'd0;
            omegaShiftedInner_18 [5:0] = 6'd0;
            omegaShiftedInner_19 [5:0] = 6'd0;
         end
         (5'd14): begin
            omegaShiftedInner_0 [5:0]  = omega_14 [5:0];
            omegaShiftedInner_1 [5:0]  = omega_15 [5:0];
            omegaShiftedInner_2 [5:0]  = omega_16 [5:0];
            omegaShiftedInner_3 [5:0]  = omega_17 [5:0];
            omegaShiftedInner_4 [5:0]  = omega_18 [5:0];
            omegaShiftedInner_5 [5:0]  = omega_19 [5:0];
            omegaShiftedInner_6 [5:0]  = 6'd0;
            omegaShiftedInner_7 [5:0]  = 6'd0;
            omegaShiftedInner_8 [5:0]  = 6'd0;
            omegaShiftedInner_9 [5:0]  = 6'd0;
            omegaShiftedInner_10 [5:0] = 6'd0;
            omegaShiftedInner_11 [5:0] = 6'd0;
            omegaShiftedInner_12 [5:0] = 6'd0;
            omegaShiftedInner_13 [5:0] = 6'd0;
            omegaShiftedInner_14 [5:0] = 6'd0;
            omegaShiftedInner_15 [5:0] = 6'd0;
            omegaShiftedInner_16 [5:0] = 6'd0;
            omegaShiftedInner_17 [5:0] = 6'd0;
            omegaShiftedInner_18 [5:0] = 6'd0;
            omegaShiftedInner_19 [5:0] = 6'd0;
         end
         (5'd15): begin
            omegaShiftedInner_0 [5:0]  = omega_15 [5:0];
            omegaShiftedInner_1 [5:0]  = omega_16 [5:0];
            omegaShiftedInner_2 [5:0]  = omega_17 [5:0];
            omegaShiftedInner_3 [5:0]  = omega_18 [5:0];
            omegaShiftedInner_4 [5:0]  = omega_19 [5:0];
            omegaShiftedInner_5 [5:0]  = 6'd0;
            omegaShiftedInner_6 [5:0]  = 6'd0;
            omegaShiftedInner_7 [5:0]  = 6'd0;
            omegaShiftedInner_8 [5:0]  = 6'd0;
            omegaShiftedInner_9 [5:0]  = 6'd0;
            omegaShiftedInner_10 [5:0] = 6'd0;
            omegaShiftedInner_11 [5:0] = 6'd0;
            omegaShiftedInner_12 [5:0] = 6'd0;
            omegaShiftedInner_13 [5:0] = 6'd0;
            omegaShiftedInner_14 [5:0] = 6'd0;
            omegaShiftedInner_15 [5:0] = 6'd0;
            omegaShiftedInner_16 [5:0] = 6'd0;
            omegaShiftedInner_17 [5:0] = 6'd0;
            omegaShiftedInner_18 [5:0] = 6'd0;
            omegaShiftedInner_19 [5:0] = 6'd0;
         end
         (5'd16): begin
            omegaShiftedInner_0 [5:0]  = omega_16 [5:0];
            omegaShiftedInner_1 [5:0]  = omega_17 [5:0];
            omegaShiftedInner_2 [5:0]  = omega_18 [5:0];
            omegaShiftedInner_3 [5:0]  = omega_19 [5:0];
            omegaShiftedInner_4 [5:0]  = 6'd0;
            omegaShiftedInner_5 [5:0]  = 6'd0;
            omegaShiftedInner_6 [5:0]  = 6'd0;
            omegaShiftedInner_7 [5:0]  = 6'd0;
            omegaShiftedInner_8 [5:0]  = 6'd0;
            omegaShiftedInner_9 [5:0]  = 6'd0;
            omegaShiftedInner_10 [5:0] = 6'd0;
            omegaShiftedInner_11 [5:0] = 6'd0;
            omegaShiftedInner_12 [5:0] = 6'd0;
            omegaShiftedInner_13 [5:0] = 6'd0;
            omegaShiftedInner_14 [5:0] = 6'd0;
            omegaShiftedInner_15 [5:0] = 6'd0;
            omegaShiftedInner_16 [5:0] = 6'd0;
            omegaShiftedInner_17 [5:0] = 6'd0;
            omegaShiftedInner_18 [5:0] = 6'd0;
            omegaShiftedInner_19 [5:0] = 6'd0;
         end
         (5'd17): begin
            omegaShiftedInner_0 [5:0]  = omega_17 [5:0];
            omegaShiftedInner_1 [5:0]  = omega_18 [5:0];
            omegaShiftedInner_2 [5:0]  = omega_19 [5:0];
            omegaShiftedInner_3 [5:0]  = 6'd0;
            omegaShiftedInner_4 [5:0]  = 6'd0;
            omegaShiftedInner_5 [5:0]  = 6'd0;
            omegaShiftedInner_6 [5:0]  = 6'd0;
            omegaShiftedInner_7 [5:0]  = 6'd0;
            omegaShiftedInner_8 [5:0]  = 6'd0;
            omegaShiftedInner_9 [5:0]  = 6'd0;
            omegaShiftedInner_10 [5:0] = 6'd0;
            omegaShiftedInner_11 [5:0] = 6'd0;
            omegaShiftedInner_12 [5:0] = 6'd0;
            omegaShiftedInner_13 [5:0] = 6'd0;
            omegaShiftedInner_14 [5:0] = 6'd0;
            omegaShiftedInner_15 [5:0] = 6'd0;
            omegaShiftedInner_16 [5:0] = 6'd0;
            omegaShiftedInner_17 [5:0] = 6'd0;
            omegaShiftedInner_18 [5:0] = 6'd0;
            omegaShiftedInner_19 [5:0] = 6'd0;
         end
         (5'd18): begin
            omegaShiftedInner_0 [5:0]  = omega_18 [5:0];
            omegaShiftedInner_1 [5:0]  = omega_19 [5:0];
            omegaShiftedInner_2 [5:0]  = 6'd0;
            omegaShiftedInner_3 [5:0]  = 6'd0;
            omegaShiftedInner_4 [5:0]  = 6'd0;
            omegaShiftedInner_5 [5:0]  = 6'd0;
            omegaShiftedInner_6 [5:0]  = 6'd0;
            omegaShiftedInner_7 [5:0]  = 6'd0;
            omegaShiftedInner_8 [5:0]  = 6'd0;
            omegaShiftedInner_9 [5:0]  = 6'd0;
            omegaShiftedInner_10 [5:0] = 6'd0;
            omegaShiftedInner_11 [5:0] = 6'd0;
            omegaShiftedInner_12 [5:0] = 6'd0;
            omegaShiftedInner_13 [5:0] = 6'd0;
            omegaShiftedInner_14 [5:0] = 6'd0;
            omegaShiftedInner_15 [5:0] = 6'd0;
            omegaShiftedInner_16 [5:0] = 6'd0;
            omegaShiftedInner_17 [5:0] = 6'd0;
            omegaShiftedInner_18 [5:0] = 6'd0;
            omegaShiftedInner_19 [5:0] = 6'd0;
         end
         (5'd19): begin
            omegaShiftedInner_0 [5:0]  = omega_19 [5:0];
            omegaShiftedInner_1 [5:0]  = 6'd0;
            omegaShiftedInner_2 [5:0]  = 6'd0;
            omegaShiftedInner_3 [5:0]  = 6'd0;
            omegaShiftedInner_4 [5:0]  = 6'd0;
            omegaShiftedInner_5 [5:0]  = 6'd0;
            omegaShiftedInner_6 [5:0]  = 6'd0;
            omegaShiftedInner_7 [5:0]  = 6'd0;
            omegaShiftedInner_8 [5:0]  = 6'd0;
            omegaShiftedInner_9 [5:0]  = 6'd0;
            omegaShiftedInner_10 [5:0] = 6'd0;
            omegaShiftedInner_11 [5:0] = 6'd0;
            omegaShiftedInner_12 [5:0] = 6'd0;
            omegaShiftedInner_13 [5:0] = 6'd0;
            omegaShiftedInner_14 [5:0] = 6'd0;
            omegaShiftedInner_15 [5:0] = 6'd0;
            omegaShiftedInner_16 [5:0] = 6'd0;
            omegaShiftedInner_17 [5:0] = 6'd0;
            omegaShiftedInner_18 [5:0] = 6'd0;
            omegaShiftedInner_19 [5:0] = 6'd0;
         end
         default: begin
            omegaShiftedInner_0 [5:0]  = 6'd0;
            omegaShiftedInner_1 [5:0]  = 6'd0;
            omegaShiftedInner_2 [5:0]  = 6'd0;
            omegaShiftedInner_3 [5:0]  = 6'd0;
            omegaShiftedInner_4 [5:0]  = 6'd0;
            omegaShiftedInner_5 [5:0]  = 6'd0;
            omegaShiftedInner_6 [5:0]  = 6'd0;
            omegaShiftedInner_7 [5:0]  = 6'd0;
            omegaShiftedInner_8 [5:0]  = 6'd0;
            omegaShiftedInner_9 [5:0]  = 6'd0;
            omegaShiftedInner_10 [5:0] = 6'd0;
            omegaShiftedInner_11 [5:0] = 6'd0;
            omegaShiftedInner_12 [5:0] = 6'd0;
            omegaShiftedInner_13 [5:0] = 6'd0;
            omegaShiftedInner_14 [5:0] = 6'd0;
            omegaShiftedInner_15 [5:0] = 6'd0;
            omegaShiftedInner_16 [5:0] = 6'd0;
            omegaShiftedInner_17 [5:0] = 6'd0;
            omegaShiftedInner_18 [5:0] = 6'd0;
            omegaShiftedInner_19 [5:0] = 6'd0;
         end
        endcase
    end



   //------------------------------------------------------------------------
   //- Output Ports
   //------------------------------------------------------------------------
   assign omegaShifted_0   = omegaShiftedInner_0;
   assign omegaShifted_1   = omegaShiftedInner_1;
   assign omegaShifted_2   = omegaShiftedInner_2;
   assign omegaShifted_3   = omegaShiftedInner_3;
   assign omegaShifted_4   = omegaShiftedInner_4;
   assign omegaShifted_5   = omegaShiftedInner_5;
   assign omegaShifted_6   = omegaShiftedInner_6;
   assign omegaShifted_7   = omegaShiftedInner_7;
   assign omegaShifted_8   = omegaShiftedInner_8;
   assign omegaShifted_9   = omegaShiftedInner_9;
   assign omegaShifted_10  = omegaShiftedInner_10;
   assign omegaShifted_11  = omegaShiftedInner_11;
   assign omegaShifted_12  = omegaShiftedInner_12;
   assign omegaShifted_13  = omegaShiftedInner_13;
   assign omegaShifted_14  = omegaShiftedInner_14;
   assign omegaShifted_15  = omegaShiftedInner_15;
   assign omegaShifted_16  = omegaShiftedInner_16;
   assign omegaShifted_17  = omegaShiftedInner_17;
   assign omegaShifted_18  = omegaShiftedInner_18;
   assign omegaShifted_19  = omegaShiftedInner_19;



endmodule
