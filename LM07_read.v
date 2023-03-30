`include "bin2BCD.v"
`include "seve_seg.v"

//DEFINES
`define CS_LOW_COUNT    5'd12 
`define CS_HIGH_COUNT   5'd30
`define CS_initial      1'b1
`define SCK_initial     1'b1

module LM07_read(RSTN,SYSCLK,SIO,CS,disp,SCK,data,chk_state,if_done);

input RSTN,SYSCLK,SIO;
output reg CS  = `CS_initial;
output reg SCK =`SCK_initial;
output [1:0] disp;               // to choose the 7 segment display
reg [7:0] data_latched;         //remove output
output [7:0] data;              //final output
//output [7:0] data_disp;         //final output through decoder

reg SEL_EN = 1'b1;               // to choose 7 segment display selection process of disp
wire [3:0] display_data;
reg [3:0] count_SCK=4'd0;
reg [4:0] count=1'b1;
reg [7:0] data_out;
output reg chk_state;                   //remove output
reg RSTN_BCD = 1'b1;             //remove output
wire [3:0] displayLSB;           //remove output
wire [3:0] displayMSB;           //remove output
output wire if_done;             //remove output

bin2BCD b2B(data_latched[6:0],displayLSB,displayMSB,RSTN_BCD,SYSCLK,if_done);
seve_seg sg();

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

always@(posedge SYSCLK) begin
    SEL_EN <= ~SEL_EN;
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


assign disp[0] = ((if_done == 1'b1) && (SEL_EN == 1'b0) && (CS == 1'b1)) ? 1'b1 : 1'b0;
assign disp[1] = ((if_done == 1'b1) && (SEL_EN == 1'b1) && (CS == 1'b1)) ? 1'b1 : 1'b0;
assign display_data = (disp[1]== 1'b1) ? displayMSB : displayLSB;
assign data[7:4] = displayMSB;
assign data[3:0] = display_data;
endmodule