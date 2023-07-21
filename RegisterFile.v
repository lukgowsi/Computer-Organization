module RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, Clk);
    output [63:0] BusA;
    output [63:0] BusB;
    input [63:0] BusW;
    input [4:0] RA;     // Add input port for RA with 5 bits
    input [4:0] RB;     // Add input port for RB with 5 bits
    input [4:0] RW;     // RW is 5 bits
    input RegWr;
    input Clk;
    reg [63:0] registers [31:0];  // 32 registers where each are 64-bits
     
    initial registers[31] = 64'b0;  // Force Register 31 to always be 0
     
    assign #2 BusA = registers[RA]; // Set the register to take RA as variable
    assign #2 BusB = registers[RB]; // Set the register to take RB as variable
     
    always @ (negedge Clk) begin
        if(RegWr && RW != 31) // Make sure Register 31 is always 0
            registers[RW] <= #3 BusW;
    end
endmodule //end the module
