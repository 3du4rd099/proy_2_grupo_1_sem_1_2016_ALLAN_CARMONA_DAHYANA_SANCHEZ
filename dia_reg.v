`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:53:32 04/14/2016 
// Design Name: 
// Module Name:    dia_reg 
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
module dia_reg(
input wire clk,reset,
input wire [7:0] ddia,
input wire EN,
output reg [7:0]dato_dia
    );
initial begin 

dato_dia=8'b0;

end

always@* begin     //posiblemente tengamos que cambiar a @*
if (reset)
dato_dia<=0;
if(EN==1)
dato_dia<=ddia;
end
endmodule
 