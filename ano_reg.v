`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:57:22 04/14/2016 
// Design Name: 
// Module Name:    ano_reg 
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
module ano_reg(
input wire clk,reset,
input wire [7:0] dano,
input wire EN,
output reg [7:0]dato_ano
    );
initial begin 

dato_ano=8'b0;

end
always@* begin     //posiblemente tengamos que cambiar a @*
if (reset)
dato_ano<=0;
if(EN==1)
dato_ano<=dano;
end
endmodule
 