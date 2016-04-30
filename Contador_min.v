`timescale 1ns / 1ps
// Este bloque configura el valor de minutos, recibe la señal de enable cuando el contador _ajuste_hora se 
// encuentra en la segunda posición
module Contador_min(
    input clk,
    input rst,
	 input [1:0]EN,
    input aumento,
    input disminuye,
    output reg [5:0] cont_min //salida del contador de 6 bits para contar de 0 a 60 
    );
//Para aumentar o disminuir las cuentas, tiene el mismo funcionamiento que el bloque Contador_hora

always @(posedge clk)
begin
 	if (rst || cont_min==6'd60)
		cont_min<=6'b0;
	else if (EN==2'd1) begin
		if (aumento) begin
			cont_min<=cont_min + 6'b1;
			 end
		else if (disminuye) begin
			if (cont_min==6'b0) cont_min<=0;
			else begin
				cont_min<=cont_min - 6'b1;
				 end end
		else begin

			cont_min <= cont_min;	
			end
	end
end
endmodule 