`timescale 1ns / 1ps
//Este bloque envía los datos para inicializar el RTC, así como los datos de configuración inicial
module Inicializar(
	input clk, enable_inicio, //Señal de reloj del sistema y señal de enable de la FSM
	input [5:0]cont_escritura,//Recibe el daro del bloque Signal_Control_Escritura, para definir la secuencia en que son enviados los daros
	input reset_listo_inicio, //Viene de FSM
	output [7:0]bus_out_inicio,// Bus de salida con la secuencia de los datos para inicializar
	output reg listo_inicio// señal hacia fsm
    );
reg [7:0]bus_out;	 

reg [2:0] cont_inicializar=3'b0;

 always @ (posedge clk)
begin
if (enable_inicio==1'b1)begin //Si la FSM le envía la señal de inicalizar, entonces el bloque procede a enviar los parámetros para configurar
//el inicio y el formato que se va a utilizar
	if (cont_inicializar==3'd0) begin
		if (cont_escritura==6'd7) bus_out<=8'h02; // en el status 02 pone el bit 4 en 1
		else if (cont_escritura==6'd29) bus_out<= 8'h01;
		else if (cont_escritura==6'd42) cont_inicializar<=cont_inicializar+3'd1; end 
		
	else if (cont_inicializar==3'd1) begin
		if (cont_escritura==6'd7) bus_out<=8'h02; // en el status 02 pone el bit 4 en 2
		else if (cont_escritura==6'd29) bus_out<= 8'h00;
		else if (cont_escritura==6'd42) cont_inicializar<=cont_inicializar+3'd1; end 
		
	else if (cont_inicializar==3'd2) begin
		if (cont_escritura==6'd7) bus_out<=8'h10;
		else if (cont_escritura==6'd29) bus_out<= 8'hD2; //escribe d2
		else if (cont_escritura==6'd42) cont_inicializar<=cont_inicializar+3'd1; end 
	
	else if (cont_inicializar==3'd3) begin
		if (cont_escritura==6'd7) bus_out<=8'h00; //status 00
		else if (cont_escritura==6'd29) bus_out<= 8'b00011010; 
		else if (cont_escritura==6'd42) cont_inicializar<=cont_inicializar+3'd1; end 
	
	else if (cont_inicializar==3'd4) begin
		if (cont_escritura==6'd7) bus_out<=8'h01; //status 01
		else if (cont_escritura==6'd29) bus_out<= 8'b00000000; 
		else if (cont_escritura==6'd42) cont_inicializar<=cont_inicializar+3'd1; end
		
	else if (cont_inicializar==3'd5) begin
		if (cont_escritura==6'd7) bus_out<=8'h02;
		else if (cont_escritura==6'd29) bus_out<= 8'h04; 
		else if (cont_escritura==6'd42) begin listo_inicio <=1'b1; cont_inicializar<=3'd0;  end end
	
end

else if (reset_listo_inicio==1'b1) listo_inicio <=1'b0;

else bus_out<=bus_out;

end

assign bus_out_inicio=bus_out;
endmodule
