`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:10:34 04/14/2016 
// Design Name: 
// Module Name:    banco_registros 
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
module banco_registros(
input wire clk,reset,
input wire [7:0] dato_bus,
input wire EN0,EN1,EN2,EN3,EN4,EN5,EN6,EN7,EN8,
output wire [7:0]hora,min,seg,dia,mes,ano,crhora,crmin,crseg
    );
hora_reg hora_reg (
    .clk(clk), 
    .reset(reset), 
    .dhora(dato_bus), 
    .EN(EN0), 
    .dato_hora(hora)
    );

min_reg min_reg (
    .clk(clk), 
    .reset(reset), 
    .dmin(dato_bus), 
    .EN(EN1), 
    .dato_min(min)
    );
seg_reg seg_reg (
    .clk(clk), 
    .reset(reset), 
    .dseg(dato_bus), 
    .EN(EN2), 
    .dato_seg(seg)
    );
dia_reg dia_reg (
    .clk(clk), 
    .reset(reset), 
    .ddia(dato_bus), 
    .EN(EN3), 
    .dato_dia(dia)
    );
mes_reg mes_reg (
    .clk(clk), 
    .reset(reset), 
    .dmes(dato_bus), 
    .EN(EN4), 
    .dato_mes(mes)
    );
ano_reg ano_reg(
    .clk(clk), 
    .reset(reset), 
    .dano(dato_bus), 
    .EN(EN5), 
    .dato_ano(ano)
    );

cr_hora_reg cr_hora_reg (
    .clk(clk), 
    .reset(reset), 
    .dcr_hora(dato_bus), 
    .EN(EN6), 
    .dato_cr_hora(crhora)
    );

cr_min_reg cr_min_reg (
    .clk(clk), 
    .reset(reset), 
    .dcr_min(dato_bus), 
    .EN(EN7), 
    .dato_cr_min(crmin)
    );
cr_seg_reg cr_seg_reg (
    .clk(clk), 
    .reset(reset), 
    .dcr_seg(dato_bus), 
    .EN(EN8), 
    .dato_cr_seg(crseg)
    );



endmodule
