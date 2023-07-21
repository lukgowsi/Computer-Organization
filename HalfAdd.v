`timescale 1ns / 1ps
module HalfAdd ( Cout , Sum , A, B ) ;
  input A, B ;
  output Cout , Sum ;
  wire a_1, x, y; //Create temp wires for future use
  nand nand1(a_1,A,B); //nand A and B and store in a_1
  nand nand2(x,A,a_1);//nand A and a_1 and store in x
  nand nand3(y,a_1,B);//nand a_1 and B and store in y
  nand nand4(Sum,x,y);//nand x and y and store in Sum
  nand nand5(Cout,a_1,a_1);//nand a_1 and a_1 so they cancel to a simple and, and store in Cout
endmodule
