`timescale 1ns / 1ps
//Este bloque recibe las señales de a_hora, a_min, a_seg, etc rpovenientes del bloque de Contadores_Escritura, dependiendo de
// la señal que se encuentre activa, asi será la dirección que se envia al RTC para escribir un dato.
module Direccion_Escritura(
	 input clk,
    input a_hora, a_min, a_seg,				 //
	 input a_dia, a_mes, a_year,				 // Señales del bloque Contadores_Escritura
	 input a_cr_hora, a_cr_min, a_cr_seg,	 //
	 output reg [7:0]direccion //Salida con la dirección del parámetro a cambiar
    );

//Las direcciones representan el registro de la memoria del RTC donde se encuentra el parámetro, estas direcciones son tomadas 
// de la hoja de datos del componente
always @(posedge clk)
begin	
	     if (a_hora==1'b1) direccion<=8'h23;
	else if (a_min==1'b1) direccion<=8'h22;
	else if (a_seg==1'b1) direccion<=8'h21;
	
	else if (a_dia==1'b1) direccion<=8'h24;
	else if (a_mes==1'b1) direccion<=8'h25;
	else if (a_year==1'b1) direccion<=8'h26;
	
	else if (a_cr_hora==1'b1) direccion<=8'h43;
	else if (a_cr_min==1'b1) direccion<=8'h42;
	else if (a_cr_seg==1'b1) direccion<=8'h41;


end

endmodule
