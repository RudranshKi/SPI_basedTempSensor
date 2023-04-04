module seve_seg(A,out,cs);
  
  input [3:0] A;
  output reg [6:0] out;
  input cs;
  always@(A,cs) begin
  if (~cs) begin
      case ({A})
        4'b0000 : assign out = 7'h3f;
        4'b0001 : assign out = 7'h06;
        4'b0010 : assign out = 7'h5b;
        4'b0011 : assign out = 7'h4f;
        4'b0100 : assign out = 7'h66;
        4'b0101 : assign out = 7'h6d;
        4'b0110 : assign out = 7'h7d;
        4'b0111 : assign out = 7'h07;
        4'b1000 : assign out = 7'h7f;
        4'b1001 : assign out = 7'h6f;
      endcase
  end
  end
endmodule