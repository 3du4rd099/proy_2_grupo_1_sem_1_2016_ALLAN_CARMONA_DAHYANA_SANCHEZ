`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:05:38 04/14/2016 
// Design Name: 
// Module Name:    cr_seg_reg 
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
module cr_seg_reg(
input wire clk,reset,
input wire [7:0] dcr_seg,
input wire EN,
output reg [7:0]dato_cr_seg
    );
initial begin 

dato_cr_seg=8'b0;

end


always@* begin     //posiblemente tengamos que cambiar a @*
if (reset)
dato_cr_seg<=0;
if(EN==1)
dato_cr_seg<=dcr_seg;
end
endmodule
 