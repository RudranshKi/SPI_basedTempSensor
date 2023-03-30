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

LM07_read lm(RSTN,SYSCLK,SIO,CS,disp,SCK,data);
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