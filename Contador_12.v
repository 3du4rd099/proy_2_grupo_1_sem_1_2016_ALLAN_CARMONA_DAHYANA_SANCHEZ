`timescale 1ns / 1ps
//Este módulo controla el contador de horas
module Contador_hora(    //declaracion de entradas y salidas
	 input clk,				 //clock 
	 input rst,				 //reset \ Señales despues de los bloques de metastabilidad
	 input [1:0]EN,
    input aumento,	    //boton aumento cuenta \ Señales despues de los bloques de metastabilidad
    input disminuye,	 //boton dismuye cuenta    /
    output reg [3:0] cont_hora, //salida del contador de 4bits para contar de 0 a 12 
	 //output reg a_hora,
	 output reg am_pm
	 );

initial am_pm=1'b0; // señal para determinar el formato de hora ya sea am o pm
 always @(posedge clk )  		 //se cummple cuando hay un flanco positivo en el clk 
 begin
  if (rst || cont_hora==4'd12) begin
		cont_hora <= 4'b0;   						 // si reset esta activo pone la salida en 1  
		am_pm<=~am_pm; end //Si el contador llega a 12 la señal de am_pm se invierte
  else if (EN==2'd0) begin //El enable viene del bloque Cont_ajuste_hora
		 if (aumento ) begin				//condicion que se cumple si se presiona el boton aumento
				cont_hora <= cont_hora + 4'b1;   	//aumenta cuenta
				 end  							//guarda para el antirrebote
		else if (disminuye) begin  		//condicion que se cumple si se presiona el boton disminuye
			if (cont_hora==4'b0) cont_hora<=0;
			else begin
				cont_hora <= cont_hora - 4'b1;      //se disminuye cuenta
			  end end						
		else	begin
				cont_hora <= cont_hora;	
				end
	end
end
	
endmodule
