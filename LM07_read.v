//DEFINES
`define RST_COUNT       5'b00000
`define MAX_COUNT       5'b11100
`define SPI_IDLE	    1'b0
`define SPI_READ	    1'b1
`define CS_LOW_COUNT    5'd4
`define CS_HIGH_COUNT   5'd20

module LM07_read(RSTN,SYSCLK,SIO,CS,SEL0,SEL1,SCK);

input RSTN,SYSCLK,SIO;
output reg CS = 1'b1;
output reg SCK =1'b1;;
output SEL0;
output SEL1;
reg [4:0] count=1'b1;


always@(posedge SYSCLK) begin
    count <= count+1;
    if (count == 3'd4) begin
        CS <= 1'b0;
    end
    else if (count == 5'd22) begin
        CS <=1'b1;
        count <= 1'b0;
    end
end

always@(negedge SYSCLK , negedge RSTN) begin
    if (CS) begin
        SCK <= 1'b0;
    end
    else if (CS == 1'b0)begin
        SCK <= ~SCK;
    end
end


endmodule