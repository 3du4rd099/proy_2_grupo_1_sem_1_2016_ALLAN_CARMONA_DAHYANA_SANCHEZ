`timescale 1ns / 1ps

module Ajuste_fecha(
input wire clk,
    input wire rst,
    input wire sw_hora,input wire sw_fecha,input wire sw_cronometro,
	 input wire aumento, disminuye, par_der, par_izq,
	 output [4:0]cont_dia, 
	 output [3:0] cont_mes, 
	 output[6:0]cont_year,
	 output a_dia, a_mes, a_year
    );
	 
wire [1:0] EN;

Cont_ajuste_fecha Cont_ajuste_fecha (
    .clk(clk), 
    .rst(rst), 
    .sw_hora(sw_hora), 
    .sw_fecha(sw_fecha), 
    .sw_cronometro(sw_cronometro), 
    .parametro_der(par_der), 
    .parametro_izq(par_izq), 
	 .a_dia(a_dia),
	 .a_mes(a_mes),
	 .a_year(a_year),
    .parametro_fecha(EN)
    );
Contador_dia Contador_dia (
    .clk(clk), 
    .rst(rst), 
    .EN(EN), 
    .aumento(aumento), 
    .disminuye(disminuye), 
    .cont_dia(cont_dia)
	    );
	 
Contador_mes Contador_mes (
    .clk(clk), 
    .rst(rst), 
    .EN(EN), 
    .aumento(aumento), 
    .disminuye(disminuye), 
    .cont_mes(cont_mes)	 
    );

Cont_year Cont_year (
    .clk(clk), 
    .rst(rst), 
    .EN(EN), 
    .aumento(aumento), 
    .disminuye(disminuye), 
    .cont_year(cont_year)	 
    );
endmodule
