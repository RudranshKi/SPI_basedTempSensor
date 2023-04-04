module seve_seg(A,out,cs,clear);
  
  input [3:0] A;
  output reg [6:0] out;
  input cs;
  input clear;
  always@(A,cs) begin
    if (~clear) begin
  if (~cs) begin
      case ({A})
        4'b0000 :  out = 7'h3f;
        4'b0001 :  out = 7'h06;
        4'b0010 :  out = 7'h5b;
        4'b0011 :  out = 7'h4f;
        4'b0100 :  out = 7'h66;
        4'b0101 :  out = 7'h6d;
        4'b0110 :  out = 7'h7d;
        4'b0111 :  out = 7'h07;
        4'b1000 :  out = 7'h7f;
        4'b1001 :  out = 7'h6f;
      endcase
  end
    end
    else out = 7'h00;
  end
endmodule