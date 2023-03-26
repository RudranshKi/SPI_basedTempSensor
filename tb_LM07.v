`timescale 1ns/1ps

`include "LM07.v"

module tb();
wire CS,SCK;
wire SEL0,SEL1;
reg RSTN,SYSCLK;
wire SIO;
wire [7:0] data_latched;


LM07_read lm(RSTN,SYSCLK,SIO,CS,SEL0,SEL1,SCK,data_latched);
LM07 lm1(CS,SCK,SIO);

always #5 SYSCLK <= ~SYSCLK;

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
    RSTN = 1'b0;
    SYSCLK = 1'b0;
    #5 RSTN = 1'b1;
    #2000 $finish;
end
endmodule