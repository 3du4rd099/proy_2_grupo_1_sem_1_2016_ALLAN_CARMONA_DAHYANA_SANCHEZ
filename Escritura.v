`timescale 1ns / 1ps
//En este bloque ingresan todas las señales de salida del bloque de metastabilidad, y son utilizadas por los contadores para 
//aumentar o disminuir el valor de las horas, minutos, segundos etc.
//La salida de este bloque corresponde al dato del parámetro que se este cambiando en forma hexadecimal, para que pueda ser
// enviado directamente al RTC
//además presenta unas salidas de a_hora, a_seg, a_min, etc, estas son utilizadas por el bloque de Direcciones para establecer  
//la dirección a la cuál se le va escribir el dato.
//Debido a que los bloques de Ajuste reloj, Ajuste Fecha y Ajuste Cronómetro tienen la misma estructura, se explica el funcionamiento
//Para uno solo de ellos, en este caso el bloque de ajuste hora.

   module Contadores_Escritura(
    input clk, input rst,
    input botton_aumento, botton_disminuye,
    input botton_derecha, botton_izquierda,
    input sw_reloj, sw_fecha, sw_cronometro,
	 output wire a_hora, a_min, a_seg, am_pm, a_dia, a_mes ,a_year, a_cr_hora, a_cr_min, a_cr_seg,
	 output [7:0] dato_escritura //dato_BCD
    );

wire [3:0]contador_hora; 
wire [5:0]contador_min; 
wire [5:0]contador_seg;
wire [4:0]contador_dia; 
wire [3:0]contador_mes; 
wire [6:0]contador_year; 
wire [3:0]cronometro_hora; 
wire [5:0]cronometro_min;
wire [5:0]cronometro_seg;

Ajuste_reloj Ajuste_reloj (
    .clk(clk), 
    .rst(rst), 
    .sw_hora(sw_reloj), 
    .sw_fecha(sw_fecha), 
    .sw_cronometro(sw_cronometro), 
    .aumento(botton_aumento), 
    .disminuye(botton_disminuye), 
    .par_der(botton_derecha), 
    .par_izq(botton_izquierda), 
    .cont_hora(contador_hora), 
    .cont_min(contador_min), 
    .cont_seg(contador_seg), 
    .a_hora(a_hora), 
    .a_min(a_min), 
    .a_seg(a_seg), 
    .am_pm(am_pm)
    );	
	 
Ajuste_fecha Ajuste_fecha (
    .clk(clk), 
    .rst(rst), 
    .sw_hora(sw_reloj), 
    .sw_fecha(sw_fecha), 
    .sw_cronometro(sw_cronometro), 
    .aumento(botton_aumento), 
    .disminuye(botton_disminuye), 
    .par_der(botton_derecha), 
    .par_izq(botton_izquierda), 
    .cont_dia(contador_dia), //**
    .cont_mes(contador_mes), 
    .cont_year(contador_year), 
    .a_dia(a_dia), 
    .a_mes(a_mes), 
    .a_year(a_year) //**
    );
	 
Ajuste_cronometro Ajuste_cronometro (
    .clk(clk), 
    .rst(rst), 
    .sw_hora(sw_reloj), 
    .sw_fecha(sw_fecha), 
    .sw_cronometro(sw_cronometro), 
    .aumento(botton_aumento), 
    .disminuye(botton_disminuye), 
    .par_der(botton_derecha), 
    .par_izq(botton_izquierda), 
    .crono_hora(cronometro_hora), 
    .crono_min(cronometro_min), 
    .crono_seg(cronometro_seg), 
    .a_cr_hora(a_cr_hora), 
    .a_cr_min(a_cr_min), 
    .a_cr_seg(a_cr_seg)
    );
	 
	 
	 Decodificador_Escritura Decodificador_Escritura (
    .clk(clk), 
    .cont_hora(contador_hora), 
    .cont_min(contador_min), 
    .cont_seg(contador_seg), 
    .cont_dia(contador_dia), 
    .cont_mes(contador_mes), 
    .cont_year(contador_year), 
    .crono_hora(cronometro_hora), 
    .crono_min(cronometro_min), 
    .crono_seg(cronometro_seg), 
    .am_pm(am_pm), 
    .a_hora(a_hora), 
    .a_min(a_min), 
    .a_seg(a_seg), 
    .a_dia(a_dia), 
    .a_mes(a_mes), 
    .a_year(a_year), 
    .a_cr_hora(a_cr_hora), 
    .a_cr_min(a_cr_min), 
    .a_cr_seg(a_cr_seg), 
    .dato_BCD(dato_escritura)
    );
	 
	 /*assign a_hora_out = a_hora;
	 assign a_min_out = a_min;
	 assign a_seg_out = a_seg;
	 assign am_pm_out = am_pm; 
	 assign a_dia_out = a_dia;
	 assign a_mes_out = a_mes;
    assign a_year_out = a_year;
	 assign a_cr_hora_out = a_cr_hora;
	 assign a_cr_min_out = a_cr_min;
	 assign a_cr_seg_out = a_cr_seg
	 
	 
	 
Decodificador_Escritura Decodificador_Escritura (
    .clk(clk), 
    .cont_hora(contador_hora), 
    .cont_min(contador_min), 
    .cont_seg(contador_seg), 
    .cont_dia(contador_dia), 
    .cont_mes(contador_mes), 
    .cont_year(contador_year), 
    .crono_hora(cronometro_hora), 
    .crono_min(cronometro_min), 
    .crono_seg(cronometro_seg), 
    .am_pm(am_pm), 
    .a_hora(a_hora), 
    .a_min(a_min), 
    .a_seg(a_seg), 
    .a_dia(a_dia), 
    .a_mes(a_mes), 
    .a_year(a_year), 
    .a_cr_hora(a_cr_hora), 
    .a_cr_min(a_cr_min), 
    .a_cr_seg(a_cr_seg), 
    .dato_BCD(dato_escritura)
    );*/
endmodule
