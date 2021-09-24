//===================================================================
// Module Name : RsDecodeEuclide
// File Name   : RsDecodeEuclide.v
// Function    : Rs Decoder Euclide algorithm Module
// 
// Revision History:
// Date          By           Version    Change Description
//===================================================================
// 2009/02/03  Gael Sapience     1.0       Original
//
//===================================================================
// (C) COPYRIGHT 2009 SYSTEM LSI CO., Ltd.
//


module RsDecodeEuclide(
   CLK,           // system clock
   RESET,         // system reset
   enable,        // enable signal
   sync,          // sync signal
   syndrome_0,    // syndrome polynom 0
   syndrome_1,    // syndrome polynom 1
   syndrome_2,    // syndrome polynom 2
   syndrome_3,    // syndrome polynom 3
   syndrome_4,    // syndrome polynom 4
   syndrome_5,    // syndrome polynom 5
   syndrome_6,    // syndrome polynom 6
   syndrome_7,    // syndrome polynom 7
   syndrome_8,    // syndrome polynom 8
   syndrome_9,    // syndrome polynom 9
   syndrome_10,   // syndrome polynom 10
   syndrome_11,   // syndrome polynom 11
   syndrome_12,   // syndrome polynom 12
   syndrome_13,   // syndrome polynom 13
   syndrome_14,   // syndrome polynom 14
   syndrome_15,   // syndrome polynom 15
   syndrome_16,   // syndrome polynom 16
   syndrome_17,   // syndrome polynom 17
   syndrome_18,   // syndrome polynom 18
   syndrome_19,   // syndrome polynom 19
   numErasure,    // erasure amount
   lambda_0,      // lambda polynom 0
   lambda_1,      // lambda polynom 1
   lambda_2,      // lambda polynom 2
   lambda_3,      // lambda polynom 3
   lambda_4,      // lambda polynom 4
   lambda_5,      // lambda polynom 5
   lambda_6,      // lambda polynom 6
   lambda_7,      // lambda polynom 7
   lambda_8,      // lambda polynom 8
   lambda_9,      // lambda polynom 9
   lambda_10,     // lambda polynom 10
   lambda_11,     // lambda polynom 11
   lambda_12,     // lambda polynom 12
   lambda_13,     // lambda polynom 13
   lambda_14,     // lambda polynom 14
   lambda_15,     // lambda polynom 15
   lambda_16,     // lambda polynom 16
   lambda_17,     // lambda polynom 17
   lambda_18,     // lambda polynom 18
   lambda_19,     // lambda polynom 19
   omega_0,       // omega polynom 0
   omega_1,       // omega polynom 1
   omega_2,       // omega polynom 2
   omega_3,       // omega polynom 3
   omega_4,       // omega polynom 4
   omega_5,       // omega polynom 5
   omega_6,       // omega polynom 6
   omega_7,       // omega polynom 7
   omega_8,       // omega polynom 8
   omega_9,       // omega polynom 9
   omega_10,      // omega polynom 10
   omega_11,      // omega polynom 11
   omega_12,      // omega polynom 12
   omega_13,      // omega polynom 13
   omega_14,      // omega polynom 14
   omega_15,      // omega polynom 15
   omega_16,      // omega polynom 16
   omega_17,      // omega polynom 17
   omega_18,      // omega polynom 18
   omega_19,      // omega polynom 19
   numShifted,    // shift amount
   done           // done signal
);


   input          CLK;           // system clock
   input          RESET;         // system reset
   input          enable;        // enable signal
   input          sync;          // sync signal
   input  [5:0]   syndrome_0;    // syndrome polynom 0
   input  [5:0]   syndrome_1;    // syndrome polynom 1
   input  [5:0]   syndrome_2;    // syndrome polynom 2
   input  [5:0]   syndrome_3;    // syndrome polynom 3
   input  [5:0]   syndrome_4;    // syndrome polynom 4
   input  [5:0]   syndrome_5;    // syndrome polynom 5
   input  [5:0]   syndrome_6;    // syndrome polynom 6
   input  [5:0]   syndrome_7;    // syndrome polynom 7
   input  [5:0]   syndrome_8;    // syndrome polynom 8
   input  [5:0]   syndrome_9;    // syndrome polynom 9
   input  [5:0]   syndrome_10;   // syndrome polynom 10
   input  [5:0]   syndrome_11;   // syndrome polynom 11
   input  [5:0]   syndrome_12;   // syndrome polynom 12
   input  [5:0]   syndrome_13;   // syndrome polynom 13
   input  [5:0]   syndrome_14;   // syndrome polynom 14
   input  [5:0]   syndrome_15;   // syndrome polynom 15
   input  [5:0]   syndrome_16;   // syndrome polynom 16
   input  [5:0]   syndrome_17;   // syndrome polynom 17
   input  [5:0]   syndrome_18;   // syndrome polynom 18
   input  [5:0]   syndrome_19;   // syndrome polynom 19
   input  [4:0]   numErasure;    // erasure amount

   output [5:0]   lambda_0;       // lambda polynom 0
   output [5:0]   lambda_1;       // lambda polynom 1
   output [5:0]   lambda_2;       // lambda polynom 2
   output [5:0]   lambda_3;       // lambda polynom 3
   output [5:0]   lambda_4;       // lambda polynom 4
   output [5:0]   lambda_5;       // lambda polynom 5
   output [5:0]   lambda_6;       // lambda polynom 6
   output [5:0]   lambda_7;       // lambda polynom 7
   output [5:0]   lambda_8;       // lambda polynom 8
   output [5:0]   lambda_9;       // lambda polynom 9
   output [5:0]   lambda_10;      // lambda polynom 10
   output [5:0]   lambda_11;      // lambda polynom 11
   output [5:0]   lambda_12;      // lambda polynom 12
   output [5:0]   lambda_13;      // lambda polynom 13
   output [5:0]   lambda_14;      // lambda polynom 14
   output [5:0]   lambda_15;      // lambda polynom 15
   output [5:0]   lambda_16;      // lambda polynom 16
   output [5:0]   lambda_17;      // lambda polynom 17
   output [5:0]   lambda_18;      // lambda polynom 18
   output [5:0]   lambda_19;      // lambda polynom 19
   output [5:0]   omega_0;        // omega polynom 0
   output [5:0]   omega_1;        // omega polynom 1
   output [5:0]   omega_2;        // omega polynom 2
   output [5:0]   omega_3;        // omega polynom 3
   output [5:0]   omega_4;        // omega polynom 4
   output [5:0]   omega_5;        // omega polynom 5
   output [5:0]   omega_6;        // omega polynom 6
   output [5:0]   omega_7;        // omega polynom 7
   output [5:0]   omega_8;        // omega polynom 8
   output [5:0]   omega_9;        // omega polynom 9
   output [5:0]   omega_10;       // omega polynom 10
   output [5:0]   omega_11;       // omega polynom 11
   output [5:0]   omega_12;       // omega polynom 12
   output [5:0]   omega_13;       // omega polynom 13
   output [5:0]   omega_14;       // omega polynom 14
   output [5:0]   omega_15;       // omega polynom 15
   output [5:0]   omega_16;       // omega polynom 16
   output [5:0]   omega_17;       // omega polynom 17
   output [5:0]   omega_18;       // omega polynom 18
   output [5:0]   omega_19;       // omega polynom 19
   output [4:0]   numShifted;     // shift amount
   output         done;           // done signal





   //------------------------------------------------------------------------
   // -registers
   //------------------------------------------------------------------------
   reg [5:0]   omegaBkp_0;
   reg [5:0]   omegaBkp_1;
   reg [5:0]   omegaBkp_2;
   reg [5:0]   omegaBkp_3;
   reg [5:0]   omegaBkp_4;
   reg [5:0]   omegaBkp_5;
   reg [5:0]   omegaBkp_6;
   reg [5:0]   omegaBkp_7;
   reg [5:0]   omegaBkp_8;
   reg [5:0]   omegaBkp_9;
   reg [5:0]   omegaBkp_10;
   reg [5:0]   omegaBkp_11;
   reg [5:0]   omegaBkp_12;
   reg [5:0]   omegaBkp_13;
   reg [5:0]   omegaBkp_14;
   reg [5:0]   omegaBkp_15;
   reg [5:0]   omegaBkp_16;
   reg [5:0]   omegaBkp_17;
   reg [5:0]   omegaBkp_18;
   reg [5:0]   omegaBkp_19;
   reg [5:0]   lambdaBkp_0;
   reg [5:0]   lambdaBkp_1;
   reg [5:0]   lambdaBkp_2;
   reg [5:0]   lambdaBkp_3;
   reg [5:0]   lambdaBkp_4;
   reg [5:0]   lambdaBkp_5;
   reg [5:0]   lambdaBkp_6;
   reg [5:0]   lambdaBkp_7;
   reg [5:0]   lambdaBkp_8;
   reg [5:0]   lambdaBkp_9;
   reg [5:0]   lambdaBkp_10;
   reg [5:0]   lambdaBkp_11;
   reg [5:0]   lambdaBkp_12;
   reg [5:0]   lambdaBkp_13;
   reg [5:0]   lambdaBkp_14;
   reg [5:0]   lambdaBkp_15;
   reg [5:0]   lambdaBkp_16;
   reg [5:0]   lambdaBkp_17;
   reg [5:0]   lambdaBkp_18;
   reg [5:0]   lambdaBkp_19;
   reg [5:0]   lambdaInner_0;
   reg [5:0]   lambdaInner_1;
   reg [5:0]   lambdaInner_2;
   reg [5:0]   lambdaInner_3;
   reg [5:0]   lambdaInner_4;
   reg [5:0]   lambdaInner_5;
   reg [5:0]   lambdaInner_6;
   reg [5:0]   lambdaInner_7;
   reg [5:0]   lambdaInner_8;
   reg [5:0]   lambdaInner_9;
   reg [5:0]   lambdaInner_10;
   reg [5:0]   lambdaInner_11;
   reg [5:0]   lambdaInner_12;
   reg [5:0]   lambdaInner_13;
   reg [5:0]   lambdaInner_14;
   reg [5:0]   lambdaInner_15;
   reg [5:0]   lambdaInner_16;
   reg [5:0]   lambdaInner_17;
   reg [5:0]   lambdaInner_18;
   reg [5:0]   lambdaInner_19;
   reg [5:0]   lambdaXorReg_0;
   reg [5:0]   lambdaXorReg_1;
   reg [5:0]   lambdaXorReg_2;
   reg [5:0]   lambdaXorReg_3;
   reg [5:0]   lambdaXorReg_4;
   reg [5:0]   lambdaXorReg_5;
   reg [5:0]   lambdaXorReg_6;
   reg [5:0]   lambdaXorReg_7;
   reg [5:0]   lambdaXorReg_8;
   reg [5:0]   lambdaXorReg_9;
   reg [5:0]   lambdaXorReg_10;
   reg [5:0]   lambdaXorReg_11;
   reg [5:0]   lambdaXorReg_12;
   reg [5:0]   lambdaXorReg_13;
   reg [5:0]   lambdaXorReg_14;
   reg [5:0]   lambdaXorReg_15;
   reg [5:0]   lambdaXorReg_16;
   reg [5:0]   lambdaXorReg_17;
   reg [5:0]   lambdaXorReg_18;
   wire [5:0]   omegaMultqNew_0;
   wire [5:0]   omegaMultqNew_1;
   wire [5:0]   omegaMultqNew_2;
   wire [5:0]   omegaMultqNew_3;
   wire [5:0]   omegaMultqNew_4;
   wire [5:0]   omegaMultqNew_5;
   wire [5:0]   omegaMultqNew_6;
   wire [5:0]   omegaMultqNew_7;
   wire [5:0]   omegaMultqNew_8;
   wire [5:0]   omegaMultqNew_9;
   wire [5:0]   omegaMultqNew_10;
   wire [5:0]   omegaMultqNew_11;
   wire [5:0]   omegaMultqNew_12;
   wire [5:0]   omegaMultqNew_13;
   wire [5:0]   omegaMultqNew_14;
   wire [5:0]   omegaMultqNew_15;
   wire [5:0]   omegaMultqNew_16;
   wire [5:0]   omegaMultqNew_17;
   wire [5:0]   omegaMultqNew_18;
   wire [5:0]   lambdaMultqNew_0;
   wire [5:0]   lambdaMultqNew_1;
   wire [5:0]   lambdaMultqNew_2;
   wire [5:0]   lambdaMultqNew_3;
   wire [5:0]   lambdaMultqNew_4;
   wire [5:0]   lambdaMultqNew_5;
   wire [5:0]   lambdaMultqNew_6;
   wire [5:0]   lambdaMultqNew_7;
   wire [5:0]   lambdaMultqNew_8;
   wire [5:0]   lambdaMultqNew_9;
   wire [5:0]   lambdaMultqNew_10;
   wire [5:0]   lambdaMultqNew_11;
   wire [5:0]   lambdaMultqNew_12;
   wire [5:0]   lambdaMultqNew_13;
   wire [5:0]   lambdaMultqNew_14;
   wire [5:0]   lambdaMultqNew_15;
   wire [5:0]   lambdaMultqNew_16;
   wire [5:0]   lambdaMultqNew_17;
   wire [5:0]   lambdaMultqNew_18;
   wire [5:0]   lambdaMultqNew_19;
   reg  [4:0]   offset;
   reg  [4:0]   numShiftedReg;



   //------------------------------------------------------------------------
   // + phase
   // Counters
   //------------------------------------------------------------------------
   reg     [1:0]   phase;
   always @(posedge CLK or negedge RESET) begin
      if (~RESET) begin
         phase [1:0] <= 2'd0;
      end
      else if (enable == 1'b1) begin
         if (sync == 1'b1) begin
            phase [1:0] <= 2'd1;
         end
         else if (phase [1:0] == 2'd2) begin
            phase [1:0] <= 2'd0;
         end
         else begin
            phase [1:0] <= phase [1:0] + 2'd1;
         end
      end
   end



   //------------------------------------------------------------------------
   // + count
   //- Counter
   //------------------------------------------------------------------------
   reg     [5:0]   count;
   always @(posedge CLK or negedge RESET) begin
      if (~RESET) begin
         count [5:0] <= 6'd0;
      end
      else if (enable == 1'b1) begin
         if (sync == 1'b1) begin
            count [5:0] <= 6'd1;
         end
         else if ( (count [5:0]==6'd0) ||  (count [5:0]==6'd63) ) begin
            count [5:0] <= 6'd0;
         end
         else begin
            count [5:0] <=  count [5:0] + 6'd1;
         end
      end
   end



   //------------------------------------------------------------------
   // + skip
   //------------------------------------------------------------------
   reg [5:0]   omegaInner_0;
   reg [5:0]   omegaInner_1;
   reg [5:0]   omegaInner_2;
   reg [5:0]   omegaInner_3;
   reg [5:0]   omegaInner_4;
   reg [5:0]   omegaInner_5;
   reg [5:0]   omegaInner_6;
   reg [5:0]   omegaInner_7;
   reg [5:0]   omegaInner_8;
   reg [5:0]   omegaInner_9;
   reg [5:0]   omegaInner_10;
   reg [5:0]   omegaInner_11;
   reg [5:0]   omegaInner_12;
   reg [5:0]   omegaInner_13;
   reg [5:0]   omegaInner_14;
   reg [5:0]   omegaInner_15;
   reg [5:0]   omegaInner_16;
   reg [5:0]   omegaInner_17;
   reg [5:0]   omegaInner_18;
   reg [5:0]   omegaInner_19;
   reg         skip;

   always @(omegaInner_19) begin
      if (omegaInner_19 [5:0] == 6'd0) begin
         skip   = 1'b1;
      end else begin
         skip   = 1'b0;
      end
   end


   //------------------------------------------------------------------------
   // + done
   //------------------------------------------------------------------------
   reg         done;
   always @(count) begin
      if (count[5:0] == 6'd63) begin
         done = 1'b1;
      end
      else begin
         done = 1'b0;
      end
   end


   //------------------------------------------------------------------
   // + euclideSteps
   //------------------------------------------------------------------
   reg     [5:0]   euclideSteps;
   always @(posedge CLK or negedge RESET) begin
      if (~RESET) begin
         euclideSteps <= 6'd0;
      end
      else if (sync) begin
      case (numErasure[4:0])
         5'd0: begin
            euclideSteps[5:0] <=  6'd63; // step: 0
         end
         5'd1: begin
            euclideSteps[5:0] <=  6'd57; // step: 1
         end
         5'd2: begin
            euclideSteps[5:0] <=  6'd57; // step: 2
         end
         5'd3: begin
            euclideSteps[5:0] <=  6'd51; // step: 3
         end
         5'd4: begin
            euclideSteps[5:0] <=  6'd51; // step: 4
         end
         5'd5: begin
            euclideSteps[5:0] <=  6'd45; // step: 5
         end
         5'd6: begin
            euclideSteps[5:0] <=  6'd45; // step: 6
         end
         5'd7: begin
            euclideSteps[5:0] <=  6'd39; // step: 7
         end
         5'd8: begin
            euclideSteps[5:0] <=  6'd39; // step: 8
         end
         5'd9: begin
            euclideSteps[5:0] <=  6'd33; // step: 9
         end
         5'd10: begin
            euclideSteps[5:0] <=  6'd33; // step: 10
         end
         5'd11: begin
            euclideSteps[5:0] <=  6'd27; // step: 11
         end
         5'd12: begin
            euclideSteps[5:0] <=  6'd27; // step: 12
         end
         5'd13: begin
            euclideSteps[5:0] <=  6'd21; // step: 13
         end
         5'd14: begin
            euclideSteps[5:0] <=  6'd21; // step: 14
         end
         5'd15: begin
            euclideSteps[5:0] <=  6'd15; // step: 15
         end
         5'd16: begin
            euclideSteps[5:0] <=  6'd15; // step: 16
         end
         5'd17: begin
            euclideSteps[5:0] <=  6'd9; // step: 17
         end
         5'd18: begin
            euclideSteps[5:0] <=  6'd9; // step: 18
         end
         5'd19: begin
            euclideSteps[5:0] <=  6'd3; // step: 19
         end
         5'd20: begin
            euclideSteps[5:0] <=  6'd3; // step: 20
         end
         default: begin
            euclideSteps[5:0] <= 6'd0;
         end
      endcase
     end
   end


   //------------------------------------------------------------------
   // + enable_E
   //------------------------------------------------------------------
   reg          enable_E;
   always @(sync or count or enable or numErasure or euclideSteps) begin
      if (numErasure[4:0] <= 5'd20) begin
         if ((sync == 1'b1) || (count[5:0] <= euclideSteps[5:0])) begin
            enable_E   = enable;
         end
         else begin
            enable_E   = 1'b0;
         end
      end
      else begin
         if ((sync == 1'b1) || (count[5:0] <= 6'd3)) begin
            enable_E   = enable;
         end
         else begin
            enable_E   = 1'b0;
         end
      end
   end


   //------------------------------------------------------------------------
   // Get Partial Q
   //------------------------------------------------------------------------
   wire   [5:0]   omegaInv;
   reg    [5:0]   omegaInvReg;
   wire   [5:0]   qNew;
   reg    [5:0]   qNewReg;
   reg    [5:0]   omegaBkpReg;

   RsDecodeInv RsDecodeInv_Q (.B(omegaInner_19[5:0]), .R(omegaInv[5:0]));
   RsDecodeMult RsDecodeMult_Q (.A(omegaBkpReg[5:0]), .B(omegaInvReg[5:0]), .P(qNew[5:0]) );


   //------------------------------------------------------------------
   // + omegaInvReg
   //------------------------------------------------------------------
   always @(posedge CLK or negedge RESET) begin
      if (~RESET) begin
         omegaInvReg   <= 6'd0;
      end
      else if (enable == 1'b1) begin
         omegaInvReg   <= omegaInv;
      end
   end


   //------------------------------------------------------------------
   // + omegaBkpReg
   //------------------------------------------------------------------
   always @(posedge CLK or negedge RESET) begin
      if (~RESET) begin
         omegaBkpReg   <= 6'd0;
      end
      else if (enable == 1'b1) begin
         omegaBkpReg   <= omegaBkp_19[5:0];
      end
   end


   //------------------------------------------------------------------
   // + qNewReg
   //------------------------------------------------------------------
   always @(posedge CLK or negedge RESET) begin
      if (~RESET) begin
         qNewReg   <= 6'd0;
      end
      else if (enable == 1'b1) begin
         qNewReg   <= qNew;
      end
   end


   //------------------------------------------------------------------------
   // + omegaMultqNew_0,..., omegaMultqNew_18
   //- QT = qNewReg * omegaInner
   //- Multipliers
   //------------------------------------------------------------------------
   RsDecodeMult   RsDecodeMult_PDIV0 (.A(qNewReg[5:0]), .B(omegaInner_0[5:0]), .P(omegaMultqNew_0[5:0]) );
   RsDecodeMult   RsDecodeMult_PDIV1 (.A(qNewReg[5:0]), .B(omegaInner_1[5:0]), .P(omegaMultqNew_1[5:0]) );
   RsDecodeMult   RsDecodeMult_PDIV2 (.A(qNewReg[5:0]), .B(omegaInner_2[5:0]), .P(omegaMultqNew_2[5:0]) );
   RsDecodeMult   RsDecodeMult_PDIV3 (.A(qNewReg[5:0]), .B(omegaInner_3[5:0]), .P(omegaMultqNew_3[5:0]) );
   RsDecodeMult   RsDecodeMult_PDIV4 (.A(qNewReg[5:0]), .B(omegaInner_4[5:0]), .P(omegaMultqNew_4[5:0]) );
   RsDecodeMult   RsDecodeMult_PDIV5 (.A(qNewReg[5:0]), .B(omegaInner_5[5:0]), .P(omegaMultqNew_5[5:0]) );
   RsDecodeMult   RsDecodeMult_PDIV6 (.A(qNewReg[5:0]), .B(omegaInner_6[5:0]), .P(omegaMultqNew_6[5:0]) );
   RsDecodeMult   RsDecodeMult_PDIV7 (.A(qNewReg[5:0]), .B(omegaInner_7[5:0]), .P(omegaMultqNew_7[5:0]) );
   RsDecodeMult   RsDecodeMult_PDIV8 (.A(qNewReg[5:0]), .B(omegaInner_8[5:0]), .P(omegaMultqNew_8[5:0]) );
   RsDecodeMult   RsDecodeMult_PDIV9 (.A(qNewReg[5:0]), .B(omegaInner_9[5:0]), .P(omegaMultqNew_9[5:0]) );
   RsDecodeMult   RsDecodeMult_PDIV10 (.A(qNewReg[5:0]), .B(omegaInner_10[5:0]), .P(omegaMultqNew_10[5:0]) );
   RsDecodeMult   RsDecodeMult_PDIV11 (.A(qNewReg[5:0]), .B(omegaInner_11[5:0]), .P(omegaMultqNew_11[5:0]) );
   RsDecodeMult   RsDecodeMult_PDIV12 (.A(qNewReg[5:0]), .B(omegaInner_12[5:0]), .P(omegaMultqNew_12[5:0]) );
   RsDecodeMult   RsDecodeMult_PDIV13 (.A(qNewReg[5:0]), .B(omegaInner_13[5:0]), .P(omegaMultqNew_13[5:0]) );
   RsDecodeMult   RsDecodeMult_PDIV14 (.A(qNewReg[5:0]), .B(omegaInner_14[5:0]), .P(omegaMultqNew_14[5:0]) );
   RsDecodeMult   RsDecodeMult_PDIV15 (.A(qNewReg[5:0]), .B(omegaInner_15[5:0]), .P(omegaMultqNew_15[5:0]) );
   RsDecodeMult   RsDecodeMult_PDIV16 (.A(qNewReg[5:0]), .B(omegaInner_16[5:0]), .P(omegaMultqNew_16[5:0]) );
   RsDecodeMult   RsDecodeMult_PDIV17 (.A(qNewReg[5:0]), .B(omegaInner_17[5:0]), .P(omegaMultqNew_17[5:0]) );
   RsDecodeMult   RsDecodeMult_PDIV18 (.A(qNewReg[5:0]), .B(omegaInner_18[5:0]), .P(omegaMultqNew_18[5:0]) );


   //------------------------------------------------------------------------
   // + lambdaMultqNew_0, ..., QA_19
   //- QA22 = qNewReg * lambdaInner
   //- Multipliers
   //------------------------------------------------------------------------
   RsDecodeMult   RsDecodeMult_PMUL0 (.A(qNewReg[5:0]), .B(lambdaInner_0[5:0]), .P(lambdaMultqNew_0[5:0]) );
   RsDecodeMult   RsDecodeMult_PMUL1 (.A(qNewReg[5:0]), .B(lambdaInner_1[5:0]), .P(lambdaMultqNew_1[5:0]) );
   RsDecodeMult   RsDecodeMult_PMUL2 (.A(qNewReg[5:0]), .B(lambdaInner_2[5:0]), .P(lambdaMultqNew_2[5:0]) );
   RsDecodeMult   RsDecodeMult_PMUL3 (.A(qNewReg[5:0]), .B(lambdaInner_3[5:0]), .P(lambdaMultqNew_3[5:0]) );
   RsDecodeMult   RsDecodeMult_PMUL4 (.A(qNewReg[5:0]), .B(lambdaInner_4[5:0]), .P(lambdaMultqNew_4[5:0]) );
   RsDecodeMult   RsDecodeMult_PMUL5 (.A(qNewReg[5:0]), .B(lambdaInner_5[5:0]), .P(lambdaMultqNew_5[5:0]) );
   RsDecodeMult   RsDecodeMult_PMUL6 (.A(qNewReg[5:0]), .B(lambdaInner_6[5:0]), .P(lambdaMultqNew_6[5:0]) );
   RsDecodeMult   RsDecodeMult_PMUL7 (.A(qNewReg[5:0]), .B(lambdaInner_7[5:0]), .P(lambdaMultqNew_7[5:0]) );
   RsDecodeMult   RsDecodeMult_PMUL8 (.A(qNewReg[5:0]), .B(lambdaInner_8[5:0]), .P(lambdaMultqNew_8[5:0]) );
   RsDecodeMult   RsDecodeMult_PMUL9 (.A(qNewReg[5:0]), .B(lambdaInner_9[5:0]), .P(lambdaMultqNew_9[5:0]) );
   RsDecodeMult   RsDecodeMult_PMUL10 (.A(qNewReg[5:0]), .B(lambdaInner_10[5:0]), .P(lambdaMultqNew_10[5:0]) );
   RsDecodeMult   RsDecodeMult_PMUL11 (.A(qNewReg[5:0]), .B(lambdaInner_11[5:0]), .P(lambdaMultqNew_11[5:0]) );
   RsDecodeMult   RsDecodeMult_PMUL12 (.A(qNewReg[5:0]), .B(lambdaInner_12[5:0]), .P(lambdaMultqNew_12[5:0]) );
   RsDecodeMult   RsDecodeMult_PMUL13 (.A(qNewReg[5:0]), .B(lambdaInner_13[5:0]), .P(lambdaMultqNew_13[5:0]) );
   RsDecodeMult   RsDecodeMult_PMUL14 (.A(qNewReg[5:0]), .B(lambdaInner_14[5:0]), .P(lambdaMultqNew_14[5:0]) );
   RsDecodeMult   RsDecodeMult_PMUL15 (.A(qNewReg[5:0]), .B(lambdaInner_15[5:0]), .P(lambdaMultqNew_15[5:0]) );
   RsDecodeMult   RsDecodeMult_PMUL16 (.A(qNewReg[5:0]), .B(lambdaInner_16[5:0]), .P(lambdaMultqNew_16[5:0]) );
   RsDecodeMult   RsDecodeMult_PMUL17 (.A(qNewReg[5:0]), .B(lambdaInner_17[5:0]), .P(lambdaMultqNew_17[5:0]) );
   RsDecodeMult   RsDecodeMult_PMUL18 (.A(qNewReg[5:0]), .B(lambdaInner_18[5:0]), .P(lambdaMultqNew_18[5:0]) );
   RsDecodeMult   RsDecodeMult_PMUL19 (.A(qNewReg[5:0]), .B(lambdaInner_19[5:0]), .P(lambdaMultqNew_19[5:0]) );


   //------------------------------------------------------------------------
   // + omegaBkp_0, ..., omegaBkp_19
   //- Registers
   //------------------------------------------------------------------------
      always @(posedge CLK or negedge RESET) begin
         if (~RESET) begin
            omegaBkp_0 [5:0]   <= 6'd0;
            omegaBkp_1 [5:0]   <= 6'd0;
            omegaBkp_2 [5:0]   <= 6'd0;
            omegaBkp_3 [5:0]   <= 6'd0;
            omegaBkp_4 [5:0]   <= 6'd0;
            omegaBkp_5 [5:0]   <= 6'd0;
            omegaBkp_6 [5:0]   <= 6'd0;
            omegaBkp_7 [5:0]   <= 6'd0;
            omegaBkp_8 [5:0]   <= 6'd0;
            omegaBkp_9 [5:0]   <= 6'd0;
            omegaBkp_10 [5:0]  <= 6'd0;
            omegaBkp_11 [5:0]  <= 6'd0;
            omegaBkp_12 [5:0]  <= 6'd0;
            omegaBkp_13 [5:0]  <= 6'd0;
            omegaBkp_14 [5:0]  <= 6'd0;
            omegaBkp_15 [5:0]  <= 6'd0;
            omegaBkp_16 [5:0]  <= 6'd0;
            omegaBkp_17 [5:0]  <= 6'd0;
            omegaBkp_18 [5:0]  <= 6'd0;
            omegaBkp_19 [5:0]  <= 6'd0;
         end
         else if (enable_E == 1'b1) begin
            if (sync == 1'b1) begin
                omegaBkp_0 [5:0]   <= 6'd0;
                omegaBkp_1 [5:0]   <= 6'd0;
                omegaBkp_2 [5:0]   <= 6'd0;
                omegaBkp_3 [5:0]   <= 6'd0;
                omegaBkp_4 [5:0]   <= 6'd0;
                omegaBkp_5 [5:0]   <= 6'd0;
                omegaBkp_6 [5:0]   <= 6'd0;
                omegaBkp_7 [5:0]   <= 6'd0;
                omegaBkp_8 [5:0]   <= 6'd0;
                omegaBkp_9 [5:0]   <= 6'd0;
                omegaBkp_10 [5:0]  <= 6'd0;
                omegaBkp_11 [5:0]  <= 6'd0;
                omegaBkp_12 [5:0]  <= 6'd0;
                omegaBkp_13 [5:0]  <= 6'd0;
                omegaBkp_14 [5:0]  <= 6'd0;
                omegaBkp_15 [5:0]  <= 6'd0;
                omegaBkp_16 [5:0]  <= 6'd0;
                omegaBkp_17 [5:0]  <= 6'd0;
                omegaBkp_18 [5:0]  <= 6'd0;
                omegaBkp_19[5:0]   <= 6'd1;
            end
            else if (phase[1:0] == 2'b00) begin
               if ((skip== 1'b0) && (offset == 5'd0)) begin
                  omegaBkp_0 [5:0]   <= omegaInner_0[5:0];
                  omegaBkp_1 [5:0]   <= omegaInner_1[5:0];
                  omegaBkp_2 [5:0]   <= omegaInner_2[5:0];
                  omegaBkp_3 [5:0]   <= omegaInner_3[5:0];
                  omegaBkp_4 [5:0]   <= omegaInner_4[5:0];
                  omegaBkp_5 [5:0]   <= omegaInner_5[5:0];
                  omegaBkp_6 [5:0]   <= omegaInner_6[5:0];
                  omegaBkp_7 [5:0]   <= omegaInner_7[5:0];
                  omegaBkp_8 [5:0]   <= omegaInner_8[5:0];
                  omegaBkp_9 [5:0]   <= omegaInner_9[5:0];
                  omegaBkp_10 [5:0]  <= omegaInner_10[5:0];
                  omegaBkp_11 [5:0]  <= omegaInner_11[5:0];
                  omegaBkp_12 [5:0]  <= omegaInner_12[5:0];
                  omegaBkp_13 [5:0]  <= omegaInner_13[5:0];
                  omegaBkp_14 [5:0]  <= omegaInner_14[5:0];
                  omegaBkp_15 [5:0]  <= omegaInner_15[5:0];
                  omegaBkp_16 [5:0]  <= omegaInner_16[5:0];
                  omegaBkp_17 [5:0]  <= omegaInner_17[5:0];
                  omegaBkp_18 [5:0]  <= omegaInner_18[5:0];
                  omegaBkp_19 [5:0]  <= omegaInner_19[5:0];
               end
               else if (skip== 1'b0) begin
                  omegaBkp_0 [5:0]   <= 6'd0;
                  omegaBkp_1 [5:0]   <= omegaMultqNew_0[5:0] ^ omegaBkp_0[5:0];
                  omegaBkp_2 [5:0]   <= omegaMultqNew_1[5:0] ^ omegaBkp_1[5:0];
                  omegaBkp_3 [5:0]   <= omegaMultqNew_2[5:0] ^ omegaBkp_2[5:0];
                  omegaBkp_4 [5:0]   <= omegaMultqNew_3[5:0] ^ omegaBkp_3[5:0];
                  omegaBkp_5 [5:0]   <= omegaMultqNew_4[5:0] ^ omegaBkp_4[5:0];
                  omegaBkp_6 [5:0]   <= omegaMultqNew_5[5:0] ^ omegaBkp_5[5:0];
                  omegaBkp_7 [5:0]   <= omegaMultqNew_6[5:0] ^ omegaBkp_6[5:0];
                  omegaBkp_8 [5:0]   <= omegaMultqNew_7[5:0] ^ omegaBkp_7[5:0];
                  omegaBkp_9 [5:0]   <= omegaMultqNew_8[5:0] ^ omegaBkp_8[5:0];
                  omegaBkp_10 [5:0]  <= omegaMultqNew_9[5:0] ^ omegaBkp_9[5:0];
                  omegaBkp_11 [5:0]  <= omegaMultqNew_10[5:0] ^ omegaBkp_10[5:0];
                  omegaBkp_12 [5:0]  <= omegaMultqNew_11[5:0] ^ omegaBkp_11[5:0];
                  omegaBkp_13 [5:0]  <= omegaMultqNew_12[5:0] ^ omegaBkp_12[5:0];
                  omegaBkp_14 [5:0]  <= omegaMultqNew_13[5:0] ^ omegaBkp_13[5:0];
                  omegaBkp_15 [5:0]  <= omegaMultqNew_14[5:0] ^ omegaBkp_14[5:0];
                  omegaBkp_16 [5:0]  <= omegaMultqNew_15[5:0] ^ omegaBkp_15[5:0];
                  omegaBkp_17 [5:0]  <= omegaMultqNew_16[5:0] ^ omegaBkp_16[5:0];
                  omegaBkp_18 [5:0]  <= omegaMultqNew_17[5:0] ^ omegaBkp_17[5:0];
                  omegaBkp_19 [5:0]  <= omegaMultqNew_18[5:0] ^ omegaBkp_18[5:0];
               end
            end
         end
      end


   //------------------------------------------------------------------
   // +omegaInner
   //------------------------------------------------------------------
   always @(posedge CLK or negedge RESET) begin
      if (~RESET) begin
         omegaInner_0 [5:0]  <= 6'd0;
         omegaInner_1 [5:0]  <= 6'd0;
         omegaInner_2 [5:0]  <= 6'd0;
         omegaInner_3 [5:0]  <= 6'd0;
         omegaInner_4 [5:0]  <= 6'd0;
         omegaInner_5 [5:0]  <= 6'd0;
         omegaInner_6 [5:0]  <= 6'd0;
         omegaInner_7 [5:0]  <= 6'd0;
         omegaInner_8 [5:0]  <= 6'd0;
         omegaInner_9 [5:0]  <= 6'd0;
         omegaInner_10 [5:0] <= 6'd0;
         omegaInner_11 [5:0] <= 6'd0;
         omegaInner_12 [5:0] <= 6'd0;
         omegaInner_13 [5:0] <= 6'd0;
         omegaInner_14 [5:0] <= 6'd0;
         omegaInner_15 [5:0] <= 6'd0;
         omegaInner_16 [5:0] <= 6'd0;
         omegaInner_17 [5:0] <= 6'd0;
         omegaInner_18 [5:0] <= 6'd0;
         omegaInner_19 [5:0] <= 6'd0;
      end
      else if (enable_E == 1'b1) begin
         if (sync == 1'b1) begin
            omegaInner_0 [5:0]  <= syndrome_0[5:0];
            omegaInner_1 [5:0]  <= syndrome_1[5:0];
            omegaInner_2 [5:0]  <= syndrome_2[5:0];
            omegaInner_3 [5:0]  <= syndrome_3[5:0];
            omegaInner_4 [5:0]  <= syndrome_4[5:0];
            omegaInner_5 [5:0]  <= syndrome_5[5:0];
            omegaInner_6 [5:0]  <= syndrome_6[5:0];
            omegaInner_7 [5:0]  <= syndrome_7[5:0];
            omegaInner_8 [5:0]  <= syndrome_8[5:0];
            omegaInner_9 [5:0]  <= syndrome_9[5:0];
            omegaInner_10 [5:0] <= syndrome_10[5:0];
            omegaInner_11 [5:0] <= syndrome_11[5:0];
            omegaInner_12 [5:0] <= syndrome_12[5:0];
            omegaInner_13 [5:0] <= syndrome_13[5:0];
            omegaInner_14 [5:0] <= syndrome_14[5:0];
            omegaInner_15 [5:0] <= syndrome_15[5:0];
            omegaInner_16 [5:0] <= syndrome_16[5:0];
            omegaInner_17 [5:0] <= syndrome_17[5:0];
            omegaInner_18 [5:0] <= syndrome_18[5:0];
            omegaInner_19 [5:0] <= syndrome_19[5:0];
         end
         else if (phase == 2'b00) begin
            if ((skip == 1'b0) && (offset == 5'd0)) begin
               omegaInner_0 [5:0]  <= 6'd0;
               omegaInner_1 [5:0]  <= omegaMultqNew_0 [5:0] ^ omegaBkp_0 [5:0];
               omegaInner_2 [5:0]  <= omegaMultqNew_1 [5:0] ^ omegaBkp_1 [5:0];
               omegaInner_3 [5:0]  <= omegaMultqNew_2 [5:0] ^ omegaBkp_2 [5:0];
               omegaInner_4 [5:0]  <= omegaMultqNew_3 [5:0] ^ omegaBkp_3 [5:0];
               omegaInner_5 [5:0]  <= omegaMultqNew_4 [5:0] ^ omegaBkp_4 [5:0];
               omegaInner_6 [5:0]  <= omegaMultqNew_5 [5:0] ^ omegaBkp_5 [5:0];
               omegaInner_7 [5:0]  <= omegaMultqNew_6 [5:0] ^ omegaBkp_6 [5:0];
               omegaInner_8 [5:0]  <= omegaMultqNew_7 [5:0] ^ omegaBkp_7 [5:0];
               omegaInner_9 [5:0]  <= omegaMultqNew_8 [5:0] ^ omegaBkp_8 [5:0];
               omegaInner_10 [5:0] <= omegaMultqNew_9 [5:0] ^ omegaBkp_9 [5:0];
               omegaInner_11 [5:0] <= omegaMultqNew_10 [5:0] ^ omegaBkp_10 [5:0];
               omegaInner_12 [5:0] <= omegaMultqNew_11 [5:0] ^ omegaBkp_11 [5:0];
               omegaInner_13 [5:0] <= omegaMultqNew_12 [5:0] ^ omegaBkp_12 [5:0];
               omegaInner_14 [5:0] <= omegaMultqNew_13 [5:0] ^ omegaBkp_13 [5:0];
               omegaInner_15 [5:0] <= omegaMultqNew_14 [5:0] ^ omegaBkp_14 [5:0];
               omegaInner_16 [5:0] <= omegaMultqNew_15 [5:0] ^ omegaBkp_15 [5:0];
               omegaInner_17 [5:0] <= omegaMultqNew_16 [5:0] ^ omegaBkp_16 [5:0];
               omegaInner_18 [5:0] <= omegaMultqNew_17 [5:0] ^ omegaBkp_17 [5:0];
               omegaInner_19 [5:0] <= omegaMultqNew_18 [5:0] ^ omegaBkp_18 [5:0];
            end
            else if (skip == 1'b1) begin
               omegaInner_0 [5:0]  <= 6'd0;
               omegaInner_1 [5:0]  <= omegaInner_0 [5:0];
               omegaInner_2 [5:0]  <= omegaInner_1 [5:0];
               omegaInner_3 [5:0]  <= omegaInner_2 [5:0];
               omegaInner_4 [5:0]  <= omegaInner_3 [5:0];
               omegaInner_5 [5:0]  <= omegaInner_4 [5:0];
               omegaInner_6 [5:0]  <= omegaInner_5 [5:0];
               omegaInner_7 [5:0]  <= omegaInner_6 [5:0];
               omegaInner_8 [5:0]  <= omegaInner_7 [5:0];
               omegaInner_9 [5:0]  <= omegaInner_8 [5:0];
               omegaInner_10 [5:0] <= omegaInner_9 [5:0];
               omegaInner_11 [5:0] <= omegaInner_10 [5:0];
               omegaInner_12 [5:0] <= omegaInner_11 [5:0];
               omegaInner_13 [5:0] <= omegaInner_12 [5:0];
               omegaInner_14 [5:0] <= omegaInner_13 [5:0];
               omegaInner_15 [5:0] <= omegaInner_14 [5:0];
               omegaInner_16 [5:0] <= omegaInner_15 [5:0];
               omegaInner_17 [5:0] <= omegaInner_16 [5:0];
               omegaInner_18 [5:0] <= omegaInner_17 [5:0];
               omegaInner_19 [5:0] <= omegaInner_18 [5:0];
            end
         end
      end
   end


   //------------------------------------------------------------------
   // + lambdaBkp_0,..,lambdaBkp_19
   //------------------------------------------------------------------
   always @(posedge CLK or negedge RESET) begin
      if (~RESET) begin
         lambdaBkp_0 [5:0]   <= 6'd0;
         lambdaBkp_1 [5:0]   <= 6'd0;
         lambdaBkp_2 [5:0]   <= 6'd0;
         lambdaBkp_3 [5:0]   <= 6'd0;
         lambdaBkp_4 [5:0]   <= 6'd0;
         lambdaBkp_5 [5:0]   <= 6'd0;
         lambdaBkp_6 [5:0]   <= 6'd0;
         lambdaBkp_7 [5:0]   <= 6'd0;
         lambdaBkp_8 [5:0]   <= 6'd0;
         lambdaBkp_9 [5:0]   <= 6'd0;
         lambdaBkp_10 [5:0]  <= 6'd0;
         lambdaBkp_11 [5:0]  <= 6'd0;
         lambdaBkp_12 [5:0]  <= 6'd0;
         lambdaBkp_13 [5:0]  <= 6'd0;
         lambdaBkp_14 [5:0]  <= 6'd0;
         lambdaBkp_15 [5:0]  <= 6'd0;
         lambdaBkp_16 [5:0]  <= 6'd0;
         lambdaBkp_17 [5:0]  <= 6'd0;
         lambdaBkp_18 [5:0]  <= 6'd0;
         lambdaBkp_19 [5:0]  <= 6'd0;
      end
      else if (enable_E == 1'b1) begin
         if (sync == 1'b1) begin
            lambdaBkp_0 [5:0]  <= 6'd0;
            lambdaBkp_1 [5:0]  <= 6'd0;
            lambdaBkp_2 [5:0]  <= 6'd0;
            lambdaBkp_3 [5:0]  <= 6'd0;
            lambdaBkp_4 [5:0]  <= 6'd0;
            lambdaBkp_5 [5:0]  <= 6'd0;
            lambdaBkp_6 [5:0]  <= 6'd0;
            lambdaBkp_7 [5:0]  <= 6'd0;
            lambdaBkp_8 [5:0]  <= 6'd0;
            lambdaBkp_9 [5:0]  <= 6'd0;
            lambdaBkp_10 [5:0] <= 6'd0;
            lambdaBkp_11 [5:0] <= 6'd0;
            lambdaBkp_12 [5:0] <= 6'd0;
            lambdaBkp_13 [5:0] <= 6'd0;
            lambdaBkp_14 [5:0] <= 6'd0;
            lambdaBkp_15 [5:0] <= 6'd0;
            lambdaBkp_16 [5:0] <= 6'd0;
            lambdaBkp_17 [5:0] <= 6'd0;
            lambdaBkp_18 [5:0] <= 6'd0;
            lambdaBkp_19 [5:0] <= 6'd0;
         end
         else if ((phase == 2'b00) && (skip == 1'b0) && (offset == 5'd0)) begin
            lambdaBkp_0 [5:0]  <= lambdaInner_0[5:0];
            lambdaBkp_1 [5:0]  <= lambdaInner_1[5:0];
            lambdaBkp_2 [5:0]  <= lambdaInner_2[5:0];
            lambdaBkp_3 [5:0]  <= lambdaInner_3[5:0];
            lambdaBkp_4 [5:0]  <= lambdaInner_4[5:0];
            lambdaBkp_5 [5:0]  <= lambdaInner_5[5:0];
            lambdaBkp_6 [5:0]  <= lambdaInner_6[5:0];
            lambdaBkp_7 [5:0]  <= lambdaInner_7[5:0];
            lambdaBkp_8 [5:0]  <= lambdaInner_8[5:0];
            lambdaBkp_9 [5:0]  <= lambdaInner_9[5:0];
            lambdaBkp_10 [5:0] <= lambdaInner_10[5:0];
            lambdaBkp_11 [5:0] <= lambdaInner_11[5:0];
            lambdaBkp_12 [5:0] <= lambdaInner_12[5:0];
            lambdaBkp_13 [5:0] <= lambdaInner_13[5:0];
            lambdaBkp_14 [5:0] <= lambdaInner_14[5:0];
            lambdaBkp_15 [5:0] <= lambdaInner_15[5:0];
            lambdaBkp_16 [5:0] <= lambdaInner_16[5:0];
            lambdaBkp_17 [5:0] <= lambdaInner_17[5:0];
            lambdaBkp_18 [5:0] <= lambdaInner_18[5:0];
            lambdaBkp_19 [5:0] <= lambdaInner_19[5:0];
         end
      end
   end


   //------------------------------------------------------------------
   // + lambdaInner_0, lambdaInner_19
   //------------------------------------------------------------------
   always @(posedge CLK or negedge RESET) begin
      if (~RESET) begin
         lambdaInner_0 [5:0]  <= 6'd0;
         lambdaInner_1 [5:0]  <= 6'd0;
         lambdaInner_2 [5:0]  <= 6'd0;
         lambdaInner_3 [5:0]  <= 6'd0;
         lambdaInner_4 [5:0]  <= 6'd0;
         lambdaInner_5 [5:0]  <= 6'd0;
         lambdaInner_6 [5:0]  <= 6'd0;
         lambdaInner_7 [5:0]  <= 6'd0;
         lambdaInner_8 [5:0]  <= 6'd0;
         lambdaInner_9 [5:0]  <= 6'd0;
         lambdaInner_10 [5:0] <= 6'd0;
         lambdaInner_11 [5:0] <= 6'd0;
         lambdaInner_12 [5:0] <= 6'd0;
         lambdaInner_13 [5:0] <= 6'd0;
         lambdaInner_14 [5:0] <= 6'd0;
         lambdaInner_15 [5:0] <= 6'd0;
         lambdaInner_16 [5:0] <= 6'd0;
         lambdaInner_17 [5:0] <= 6'd0;
         lambdaInner_18 [5:0] <= 6'd0;
         lambdaInner_19 [5:0] <= 6'd0;
      end
      else if (enable_E == 1'b1) begin
         if (sync == 1'b1) begin
            lambdaInner_0 [5:0]  <= 6'd1;
            lambdaInner_1 [5:0]  <= 6'd0;
            lambdaInner_2 [5:0]  <= 6'd0;
            lambdaInner_3 [5:0]  <= 6'd0;
            lambdaInner_4 [5:0]  <= 6'd0;
            lambdaInner_5 [5:0]  <= 6'd0;
            lambdaInner_6 [5:0]  <= 6'd0;
            lambdaInner_7 [5:0]  <= 6'd0;
            lambdaInner_8 [5:0]  <= 6'd0;
            lambdaInner_9 [5:0]  <= 6'd0;
            lambdaInner_10 [5:0] <= 6'd0;
            lambdaInner_11 [5:0] <= 6'd0;
            lambdaInner_12 [5:0] <= 6'd0;
            lambdaInner_13 [5:0] <= 6'd0;
            lambdaInner_14 [5:0] <= 6'd0;
            lambdaInner_15 [5:0] <= 6'd0;
            lambdaInner_16 [5:0] <= 6'd0;
            lambdaInner_17 [5:0] <= 6'd0;
            lambdaInner_18 [5:0] <= 6'd0;
            lambdaInner_19 [5:0] <= 6'd0;
         end
         else if ((phase[1:0] == 2'b00) && (skip == 1'b0) && (offset== 5'd0)) begin
            lambdaInner_0 [5:0]  <= lambdaBkp_0 [5:0] ^ lambdaMultqNew_0 [5:0];
            lambdaInner_1 [5:0]  <= lambdaBkp_1 [5:0] ^ lambdaMultqNew_1 [5:0] ^ lambdaXorReg_0 [5:0];
            lambdaInner_2 [5:0]  <= lambdaBkp_2 [5:0] ^ lambdaMultqNew_2 [5:0] ^ lambdaXorReg_1 [5:0];
            lambdaInner_3 [5:0]  <= lambdaBkp_3 [5:0] ^ lambdaMultqNew_3 [5:0] ^ lambdaXorReg_2 [5:0];
            lambdaInner_4 [5:0]  <= lambdaBkp_4 [5:0] ^ lambdaMultqNew_4 [5:0] ^ lambdaXorReg_3 [5:0];
            lambdaInner_5 [5:0]  <= lambdaBkp_5 [5:0] ^ lambdaMultqNew_5 [5:0] ^ lambdaXorReg_4 [5:0];
            lambdaInner_6 [5:0]  <= lambdaBkp_6 [5:0] ^ lambdaMultqNew_6 [5:0] ^ lambdaXorReg_5 [5:0];
            lambdaInner_7 [5:0]  <= lambdaBkp_7 [5:0] ^ lambdaMultqNew_7 [5:0] ^ lambdaXorReg_6 [5:0];
            lambdaInner_8 [5:0]  <= lambdaBkp_8 [5:0] ^ lambdaMultqNew_8 [5:0] ^ lambdaXorReg_7 [5:0];
            lambdaInner_9 [5:0]  <= lambdaBkp_9 [5:0] ^ lambdaMultqNew_9 [5:0] ^ lambdaXorReg_8 [5:0];
            lambdaInner_10 [5:0] <= lambdaBkp_10 [5:0] ^ lambdaMultqNew_10 [5:0] ^ lambdaXorReg_9 [5:0];
            lambdaInner_11 [5:0] <= lambdaBkp_11 [5:0] ^ lambdaMultqNew_11 [5:0] ^ lambdaXorReg_10 [5:0];
            lambdaInner_12 [5:0] <= lambdaBkp_12 [5:0] ^ lambdaMultqNew_12 [5:0] ^ lambdaXorReg_11 [5:0];
            lambdaInner_13 [5:0] <= lambdaBkp_13 [5:0] ^ lambdaMultqNew_13 [5:0] ^ lambdaXorReg_12 [5:0];
            lambdaInner_14 [5:0] <= lambdaBkp_14 [5:0] ^ lambdaMultqNew_14 [5:0] ^ lambdaXorReg_13 [5:0];
            lambdaInner_15 [5:0] <= lambdaBkp_15 [5:0] ^ lambdaMultqNew_15 [5:0] ^ lambdaXorReg_14 [5:0];
            lambdaInner_16 [5:0] <= lambdaBkp_16 [5:0] ^ lambdaMultqNew_16 [5:0] ^ lambdaXorReg_15 [5:0];
            lambdaInner_17 [5:0] <= lambdaBkp_17 [5:0] ^ lambdaMultqNew_17 [5:0] ^ lambdaXorReg_16 [5:0];
            lambdaInner_18 [5:0] <= lambdaBkp_18 [5:0] ^ lambdaMultqNew_18 [5:0] ^ lambdaXorReg_17 [5:0];
            lambdaInner_19 [5:0] <= lambdaBkp_19 [5:0] ^ lambdaMultqNew_19 [5:0] ^ lambdaXorReg_18 [5:0];
         end
      end
   end


   //------------------------------------------------------------------
   // + lambdaXorReg_0,..., lambdaXorReg_20
   //------------------------------------------------------------------
   always @(posedge CLK or negedge RESET) begin
      if (~RESET) begin
         lambdaXorReg_0 [5:0]  <= 6'd0;
         lambdaXorReg_1 [5:0]  <= 6'd0;
         lambdaXorReg_2 [5:0]  <= 6'd0;
         lambdaXorReg_3 [5:0]  <= 6'd0;
         lambdaXorReg_4 [5:0]  <= 6'd0;
         lambdaXorReg_5 [5:0]  <= 6'd0;
         lambdaXorReg_6 [5:0]  <= 6'd0;
         lambdaXorReg_7 [5:0]  <= 6'd0;
         lambdaXorReg_8 [5:0]  <= 6'd0;
         lambdaXorReg_9 [5:0]  <= 6'd0;
         lambdaXorReg_10 [5:0] <= 6'd0;
         lambdaXorReg_11 [5:0] <= 6'd0;
         lambdaXorReg_12 [5:0] <= 6'd0;
         lambdaXorReg_13 [5:0] <= 6'd0;
         lambdaXorReg_14 [5:0] <= 6'd0;
         lambdaXorReg_15 [5:0] <= 6'd0;
         lambdaXorReg_16 [5:0] <= 6'd0;
         lambdaXorReg_17 [5:0] <= 6'd0;
         lambdaXorReg_18 [5:0] <= 6'd0;
      end
      else if (enable_E == 1'b1) begin
         if (sync == 1'b1) begin
            lambdaXorReg_0 [5:0]  <= 6'd0;
            lambdaXorReg_1 [5:0]  <= 6'd0;
            lambdaXorReg_2 [5:0]  <= 6'd0;
            lambdaXorReg_3 [5:0]  <= 6'd0;
            lambdaXorReg_4 [5:0]  <= 6'd0;
            lambdaXorReg_5 [5:0]  <= 6'd0;
            lambdaXorReg_6 [5:0]  <= 6'd0;
            lambdaXorReg_7 [5:0]  <= 6'd0;
            lambdaXorReg_8 [5:0]  <= 6'd0;
            lambdaXorReg_9 [5:0]  <= 6'd0;
            lambdaXorReg_10 [5:0] <= 6'd0;
            lambdaXorReg_11 [5:0] <= 6'd0;
            lambdaXorReg_12 [5:0] <= 6'd0;
            lambdaXorReg_13 [5:0] <= 6'd0;
            lambdaXorReg_14 [5:0] <= 6'd0;
            lambdaXorReg_15 [5:0] <= 6'd0;
            lambdaXorReg_16 [5:0] <= 6'd0;
            lambdaXorReg_17 [5:0] <= 6'd0;
            lambdaXorReg_18 [5:0] <= 6'd0;
         end
         else if (phase == 2'b00) begin
            if ((skip == 1'b0) && (offset == 5'd0)) begin
               lambdaXorReg_0 [5:0]  <= 6'd0;
               lambdaXorReg_1 [5:0]  <= 6'd0;
               lambdaXorReg_2 [5:0]  <= 6'd0;
               lambdaXorReg_3 [5:0]  <= 6'd0;
               lambdaXorReg_4 [5:0]  <= 6'd0;
               lambdaXorReg_5 [5:0]  <= 6'd0;
               lambdaXorReg_6 [5:0]  <= 6'd0;
               lambdaXorReg_7 [5:0]  <= 6'd0;
               lambdaXorReg_8 [5:0]  <= 6'd0;
               lambdaXorReg_9 [5:0]  <= 6'd0;
               lambdaXorReg_10 [5:0] <= 6'd0;
               lambdaXorReg_11 [5:0] <= 6'd0;
               lambdaXorReg_12 [5:0] <= 6'd0;
               lambdaXorReg_13 [5:0] <= 6'd0;
               lambdaXorReg_14 [5:0] <= 6'd0;
               lambdaXorReg_15 [5:0] <= 6'd0;
               lambdaXorReg_16 [5:0] <= 6'd0;
               lambdaXorReg_17 [5:0] <= 6'd0;
               lambdaXorReg_18 [5:0] <= 6'd0;
            end
            else if (skip == 1'b0) begin
               lambdaXorReg_0 [5:0]  <= lambdaMultqNew_0 [5:0];
               lambdaXorReg_1 [5:0]  <= lambdaMultqNew_1 [5:0] ^ lambdaXorReg_0[5:0];
               lambdaXorReg_2 [5:0]  <= lambdaMultqNew_2 [5:0] ^ lambdaXorReg_1[5:0];
               lambdaXorReg_3 [5:0]  <= lambdaMultqNew_3 [5:0] ^ lambdaXorReg_2[5:0];
               lambdaXorReg_4 [5:0]  <= lambdaMultqNew_4 [5:0] ^ lambdaXorReg_3[5:0];
               lambdaXorReg_5 [5:0]  <= lambdaMultqNew_5 [5:0] ^ lambdaXorReg_4[5:0];
               lambdaXorReg_6 [5:0]  <= lambdaMultqNew_6 [5:0] ^ lambdaXorReg_5[5:0];
               lambdaXorReg_7 [5:0]  <= lambdaMultqNew_7 [5:0] ^ lambdaXorReg_6[5:0];
               lambdaXorReg_8 [5:0]  <= lambdaMultqNew_8 [5:0] ^ lambdaXorReg_7[5:0];
               lambdaXorReg_9 [5:0]  <= lambdaMultqNew_9 [5:0] ^ lambdaXorReg_8[5:0];
               lambdaXorReg_10 [5:0] <= lambdaMultqNew_10 [5:0] ^ lambdaXorReg_9[5:0];
               lambdaXorReg_11 [5:0] <= lambdaMultqNew_11 [5:0] ^ lambdaXorReg_10[5:0];
               lambdaXorReg_12 [5:0] <= lambdaMultqNew_12 [5:0] ^ lambdaXorReg_11[5:0];
               lambdaXorReg_13 [5:0] <= lambdaMultqNew_13 [5:0] ^ lambdaXorReg_12[5:0];
               lambdaXorReg_14 [5:0] <= lambdaMultqNew_14 [5:0] ^ lambdaXorReg_13[5:0];
               lambdaXorReg_15 [5:0] <= lambdaMultqNew_15 [5:0] ^ lambdaXorReg_14[5:0];
               lambdaXorReg_16 [5:0] <= lambdaMultqNew_16 [5:0] ^ lambdaXorReg_15[5:0];
               lambdaXorReg_17 [5:0] <= lambdaMultqNew_17 [5:0] ^ lambdaXorReg_16[5:0];
               lambdaXorReg_18 [5:0] <= lambdaMultqNew_18 [5:0] ^ lambdaXorReg_17[5:0];
            end
         end
      end
   end


   //------------------------------------------------------------------
   // + offset
   //------------------------------------------------------------------
   always @(posedge CLK or negedge RESET) begin
      if (~RESET) begin
         offset [4:0] <= 5'd0;
      end
      else if (enable_E == 1'b1) begin
         if (sync == 1'b1) begin
            offset [4:0] <= 5'd1;
         end
         else if (phase [1:0] == 2'b00) begin
            if ((skip == 1'b0) && (offset[4:0]==5'd0)) begin
               offset [4:0] <= 5'd1;
            end
            else if (skip == 1'b1) begin
               offset [4:0] <= offset [4:0] + 5'd1;
            end
            else begin
               offset [4:0] <= offset [4:0] - 5'd1;
            end
         end
      end
   end


   //------------------------------------------------------------------
   // + numShiftedReg
   //------------------------------------------------------------------
   always @(posedge CLK or negedge RESET) begin
      if (~RESET) begin
         numShiftedReg   [4:0] <= 5'd0;
      end
      else if (enable_E == 1'b1) begin
         if (sync == 1'b1) begin
            numShiftedReg   <= 5'd0;
         end
         else if (phase == 2'd0) begin
            if ((skip == 1'b0) && (offset == 5'd0)) begin
               numShiftedReg   <= numShiftedReg + 5'd1;
            end
            else if (skip == 1'b1) begin
               numShiftedReg   <= numShiftedReg + 5'd1;
            end
         end
      end
   end


   //------------------------------------------------------------------------
   //- OutputPorts
   //------------------------------------------------------------------------
   assign lambda_0 [5:0]  = lambdaInner_0 [5:0];
   assign lambda_1 [5:0]  = lambdaInner_1 [5:0];
   assign lambda_2 [5:0]  = lambdaInner_2 [5:0];
   assign lambda_3 [5:0]  = lambdaInner_3 [5:0];
   assign lambda_4 [5:0]  = lambdaInner_4 [5:0];
   assign lambda_5 [5:0]  = lambdaInner_5 [5:0];
   assign lambda_6 [5:0]  = lambdaInner_6 [5:0];
   assign lambda_7 [5:0]  = lambdaInner_7 [5:0];
   assign lambda_8 [5:0]  = lambdaInner_8 [5:0];
   assign lambda_9 [5:0]  = lambdaInner_9 [5:0];
   assign lambda_10 [5:0] = lambdaInner_10 [5:0];
   assign lambda_11 [5:0] = lambdaInner_11 [5:0];
   assign lambda_12 [5:0] = lambdaInner_12 [5:0];
   assign lambda_13 [5:0] = lambdaInner_13 [5:0];
   assign lambda_14 [5:0] = lambdaInner_14 [5:0];
   assign lambda_15 [5:0] = lambdaInner_15 [5:0];
   assign lambda_16 [5:0] = lambdaInner_16 [5:0];
   assign lambda_17 [5:0] = lambdaInner_17 [5:0];
   assign lambda_18 [5:0] = lambdaInner_18 [5:0];
   assign lambda_19 [5:0] = lambdaInner_19 [5:0];

   assign omega_0 [5:0]  = omegaInner_0 [5:0];
   assign omega_1 [5:0]  = omegaInner_1 [5:0];
   assign omega_2 [5:0]  = omegaInner_2 [5:0];
   assign omega_3 [5:0]  = omegaInner_3 [5:0];
   assign omega_4 [5:0]  = omegaInner_4 [5:0];
   assign omega_5 [5:0]  = omegaInner_5 [5:0];
   assign omega_6 [5:0]  = omegaInner_6 [5:0];
   assign omega_7 [5:0]  = omegaInner_7 [5:0];
   assign omega_8 [5:0]  = omegaInner_8 [5:0];
   assign omega_9 [5:0]  = omegaInner_9 [5:0];
   assign omega_10 [5:0] = omegaInner_10 [5:0];
   assign omega_11 [5:0] = omegaInner_11 [5:0];
   assign omega_12 [5:0] = omegaInner_12 [5:0];
   assign omega_13 [5:0] = omegaInner_13 [5:0];
   assign omega_14 [5:0] = omegaInner_14 [5:0];
   assign omega_15 [5:0] = omegaInner_15 [5:0];
   assign omega_16 [5:0] = omegaInner_16 [5:0];
   assign omega_17 [5:0] = omegaInner_17 [5:0];
   assign omega_18 [5:0] = omegaInner_18 [5:0];
   assign omega_19 [5:0] = omegaInner_19 [5:0];
   assign numShifted     = numShiftedReg;


endmodule
