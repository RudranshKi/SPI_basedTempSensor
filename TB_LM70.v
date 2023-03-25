module tb() ;

reg SCK;
reg CS;
wire SIO;

LM07 lm(CS,SCK,SIO);

always #5 SCK = ~SCK;

initial begin 
    $monitor("time=%0b SCK=%b CS=%b SIO=%b",$time,SCK,CS,SIO);
    $dumpfile("dump.vcd");
    $dumpvars(1);
    SCK = 1'b0;
    CS  = 1'b1;
    #5 CS = 1'b0;
    #100 CS = 1'b1;
    #20 CS =1'b0;
    #80 $finish;
end

endmodule