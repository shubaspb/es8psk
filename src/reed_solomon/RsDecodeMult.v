//===================================================================
// Module Name : RsDecodeMult
// File Name   : RsDecodeMult.v
// Function    : Rs Decoder Multiplier Module
// 
// Revision History:
// Date          By           Version    Change Description
//===================================================================
// 2009/02/03  Gael Sapience     1.0       Original
//
//===================================================================
// (C) COPYRIGHT 2009 SYSTEM LSI CO., Ltd.
//


module RsDecodeMult(
   A, // input A
   B, // input B
   P  // output P = A*B in Galois Field
);


   input  [5:0]   A; // input A
   input  [5:0]   B; // input B
   output [5:0]   P; // output P = A*B in Galois Field



   //------------------------------------------------------------------------
   // + M
   //- 
   //------------------------------------------------------------------------
   wire [10:0]   M;



   assign M[0]  = (A[0] & B[0]);
   assign M[1]  = (A[0] & B[1]) ^ (A[1] & B[0]);
   assign M[2]  = (A[0] & B[2]) ^ (A[1] & B[1]) ^ (A[2] & B[0]);
   assign M[3]  = (A[0] & B[3]) ^ (A[1] & B[2]) ^ (A[2] & B[1]) ^ (A[3] & B[0]);
   assign M[4]  = (A[0] & B[4]) ^ (A[1] & B[3]) ^ (A[2] & B[2]) ^ (A[3] & B[1]) ^ (A[4] & B[0]);
   assign M[5]  = (A[0] & B[5]) ^ (A[1] & B[4]) ^ (A[2] & B[3]) ^ (A[3] & B[2]) ^ (A[4] & B[1]) ^ (A[5] & B[0]);
   assign M[6]  = (A[1] & B[5]) ^ (A[2] & B[4]) ^ (A[3] & B[3]) ^ (A[4] & B[2]) ^ (A[5] & B[1]);
   assign M[7]  = (A[2] & B[5]) ^ (A[3] & B[4]) ^ (A[4] & B[3]) ^ (A[5] & B[2]);
   assign M[8]  = (A[3] & B[5]) ^ (A[4] & B[4]) ^ (A[5] & B[3]);
   assign M[9]  = (A[4] & B[5]) ^ (A[5] & B[4]);
   assign M[10] = (A[5] & B[5]);
   //------------------------------------------------------------------------
   // + P
   //- 
   //------------------------------------------------------------------------
   assign P[0] =  M[0] ^ M[6] ^ M[7] ^ M[9] ^ M[10] ;
   assign P[1] =  M[1] ^ M[6] ^ M[8] ^ M[9] ;
   assign P[2] =  M[2] ^ M[7] ^ M[9] ^ M[10] ;
   assign P[3] =  M[3] ^ M[8] ^ M[10] ;
   assign P[4] =  M[4] ^ M[6] ^ M[7] ^ M[10] ;
   assign P[5] =  M[5] ^ M[6] ^ M[8] ^ M[9] ^ M[10] ;


endmodule
