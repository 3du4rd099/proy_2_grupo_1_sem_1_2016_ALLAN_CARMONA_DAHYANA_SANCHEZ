`timescale 1ns / 1ps
//Este bloque presenta el mismo funcionamiento del bloque Contador_min, con la diferencia que para activar este contador se 
// requiere que la salida del Cont_ajuste_hora se encuentre en la tercera posicion.
module Contador_seg(
    input clk,
    input rst,
	 input [1:0]EN,
    input aumento,
    input disminuye,
    output reg [5:0] cont_seg
	 //output reg a_seg
    );



always @(posedge clk /*or posedge rst*/)
begin
 if (rst || cont_seg==6'd60)
		cont_seg<=6'b0;
 else if (EN==2'd2) begin
		//a_seg<=1;
	if (aumento) begin
			cont_seg<=cont_seg + 6'b1;
			 end
	else if (disminuye) begin
		if (cont_seg==6'd0) cont_seg<=6'd0;
		else begin
			cont_seg<=cont_seg - 6'b1;
			 end end
	else begin
		
		cont_seg <= cont_seg;	
		//a_seg<=0; 
		end
	end
end
endmodule 
