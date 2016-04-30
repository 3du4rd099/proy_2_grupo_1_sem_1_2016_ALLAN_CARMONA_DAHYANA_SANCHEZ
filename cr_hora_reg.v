`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:02:25 04/14/2016 
// Design Name: 
// Module Name:    cr_hora_reg 
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
module cr_hora_reg(
input wire clk,reset,
input wire [7:0] dcr_hora,
input wire EN,
output reg [7:0]dato_cr_hora
    );
initial begin 

dato_cr_hora=8'b0;

end

always@* begin     //posiblemente tengamos que cambiar a @*
if (reset)
dato_cr_hora<=0;
if(EN==1)
dato_cr_hora<=dcr_hora;
end
endmodule

 