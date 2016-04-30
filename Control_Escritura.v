`timescale 1ns / 1ps

//Este bloque se encarga de definir la secuencia para el envío de datos al RTC cuando se quiera configurar algún parámetro del reloj

module Control_Escritura(
	input clk, enable_escribir, //Señal de reloj del sistema y señal de enable de la FSM
	input [5:0] cont_escritura, //Contador del bloque Signal_Control_Escritura
	input [7:0] dato_escritura, //BCD
	input [7:0]direccion,		 // Dirección del registro a escribir
	input reset_listo_escritura,//Viene de FSM
	output reg listo_escribir, //Salida hacia la FSM
	output  reg [7:0] bus_out_escribir //Salida del bus con el dato de direccion y con el dato que se quiere guardar
    );
 
 always @ (posedge clk)
begin
	if (enable_escribir) begin 
		  if (cont_escritura==6'd7) bus_out_escribir<=direccion;
	else if (cont_escritura==6'd29) bus_out_escribir<= dato_escritura;
	else if (cont_escritura==6'd42) listo_escribir<=1'b1; //Cuando termina de hacer toda la secuencia activa la señal de listo escritura
																			//para indicar a la FSM que el proceso ha finalizado
	end 
	else begin if(reset_listo_escritura==1'b1) listo_escribir<=1'b0; //Si recibe la señal de reset de la FSM el contador se inicializa para 
																			//esperar que se habilite el proceso nuevamente
	else bus_out_escribir<=bus_out_escribir; end
end 

endmodule
