`timescale 1ns / 1ps

//Los bloques de Metastabilidad se utiizan para evitar el rebote de tienen los botones de la nexys, por lo tanto se utiliza
//un bloque de metastabilidad para cada uno de los botones de aumento, disminuye, derecha, izquierda y el boton de reset
//De esta manera se logra obtener un pulso sin perturbaciones ni estados metaestables.
//Dentro de este módulo se encuentran los 5 módulos de metastabilidad para todas las señales provenientes de los botones, sin
//embargo solo se explica el funcionamiento del bloque de aumento, ya que todos los demás funcionan de la misma manera.

module Bloques_metastabilidad( 
    input botton_aumento, botton_disminuye, //Entradas de los botones
    input botton_derecha, botton_izquierda,
    input botton_reset, clk,
    output aumento, disminuye,//Salidas sin rebote despues del bloque metastabilidad que serán utilizadas pposteriormente para
    output derecha, izquierda,// el bloque de Escritura en los contadores.
    output rst
    );


Aumento_metastabilidad Aumento_metastabilidad (
    .botton_aumentar(botton_aumento), 
    .clk(clk), 
    .aumentar(aumento)
    );
	
Disminuye_metastabilidad Disminuye_metastabilidad (
    .botton_disminuir(botton_disminuye), 
    .clk(clk), 
    .disminuir(disminuye)
    );
	 
Derecha_metastabilidad Derecha_metastabilidad (
    .botton_derecha(botton_derecha), 
    .clk(clk), 
    .derecha(derecha)
    );
	 
Izquierda_metastabilidad Izquierda_metastabilidad (
    .botton_izquierda(botton_izquierda), 
    .clk(clk), 
    .izquierda(izquierda)
    );

reset_metastabilidad reset_metastabilidad (
    .botton_rst(botton_reset), 
    .clk(clk), 
    .rst(rst)
    );
endmodule
