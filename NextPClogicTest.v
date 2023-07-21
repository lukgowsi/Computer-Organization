`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:13:28 03/03/2009
// Design Name:   RegisterFile
// Module Name:   E:/350/Lab7/RegisterFile/RegisterFileTest.v
// Project Name:  RegisterFile
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RegisterFile
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

`define STRLEN 32
module NextPClogicTest_v;


   task passTest;
      input [63:0] actualOut, expectedOut;
      input [`STRLEN*8:0] testType;
      inout [7:0] 	  passed;
      
      if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
      else $display ("%s failed: %d should be %d", testType, actualOut, expectedOut);
   endtask
   
   task allPassed;
      input [7:0] passed;
      input [7:0] numTests;
      
      if(passed == numTests) $display ("All tests passed");
      else $display("Some tests failed");
   endtask
//Branch, ALUZero, Uncondbranch; 
   // Inputs
   reg [63:0] CurrentPC;
   reg [63:0] SignExtImm64;
   reg Branch;
   reg ALUZero;
   reg Uncondbranch;
   reg [7:0] passed;
   reg [7:0] numTests;
   reg [63:0] address;
   // Outputs
   wire [63:0] NextPC;


   // Instantiate the Unit Under Test (UUT)
   NextPClogic uut (
		     .CurrentPC(CurrentPC), 
		     .SignExtImm64(SignExtImm64), 
		     .Branch(Branch), 
		     .ALUZero(ALUZero), 
		     .Uncondbranch(Uncondbranch), 
                 .NextPC(NextPC)
		     );
	//Create the wave file
      initial begin
	$dumpfile("NextPClogic.vcd");
	$dumpvars(0,NextPClogicTest_v);
	end
      
   initial begin
      // Initialize Inputs
      CurrentPC = 64'b0;
      SignExtImm64 = 64'b0;
      Branch = 1'b0;
      ALUZero = 1'b0;
      Uncondbranch = 1'b0;
      
      passed = 7'b0;
      numTests = 7'b0;
      #9;
      
      // Begin Tests
      //////////////////////////////////////
      //Address Test - PC + 4
      CurrentPC = 64'b101010;
      SignExtImm64 = 64'b0;
      Branch = 1'b0;
      ALUZero = 1'b0;
      Uncondbranch = 1'b0;
      address = 64'b101110;
      #10;
      passTest(NextPC, address, "PC + 4 ", passed);
      numTests = numTests +1;

      //Address Test - PC + SignExtImm64
      CurrentPC = 64'b11110001;
      SignExtImm64 = 64'b1;
      Branch = 1'b0;
      ALUZero = 1'b0;
      Uncondbranch = 1'b0;
      address = 64'b11110101;
      #10;
      passTest(NextPC, address, "PC + signExtended", passed);
      numTests = numTests +1;

      //Conditional Test - taken
      CurrentPC = 64'b10001110101010;
      SignExtImm64 = 64'b10;
      Branch = 1'b1;
      ALUZero = 1'b1;
      Uncondbranch = 1'b0;
      address = 64'b10001110101100;
      #10;
      passTest(NextPC, address, "Taken branch ", passed);
      numTests = numTests +1;

      //Conditional Test - not taken
      CurrentPC = 64'b1001011100101000;
      SignExtImm64 = 64'b11;
      Branch = 1'b1;
      ALUZero = 1'b0;
      Uncondbranch = 1'b0;
      address = 64'b1001011100101100;
      #10;
      passTest(NextPC, address, "Not taken branch ", passed);
      numTests = numTests +1;

      //Unconditional Test
      CurrentPC = 64'b101110;
      SignExtImm64 = 64'b100;
      Branch = 1'b0;
      ALUZero = 1'b0;
      Uncondbranch = 1'b1;
      address = 64'b110010;
      #10;
      passTest(NextPC, address, "Unconditional branch ", passed);
      numTests = numTests +1;

      allPassed(passed, 5);
   end
   
endmodule
