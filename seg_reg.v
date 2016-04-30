`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:47:14 04/14/2016 
// Design Name: 
// Module Name:    seg_reg 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module seg_reg(
input wire clk,reset,
input wire [7:0] dseg,
input wire EN,
output reg [7:0]dato_seg
    );
initial begin 

dato_seg=8'b0;

end

always@* begin     //posiblemente tengamos que cambiar a @*
if (reset)
dato_seg<=0;
if(EN==1)
dato_seg<=dseg;
end
endmodule
 