`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:09:12 04/14/2016 
// Design Name: 
// Module Name:    hora_reg 
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
module hora_reg(
input wire clk,reset,
input wire [7:0] dhora,
input wire EN,
output reg [7:0]dato_hora
    );
initial begin 

dato_hora=8'b0;

end

always@* begin     //posiblemente tengamos que cambiar a @*
if (reset)
dato_hora<=0;
if(EN==1)
dato_hora<=dhora;
end
endmodule
