module test;

reg a;
reg b;
wire c;

assign c = a & b;

initial begin
    a = 0;
    b = 0;
    #10 a = 1;
    #10 b = 1;
    #10 $finish;
end

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,test);
end

endmodule