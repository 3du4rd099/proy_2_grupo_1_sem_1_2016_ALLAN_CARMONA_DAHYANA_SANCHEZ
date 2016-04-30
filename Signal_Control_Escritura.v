`timescale 1ns / 1ps
//Este bloque genera la secuencia de las se�ales de control de escritura de manera que si se va a escribir la direcci�n
// se activa primero la se�al de A/D, luego CS y luego WR, la se�al de RD permanece en alto en este proceso
module Signal_Control_Escritura(
    input clk,
    input rst,
	 input  enable_inicio, enable_escribir, listo_escribir, //Se�ales que entran de la m�quina de estados y del bloque de control escritura
	 output [5:0]cont_escritura, //Se�al de salida con el valor del contador encargado de generar la secuencia de las se�ales
	 output reg en_tri, //Se�al para activar el buffer
	 output reg CS_e, //
    output reg RD_e, //Se�ales de Control del RTC
    output reg WR_e, //
    output reg A_D_e //
    );
	  
reg [5:0] cont=6'b0; 

always @ (posedge clk) //se cummple cuando hay un flanco positivo en el clk 
begin
if (enable_inicio==1'b1 || enable_escribir==1'b1 || listo_escribir==1'b1)begin //Si alguna de estas se�ales est� en alto
	if (rst || cont==42) cont<=6'd0;
	else begin 
		cont<=cont+5'b1; 
		 if (cont==6'd1||cont==6'd11)	begin //Definicion del orden de las se�ales de control dependiendo del valor del cont_escritura
			CS_e<=1'b1;RD_e<=1'b1;WR_e<=1'b1;A_D_e<=1'b0;	end
		else if (cont==6'd2||cont==6'd10)	begin 
			CS_e<=1'b0;RD_e<=1'b1;WR_e<=1'b1;A_D_e<=1'b0; end
		else if (cont==6'd3||cont==6'd4||cont==6'd5||cont==6'd6||cont==6'd8||cont==6'd9)	begin 
			CS_e<=1'b0; RD_e<=1'b1; WR_e<=1'b0;	A_D_e<=1'b0;	end
		else if (cont==6'd7) begin CS_e<=1'b0; RD_e<=1'b1; WR_e<=1'b0;	A_D_e<=1'b0;	en_tri<=1'b1;end
		else if (cont==6'd29) begin CS_e<=1'b0; RD_e<=1'b1; WR_e<=1'b0;	A_D_e<=1'b1;	en_tri<=1'b1;end
		else if (cont==6'd13||cont==6'd34) begin CS_e<=1'b1; RD_e<=1'b1; WR_e<=1'b1;	A_D_e<=1'b1;	en_tri<=1'b0;end
		else if (cont==6'd24||cont==6'd32)begin
			 CS_e<=1'b0;RD_e<=1'b1;WR_e<=1'b1;A_D_e<=1'b1;   end 
		else if (cont==6'd25||cont==6'd26||cont==6'd27||cont==6'd28||cont==6'd30||cont==6'd31)begin
			 CS_e<=1'b0;RD_e<=1'b1;WR_e<=1'b0;A_D_e<=1'b1;end 
		else begin 
			CS_e<=1'b1;RD_e<=1'b1;WR_e<=1'b1;A_D_e<=1'b1;/* enable_tri_state<=1'b0;*/end
		end
	end
		else begin 
			CS_e<=1'b1;RD_e<=1'b1;WR_e<=1'b1;A_D_e<=1'b1;/* enable_tri_state<=1'b0;*/end 
end

assign cont_escritura= cont; 
endmodule
