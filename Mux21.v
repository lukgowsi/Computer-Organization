`timescale 1ns / 1ps
module Mux21 ( out , in , sel ) ;
  input [ 1 : 0 ] in ;
  input sel ;
  output out ;
  wire and_1, and_2, not_sel; //Create temp wires for future use
  not not1(not_sel, sel); //inverse sel
  and and1(and_1, in[0], not_sel); // I0 & sel'
  and and2(and_2, in[1], sel); // I1 & sel
  or or1(out, and_1, and_2); //and1+and2

endmodule
