`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:04:22 04/14/2016 
// Design Name: 
// Module Name:    cr_min_reg 
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
module cr_min_reg(
input wire clk,reset,
input wire [7:0] dcr_min,
input wire EN,
output reg [7:0]dato_cr_min
    );
initial begin 

dato_cr_min=8'b0;

end

always@* begin     //posiblemente tengamos que cambiar a @*
if (reset)
dato_cr_min<=0;
if(EN==1)
dato_cr_min<=dcr_min;
end
endmodule

 