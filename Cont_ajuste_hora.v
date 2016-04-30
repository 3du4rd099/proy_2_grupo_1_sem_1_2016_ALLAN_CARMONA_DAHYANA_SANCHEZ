`timescale 1ns / 1ps

module Cont_ajuste_hora( 
    input clk, //Señal de reloj de la nexys 100MHz
    input rst,//Reset despues del bloque metastailiad para resetear todos los contadores
	 input sw_hora, input sw_fecha, input sw_cronometro, //Interruptores externos de la nexys.  
    input parametro_der, input parametro_izq, //Señales despues del bloque de metastabilidad para seleccionar entre horas, min o seg
	 output reg a_hora, a_min, a_seg,//Señales de salida utilizadas para determinar la dirección a escribir.
    output reg [1:0] parametro_reloj// 2 bits para elegir entre hora, minutos y segundos
	 );
initial begin  a_hora=1'b0; a_min=1'b0; a_seg=1'b0; end

 always @(posedge clk)  				 //se cummple cuando hay un flanco positivo en el clk 
 begin
	if (rst || parametro_reloj==2'd3 )
		 parametro_reloj <= 2'b0;   						 // si reset esta activo pone la salida en 1  
	else if(sw_hora==1'b1 && sw_fecha==1'b0 && sw_cronometro==1'b0)begin
		if (parametro_der)  begin 			//condicion que se cumple si se presiona el boton derecha, cambia de posicion de parámetro
			 parametro_reloj <= parametro_reloj + 2'b1; //aumenta cuenta
			   end 								 
		else if (parametro_izq ) begin     //condicion que se cumple si se presiona el boton izquierda, cambia de posicion de parámetro 
			 parametro_reloj <= parametro_reloj - 2'b1;      //se disminuye cuenta
			   end      						
		else begin
			 parametro_reloj <= parametro_reloj; end
	
if (parametro_reloj==2'd0) a_hora <=1'b1; else a_hora <=1'b0; //Dependiendo del valor que se este cambiando, este bloque va a generar una señal
if (parametro_reloj==2'd1) a_min <=1'b1; else a_min <=1'b0; //de activación para ser usada en el bloque de direcciones
if (parametro_reloj==2'd2) a_seg <=1'b1; else a_seg <=1'b0;  end
else begin a_hora <=1'b0; a_min <=1'b0; a_seg <=1'b0; parametro_reloj <= parametro_reloj; end
end
endmodule 