`define temperature 16'h4400
`define CS_pulse 4                                 //to load the value of TEMP sensor after a certain pulse , in this case 4th pulse
module LM70( SIO, SCK, CS ) 

input SCK,CS;
output SIO;

reg reset = 1'b1;
reg [15:0] temp;
int count=0;

assign gated_clk = ~CS & SCK;
assign SIO = temp[7];


always@(SCK) begin
   count <= count+1;
   if (count==CS_pulse) begin
      temp <= temperature
   end
end         


always@(posedge gated_clk) begin
   if (~CS) begin
      temp <= temperature>>1;
   end
end
                          
endmodule