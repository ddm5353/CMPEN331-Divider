`timescale 1ns / 1ps

module lab1_divider_tb();
    reg [31:00] a;
    reg [15:00] b;
    wire [31:00] q;
    wire [15:00] r;
    reg clk, start; 
    wire [4:0] count;
    reg clrn;
    
lab1_divider lab1_divider_uut(
    .clrn(clrn),
    .clk(clk),
    .start(start),
    .a(a),
    .b(b),
    .q(q),
    .r(r),
    .busy(busy),
    .ready(ready),
    .count(count)
    );
initial begin
    a = 32'h4c7f228a;
    b = 16'h6a0e;
    clk = 1;
    start = 0;
    #5 start = 1;
    clrn = 1;
    #10 start = 0;
end
always #5 clk = ~clk;
endmodule