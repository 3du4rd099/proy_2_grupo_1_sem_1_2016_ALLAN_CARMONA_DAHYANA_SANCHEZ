`timescale 1ns / 1ps
//Este bloque se encarga de ajustar los parámetros de reloj, como lo son horas, minutos y segundos
//El módulo "Cont_ajuste_hora" permite desplazar el cursor entre los datos de hora, minutos o segundos, esto con las flechas de 
//izquierda o derecha, mientras que con los botones de aumento o disminuye permiten aumentar o disminuir el valor del parámetro
// a cambiar.

module Ajuste_reloj(
    input wire clk, //Señal de reloj de la nexys 100MHz
    input wire rst, //Reset despues del bloque metastailiad para resetear todos los contadores
    input wire sw_hora,input wire sw_fecha,input wire sw_cronometro, //Interruptores externos de la nexys 
																							//En este caso debe estar activo el sw_hora y los demás desactivados
	 input wire aumento, input wire disminuye, input wire par_der, input wire par_izq, //Señales despues del bloque de metastabilidad
	 output [3:0]cont_hora, //Salida con el valor de horas ajustado por el usuario
	 output[5:0] cont_min, //Salida con el valor de minutos
	 output [5:0]cont_seg, //Salida con el valor de segundos
	 output a_hora, output a_min, output a_seg, output am_pm //Señales de salida utilizadas para determinar la dirección a escribir.
	 //La señal de am_pm es utilizada para desplegar en la nexys el formato de am o pm.
    );
wire [1:0] EN;

Cont_ajuste_hora Cont_ajuste_hora (
    .clk(clk), 
    .rst(rst), 
    .sw_hora(sw_hora), 
    .sw_fecha(sw_fecha), 
    .sw_cronometro(sw_cronometro), 
    .parametro_der(par_der), 
    .parametro_izq(par_izq), 
	 .a_hora(a_hora),
	 .a_min(a_min),
	 .a_seg(a_seg),
    .parametro_reloj(EN)
    );
	 
Contador_hora Contador_hora (
    .clk(clk), 
    .rst(rst), 
    .EN(EN), 
    .aumento(aumento), 
    .disminuye(disminuye), 
    .cont_hora(cont_hora),
	 .am_pm(am_pm)
    );
	 

Contador_min Contador_min (
    .clk(clk), 
    .rst(rst), 
	 .EN(EN), 
    .aumento(aumento), 
    .disminuye(disminuye), 
    .cont_min(cont_min)
	   );

Contador_seg Contador_seg (
    .clk(clk), 
    .rst(rst),
	 .EN(EN), 	 
    .aumento(aumento), 
    .disminuye(disminuye), 
    .cont_seg(cont_seg)
    );
endmodule
