`timescale 1ns / 1ps

//Este bloque se utiliza para guardar el dato del registro de la memoria del RTC, al área reservada del mismo. Para esto es 
//necesario utilizar uno de los comandos de RTC, en este caso se utiliza el comando F0
module Guardar_RTC(
    input clk,
	 input listo_escritura, //Recibe la señal del bloque Control_Escritura para indicar cuando ha terminado de escribir
	 input [5:0] cont_escritura, //Recibe el daro del bloque Signal_Control_Escritura, para definir la secuencia en que son enviados los datos
	 input reset_listo_guardar, //Recibe un reset de la FSM
    output reg [7:0] bus_out_guardar, // Bus de salida con el comando para guardar en el área reservada
	 output reg listo_guardar// señal hacia fsm
    );

 always @ (posedge clk)
begin
	if (listo_escritura) begin 
		  if (cont_escritura==6'd7) bus_out_guardar<=8'hF0;
			else if (cont_escritura==6'd29) bus_out_guardar<= 8'hF0;
			else if (cont_escritura==6'd42) listo_guardar<=1'b1; 
	end 
	else if (reset_listo_guardar==1'b1) listo_guardar<=1'b0; //Si recibe la señal de reset de la FSM el la señal de listo guardar se reinicia para 
																			//esperar que se habilite el proceso nuevamente
	else bus_out_guardar<= bus_out_guardar;
end 

endmodule
