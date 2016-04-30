`timescale 1ns / 1ps

//Este bloque genera la secuencia de las señales de control de lectura de manera que se envía primero la 
//dirección y luego se da la señal para leer.

module Signal_Control_Lectura(   
input clk, rst,
input enable_leer, //Señal que entra de la FSM.
output reg CS_l, RD_l, WR_l, A_D_l, //Señales de Control del RTC.
output [5:0]cont_lectura, //Señal de salida con el valor del contador encargado de generar la secuencia de las señales.
output reg en_tri //Señal para activar el buffer
);

reg [5:0] cont=6'b0;
always @ (posedge clk)
begin
	if(enable_leer==1)begin //Si de la FSM llega la señal de habilitar el proceso de Lectura entonces:
	if (rst||cont==6'd42) cont<=6'd0;
		else begin// Definicion del orden de las señales de control dependiendo del valor del cont_lectura
		cont<=cont+5'b1;if (cont==6'd1||cont==6'd11) begin//
		CS_l<=1'b1; RD_l<=1'b1; WR_l<=1'b1; A_D_l<=1'b0; end//
		else if (cont==6'd2||cont==6'd10) begin//
		CS_l<=1'b0; RD_l<=1'b1; WR_l<=1'b1; A_D_l<=1'b0; end//
		else if (cont==6'd3||cont==6'd4||cont==6'd5||cont==6'd6||cont==6'd8||cont==6'd9) begin//
		CS_l<=1'b0; RD_l<=1'b1; WR_l<=1'b0; A_D_l<=1'b0; end//
		else if (cont==6'd7) begin CS_l<=1'b0; RD_l<=1'b1; WR_l<=1'b0; A_D_l<=1'b0; en_tri<=1'b1;end //Cuando el contador vaya por 7
	//Se habilita el bus de salida con la dirección a escribir.
		else if (cont==6'd13) begin CS_l<=1'b1; RD_l<=1'b1; WR_l<=1'b1; A_D_l<=1'b1; en_tri<=1'b0;end //Cuando el contador vaya por 13
	//se deshabilita  el bus de salida
		else if (cont==6'd24||cont==6'd32) begin//
		CS_l<=1'b0; RD_l<=1'b1; WR_l<=1'b1; A_D_l<=1'b1; end//
		else if (cont==6'd25||cont==6'd26||cont==6'd27||cont==6'd28||cont==6'd29||cont==6'd30||cont==6'd31) begin//
		CS_l<=1'b0; RD_l<=1'b0; WR_l<=1'b1; A_D_l<=1'b1; end//
		else begin// //Si no cumple ninguna de las condiciones, entonces todas las señales permanecerán en alto y la señal de activar el bus permanecerá en bajo
		CS_l<=1'b1; RD_l<=1'b1; WR_l<=1'b1; A_D_l<=1'b1; en_tri<=1'b0; end//
		end//
		end
	else  begin
	CS_l<=1'b1; RD_l<=1'b1; WR_l<=1'b1; A_D_l<=1'b1; en_tri<=1'b0; end//
	
	end	
	

assign cont_lectura=cont;
endmodule 