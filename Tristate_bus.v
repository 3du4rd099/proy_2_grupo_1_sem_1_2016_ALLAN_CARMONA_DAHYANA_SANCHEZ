`timescale 1ns / 1ps

//Este bloque se utiliza para colocar en alta impedancia el bus de salidad de datos al RTC, cuando este se 
//encuentre en el proceso de lectura
module Tristate_bus(
   // input enable,
    input [7:0] bus_out,
	 input en_tri_l, en_tri_e, //Señales de enable provenientes de los bloques de Señales de Control
    output [7:0] Bus_datos //bus de salidad de datos al RTC
    );

//Si alguna de las dos señales que habilira el tercer estado está activa, entonces el bus de datos toma el valor del bus de salida 
//correspondiente de lo contrario toma un valor de alta impedancia.
assign Bus_datos = ((en_tri_l==1) || (en_tri_e==1)) ? bus_out : 8'bzzzzzzzz;
//Cabe resaltar que el estado de alta impedancia se realiza al bus que va hacia la salida, ya que en la nexys 4 no es posible hacer 
//Bloques de alta impedancia en los módulos internos.
endmodule
