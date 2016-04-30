`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:55:54 04/14/2016 
// Design Name: 
// Module Name:    mes_reg 
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
module mes_reg(
input wire clk,reset,
input wire [7:0] dmes,
input wire EN,
output reg [7:0]dato_mes
    );
initial begin 

dato_mes=8'b0;

end

always@* begin     //posiblemente tengamos que cambiar a @*
if (reset)
dato_mes<=0;
if(EN==1)
dato_mes<=dmes;
end
endmodule


 