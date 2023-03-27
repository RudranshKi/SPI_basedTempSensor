`timescale 1ns/1ps

`include "LM07.v"

module tb();
wire CS,SCK;
wire SEL0,SEL1;
reg RSTN,SYSCLK;
wire SIO;
wire [7:0] data_latched;
wire [3:0] displayLSB;
wire [3:0] displayMSB;
//wire [7:0] data;

LM07_read lm(RSTN,SYSCLK,SIO,CS,SEL0,SEL1,SCK,data_latched,displayLSB,displayMSB);
LM07 lm1(CS,SCK,SIO);

always #5 SYSCLK <= ~SYSCLK;

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
    RSTN = 1'b0;
    SYSCLK = 1'b0;
    #5 RSTN = 1'b1;
    #1000 $finish;
end
endmodule