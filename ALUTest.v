`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:02:47 03/05/2009
// Design Name:   ALU
// Module Name:   E:/350/Lab8/ALU/ALUTest.v
// Project Name:  ALU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

`define STRLEN 32
module ALUTest_v;

	task passTest;
		input [64:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;
		inout [7:0] passed;
	
		if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%s failed: %x should be %x", testType, actualOut, expectedOut);
	endtask
	
	task allPassed;
		input [7:0] passed;
		input [7:0] numTests;
		
		if(passed == numTests) $display ("All tests passed");
		else $display("Some tests failed");
	endtask

	// Inputs
	reg [63:0] BusA;
	reg [63:0] BusB;
	reg [3:0] ALUCtrl;
	reg [7:0] passed;

	// Outputs
	wire [63:0] BusW;
	wire Zero;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.BusW(BusW), 
		.Zero(Zero), 
		.BusA(BusA), 
		.BusB(BusB), 
		.ALUCtrl(ALUCtrl)
	);
	initial begin
	$dumpfile("ALU.vcd");
	$dumpvars(0,ALUTest_v);
	end
	
	initial begin
		// Initialize Inputs
		BusA = 0;
		BusB = 0;
		ALUCtrl = 0;
		passed = 0;

                // Here is one example test vector, testing the ADD instruction:
		//#40; {BusA, BusB, ALUCtrl} = {64'h1234, 64'hABCD0000, 4'h2};
		//#10; passTest({Zero, BusW}, 65'h0ABCD1234, "ADD 0x1234,0xABCD0000", passed);
		//Reformate and add your test vectors from the prelab here following the example of the testvector above.	
		
		//Test AND

		#40; {BusA, BusB, ALUCtrl} = {64'h0000FFFF, 64'h0000FFFF, 4'h0};
		#10; passTest({Zero, BusW}, 65'h0000FFFF, "Example test vectors for AND", passed);
		
		#40; {BusA, BusB, ALUCtrl} = {64'h0000, 64'h0000, 4'h0};
		#10; passTest({Zero, BusW}, 65'h10000000000000000, "Example test vectors for AND", passed);

		#40; {BusA, BusB, ALUCtrl} = {64'hAB01, 64'hDF53, 4'h0};
		#10; passTest({Zero, BusW}, 65'h8B01, "Example test vectors for AND", passed);
		
		//Test OR
		
		#40; {BusA, BusB, ALUCtrl} = {64'h0000, 64'h0000, 4'h1};
		#10; passTest({Zero, BusW}, 65'h10000000000000000, "Example test vectors for OR", passed);
		
		#40; {BusA, BusB, ALUCtrl} = {64'h000047E8, 64'h0000027C, 4'h1};
		#10; passTest({Zero, BusW}, 65'h000047FC, "Example test vectors for OR", passed);
		
		#40; {BusA, BusB, ALUCtrl} = {64'hAB01, 64'hDF53, 4'h1};
		#10; passTest({Zero, BusW}, 65'hFF53, "Example test vectors for OR", passed);
		
		//Test ADD
		
		#40; {BusA, BusB, ALUCtrl} = {64'h0, 64'h0, 4'h2};
		#10; passTest({Zero, BusW}, 65'h10000000000000000, "Example test vectors for ADD", passed);
		
		#40; {BusA, BusB, ALUCtrl} = {64'hCCBA, 64'h0138, 4'h2};
		#10; passTest({Zero, BusW}, 65'hCDF2, "Example test vectors for ADD", passed);
		
		#40; {BusA, BusB, ALUCtrl} = {64'h0000DAF1, 64'h00000E0A, 4'h2};
		#10; passTest({Zero, BusW}, 65'h0000E8FB, "Example test vectors for ADD", passed);

		//Test SUB
		
		#40; {BusA, BusB, ALUCtrl} = {64'h0000, 64'h0000, 4'h6};
		#10; passTest({Zero, BusW}, 65'h10000000000000000, "Example test vectors for SUB", passed);
		
		#40; {BusA, BusB, ALUCtrl} = {64'h0CF7, 64'h1972, 4'h6};
		#10; passTest({Zero, BusW}, 65'h0FFFFFFFFFFFFF385, "Example test vectors for SUB", passed);
		
		#40; {BusA, BusB, ALUCtrl} = {64'h00001F3F, 64'h0000D5E9, 4'h6};
		#10; passTest({Zero, BusW}, 65'h0FFFFFFFFFFFF4956, "Example test vectors for SUB", passed);
		
		//Test PassB
		
		#40; {BusA, BusB, ALUCtrl} = {64'h0000, 64'h0000, 4'h7};
		#10; passTest({Zero, BusW}, 65'h10000000000000000, "Example test vectors for PassB", passed);
		
		#40; {BusA, BusB, ALUCtrl} = {64'hACF1, 64'h8770, 4'h7};
		#10; passTest({Zero, BusW}, 65'h8770, "Example test vectors for PassB", passed);
		
		#40; {BusA, BusB, ALUCtrl} = {64'h00006381, 64'h0000A8E8, 4'h7};
		#10; passTest({Zero, BusW}, 65'h0000A8E8, "Example test vectors for PassB", passed);

		allPassed(passed, 15);
	end
      
endmodule

