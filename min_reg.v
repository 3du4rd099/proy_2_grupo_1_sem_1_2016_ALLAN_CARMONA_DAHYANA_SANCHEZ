`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:41:53 04/14/2016 
// Design Name: 
// Module Name:    min_reg 
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
module min_reg(
input wire clk,reset,
input wire [7:0] dmin,
input wire EN,
output reg [7:0]dato_min
    );
initial begin 

dato_min=8'b0;

end

always@* begin     //posiblemente tengamos que cambiar a @*
if (reset)
dato_min<=0;
if(EN==1)
dato_min<=dmin;
end
endmodule

 