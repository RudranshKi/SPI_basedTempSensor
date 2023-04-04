`timescale 1ns/1ps

`include "LM07.v"

module tb();
wire CS,SCK;
wire SEL0,SEL1;
reg RSTN,SYSCLK;
wire SIO;
wire [1:0] disp;
wire [7:0] data;
//wire [7:0] data_disp;
wire chk_state;
wire [6:0] disp_seg_LSB;
wire [6:0] disp_seg_MSB;
wire seg_disp;
wire ready_seg;
wire [3:0] displayLSB;
wire [3:0] displayMSB;

LM07_read lm(RSTN,SYSCLK,SIO,CS,disp,SCK,data,chk_state,disp_seg_LSB,disp_seg_MSB,seg_disp,ready_seg,displayLSB,displayMSB);
LM07 lm1(CS,SCK,SIO);

always #5 SYSCLK <= ~SYSCLK;

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
    RSTN = 1'b0;
    SYSCLK = 1'b0;
    #5 RSTN = 1'b1;
    #800 $finish;
end
endmodule