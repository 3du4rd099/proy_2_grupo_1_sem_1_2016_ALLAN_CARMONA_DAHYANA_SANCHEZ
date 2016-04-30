`timescale 1ns / 1ps
//Este módulo se utiliza para definir el orden y los tiempos en el que el programa le solicita datos al RTC
module Secuencia_leer(
	 input clk, rst, //Señales de reloj y reset del sistema
    input enable_leer, //Señal que proviene de la FSM
	 input [5:0]cont_lectura, //Señal del bloque Signal_Control_Lectura
    output  [7:0] bus_out_leer, //Bus de salida con la secuencia de los datos
	 output reg En_seg, En_min, En_hora, En_dia, En_mes, En_year, En_cr_seg, En_cr_min, En_cr_hora //Señales de habilitación 
	 //para los registros del Banco de Registros
    );
	 
reg [7:0] bus_out;
reg [3:0]cont_leer;

always @(posedge clk)
if (enable_leer==1'b1)begin //Si la señal de enable de la FSM se encuentra activa:
	if (rst)	cont_leer<=4'b0;
	else if (cont_leer==4'd0) begin
		if (cont_lectura==6'd7) bus_out<=8'hF0; // Se envia el comando de transferencia de datos F0
		else if (cont_lectura==6'd42) cont_leer<=cont_leer+4'd1; end 
		
	else if (cont_leer==4'd1) begin
		if (cont_lectura==6'd7) bus_out<=8'h20; // 1/100 sec
		else if (cont_lectura==6'd42) cont_leer<=cont_leer+4'd1; end 
		
	else if (cont_leer==4'd2) begin
		if (cont_lectura==6'd7) bus_out<=8'h21; // Se envia la Direccion seg
		else if (cont_lectura==6'd27) En_seg=1;
		else if (cont_lectura==6'd33) En_seg=0;
		else if (cont_lectura==6'd42) cont_leer<=cont_leer+4'd1; end 
	
	else if (cont_leer==4'd3) begin
		if (cont_lectura==6'd7) bus_out<=8'h22; //Se envia la Direccion min
		else if (cont_lectura==6'd27) En_min=1;
		else if (cont_lectura==6'd33) En_min=0;
		else if (cont_lectura==6'd42) cont_leer<=cont_leer+4'd1; end 
	
	else if (cont_leer==4'd4) begin
		if (cont_lectura==6'd7) bus_out<=8'h23; //Se envia la Direccion hora 
		else if (cont_lectura==6'd27) En_hora=1;
		else if (cont_lectura==6'd33) En_hora=0;
		else if (cont_lectura==6'd42) cont_leer<=cont_leer+4'd1; end
	
	else if (cont_leer==4'd5) begin
		if (cont_lectura==6'd7) bus_out<=8'h24; //Se envia la Direccion dia
		else if (cont_lectura==6'd27) En_dia=1;
		else if (cont_lectura==6'd33) En_dia=0;
		else if (cont_lectura==6'd42) cont_leer<=cont_leer+4'd1; end
	
	else if (cont_leer==4'd6) begin
		if (cont_lectura==6'd7) bus_out<=8'h25; //Se envia la Direccion mes
		else if (cont_lectura==6'd27) En_mes=1;
		else if (cont_lectura==6'd33) En_mes=0;
		else if (cont_lectura==6'd42) cont_leer<=cont_leer+4'd1; end
		
	else if (cont_leer==4'd7) begin
		if (cont_lectura==6'd7) bus_out<=8'h26; //Se envia la Direcciones year
		else if (cont_lectura==6'd27) En_year=1;
		else if (cont_lectura==6'd33) En_year=0;
		else if (cont_lectura==6'd42) cont_leer<=cont_leer+4'd1; end
		
	else if (cont_leer==4'd8) begin
		if (cont_lectura==6'd7) bus_out<=8'h41; //Se envia la Direcciones segundos crono
		else if (cont_lectura==6'd27) En_cr_seg=1;
		else if (cont_lectura==6'd33) En_cr_seg=0;
		else if (cont_lectura==6'd42) cont_leer<=cont_leer+4'd1; end

	else if (cont_leer==4'd9) begin
		if (cont_lectura==6'd7) bus_out<=8'h42; //Se envia la Direcciones minutos crono
		else if (cont_lectura==6'd27) En_cr_min=1;
		else if (cont_lectura==6'd33) En_cr_min=0;
		else if (cont_lectura==6'd42) cont_leer<=cont_leer+4'd1; end
		
	else if (cont_leer==4'd10) begin
		if (cont_lectura==6'd7) bus_out<=8'h43; //Se envia la Direcciones horas crono
		else if (cont_lectura==6'd27) En_cr_hora=1;
		else if (cont_lectura==6'd33) En_cr_hora=0;
		else if (cont_lectura==6'd42) begin cont_leer<=4'd0;end 
	
	end
	//Siempre que el contador llega a 42 significa que ha terminado la secuencia por lo que vuelve el contador a 0	

end
assign bus_out_leer=bus_out;
endmodule
