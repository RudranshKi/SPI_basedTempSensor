//Define
`define TEMP_SET  16'h44C0

module LM07(CS, SCK, SIO);
  output SIO;
  input SCK, CS;

  reg [15:0] shift_reg;
  wire clk_gated;

  initial begin
    shift_reg = `TEMP_SET; 
  end
  
  assign SIO = shift_reg[15];

  assign clk_gated = ~CS & SCK;

  always @(CS)
   begin
     shift_reg = `TEMP_SET;
   end

  always @(negedge clk_gated)
    begin
      shift_reg = shift_reg<<1;
    end
endmodule