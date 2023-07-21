module NextPClogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch); 
   input [63:0] CurrentPC, SignExtImm64; 
   input Branch, ALUZero, Uncondbranch; 
   output [63:0] NextPC; 

   reg [63:0] s; //create temp variable to assign NextPC to outside the always block
   
   always @(*) begin   //Begin with any input

      if((Branch & ALUZero) || (Uncondbranch))  // Check if unconditional branch or (ALUZero and Branch) is enabled
         begin
         s = CurrentPC + SignExtImm64; // Add the shift to the current PC address 
         end
      else
         begin
         s = CurrentPC + 4; // Add 4 to the current PC address
         end
   end
   assign NextPC = s;  // Assign statement needs to be outside the always block
endmodule //end the module
