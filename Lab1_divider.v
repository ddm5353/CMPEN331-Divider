`timescale 1ns / 1ps

module lab1_divider(
input [31:00] a,
input [15:00] b,
input clrn, 
input start, 
input clk, 
output [31:00] q, 
output [15:00] r, 
output reg busy, 
output reg ready, 
output reg [4:0] count
);

reg [15:00] reg_r;      //Remainder
reg [15:00] reg_b;      //Divisor
reg [31:00] reg_q;      //Quotient

wire [16:00] sub = {reg_r, reg_q[31]} - {1'b0, reg_b};                  //Subtractor
wire [15:00] mux_r = sub[16] ? {reg_r[14:00], reg_q[31]} : sub[15:00];  //Multiplexer to choose previous input or difference

assign r = reg_r;
assign q = reg_q;

always @ (posedge clk) begin
    if (start) begin
        reg_q <= a;
        reg_b <= b;
        reg_r <= 0;
        busy <= 1;
        ready <= 0;
        count <= 0;
    end else if(busy) begin
        reg_q <= {reg_q[30:00], ~sub[16]};      //shift register for quotient
        reg_r <= mux_r;
        count <= count + 5'b1;
    end if(count == 5'h1f)
        begin
        busy <= 0;
        ready <= 1;
        end
    end
endmodule
