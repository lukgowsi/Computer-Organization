`timescale 1ns / 1ps
module Decode24 ( out , in ) ;
  input [ 1 : 0 ] in ;
  output [ 3 : 0 ] out ;

  assign out[0] = ~in[0] & ~in[1];// the value of out[0] corresponds to 0 and 0
  assign out[1] = in[0] & ~in[1];// the value of out[1] corresponds to 1 and 0
  assign out[2] = ~in[0] & in[1];// the value of out[2] corresponds to 0 and 1
  assign out[3] = in[0] & in[1]; // the value of out[3] corresponds to 1 and 1

endmodule
// Behavioral programming is in parallel and makes use of the assign statement
