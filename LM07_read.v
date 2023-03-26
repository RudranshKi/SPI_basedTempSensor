`include "bin2BCD.v"


//DEFINES
`define RST_COUNT       5'b00000
`define MAX_COUNT       5'b11100
`define SPI_IDLE	    1'b0
`define SPI_READ	    1'b1
`define CS_LOW_COUNT    5'd10 
`define CS_HIGH_COUNT   5'd28
`define CS_initial      1'b1;
`define SCK_initial     1'b1;

module LM07_read(RSTN,SYSCLK,SIO,CS,SEL0,SEL1,SCK,data_latched);

input RSTN,SYSCLK,SIO;
output reg CS = `CS_initial;
output reg SCK =`SCK_initial;
output SEL0;
output SEL1;
output reg [7:0] data_latched;

reg [3:0] count_SCK=4'd0;
reg [4:0] count=1'b1;
reg [7:0] data_out;
reg chk_state;                   //remove output
reg RSTN_BCD = 1'b1;             //remove output
wire [3:0] displayLSB;           //remove output
wire [3:0] displayMSB;           //remove output

bin2BCD b2B(data_latched[6:0],displayLSB,displayMSB,RSTN_BCD,SYSCLK);

always@(posedge SYSCLK) begin
    count <= count+1;
    if (count == `CS_LOW_COUNT) begin
        CS <= 1'b0;
        chk_state <= 1'b0;
        data_out <= 8'b0;
        count_SCK <= 4'd0;
        
    end
    else if (count == `CS_HIGH_COUNT) begin
        CS <=1'b1;
        count <= 1'b0;
        data_out <= 8'd0;
    end
    
end

always@(negedge SYSCLK , negedge RSTN) begin
    if (CS) begin
        SCK <= 1'b0;
    end
    else if (CS == 1'b0)begin
        SCK <= ~SCK;
    end
    if (SCK == 1'b1) begin
        RSTN_BCD <= 1'b1;
    end
end

always@(posedge SCK) begin
        count_SCK <= count_SCK + 1;
        data_out    = data_out<<1;                   // to negate the 15th bit from temp sensor since our sensor counts from 00-99 with one sign bit so essentially 8 bits from which 7 bits are for temp sensor and one bit for sign
        data_out[0] = SIO;
        if (count_SCK == 4'd8) begin                 //to count the SCK for latching out the data just before the end of the last read cycle 
            chk_state <= 1'b1;
        end
end

always@(posedge chk_state) begin
    data_latched <= data_out;
    if (chk_state == 1'b1) begin
        RSTN_BCD <= 1'b0;
    end
end

always@(negedge chk_state) begin
    data_latched <= 8'd0;
end

endmodule