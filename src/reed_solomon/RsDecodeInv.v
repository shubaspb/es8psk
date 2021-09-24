//===================================================================
// Module Name : RsDecodeInv
// File Name   : RsDecodeInv.v
// Function    : Rs Decoder Inverse calculation Module
// 
// Revision History:
// Date          By           Version    Change Description
//===================================================================
// 2009/02/03  Gael Sapience     1.0       Original
//
//===================================================================
// (C) COPYRIGHT 2009 SYSTEM LSI CO., Ltd.
//


module RsDecodeInv(
   B,   // data in
   R    // data out
 );


   input  [5:0]   B; // data in
   output [5:0]   R; // data out


   reg [5:0]   R;


   always @(B) begin
      case (B)
         6'd0: begin
            R = 6'd0;
         end
         6'd1: begin
            R = 6'd1;
         end
         6'd2: begin
            R = 6'd57;
         end
         6'd3: begin
            R = 6'd46;
         end
         6'd4: begin
            R = 6'd37;
         end
         6'd5: begin
            R = 6'd26;
         end
         6'd6: begin
            R = 6'd23;
         end
         6'd7: begin
            R = 6'd33;
         end
         6'd8: begin
            R = 6'd43;
         end
         6'd9: begin
            R = 6'd31;
         end
         6'd10: begin
            R = 6'd13;
         end
         6'd11: begin
            R = 6'd51;
         end
         6'd12: begin
            R = 6'd50;
         end
         6'd13: begin
            R = 6'd10;
         end
         6'd14: begin
            R = 6'd41;
         end
         6'd15: begin
            R = 6'd39;
         end
         6'd16: begin
            R = 6'd44;
         end
         6'd17: begin
            R = 6'd29;
         end
         6'd18: begin
            R = 6'd54;
         end
         6'd19: begin
            R = 6'd35;
         end
         6'd20: begin
            R = 6'd63;
         end
         6'd21: begin
            R = 6'd60;
         end
         6'd22: begin
            R = 6'd32;
         end
         6'd23: begin
            R = 6'd6;
         end
         6'd24: begin
            R = 6'd25;
         end
         6'd25: begin
            R = 6'd24;
         end
         6'd26: begin
            R = 6'd5;
         end
         6'd27: begin
            R = 6'd36;
         end
         6'd28: begin
            R = 6'd45;
         end
         6'd29: begin
            R = 6'd17;
         end
         6'd30: begin
            R = 6'd42;
         end
         6'd31: begin
            R = 6'd9;
         end
         6'd32: begin
            R = 6'd22;
         end
         6'd33: begin
            R = 6'd7;
         end
         6'd34: begin
            R = 6'd55;
         end
         6'd35: begin
            R = 6'd19;
         end
         6'd36: begin
            R = 6'd27;
         end
         6'd37: begin
            R = 6'd4;
         end
         6'd38: begin
            R = 6'd40;
         end
         6'd39: begin
            R = 6'd15;
         end
         6'd40: begin
            R = 6'd38;
         end
         6'd41: begin
            R = 6'd14;
         end
         6'd42: begin
            R = 6'd30;
         end
         6'd43: begin
            R = 6'd8;
         end
         6'd44: begin
            R = 6'd16;
         end
         6'd45: begin
            R = 6'd28;
         end
         6'd46: begin
            R = 6'd3;
         end
         6'd47: begin
            R = 6'd56;
         end
         6'd48: begin
            R = 6'd53;
         end
         6'd49: begin
            R = 6'd58;
         end
         6'd50: begin
            R = 6'd12;
         end
         6'd51: begin
            R = 6'd11;
         end
         6'd52: begin
            R = 6'd59;
         end
         6'd53: begin
            R = 6'd48;
         end
         6'd54: begin
            R = 6'd18;
         end
         6'd55: begin
            R = 6'd34;
         end
         6'd56: begin
            R = 6'd47;
         end
         6'd57: begin
            R = 6'd2;
         end
         6'd58: begin
            R = 6'd49;
         end
         6'd59: begin
            R = 6'd52;
         end
         6'd60: begin
            R = 6'd21;
         end
         6'd61: begin
            R = 6'd62;
         end
         6'd62: begin
            R = 6'd61;
         end
         default: begin
            R = 6'd20;
         end
      endcase
   end
endmodule
