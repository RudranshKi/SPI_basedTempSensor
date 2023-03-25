module LM70( SIO, SCK, CS ) 

input SCK,CS;
output SIO;
                          
always@(CS) begin
   if (~CS) begin
      
   end
end
                          
endmodule