`timescale 1ns / 1ps

module Contador_mes(    //declaracion de entradas y salidas
	 input clk,				 //clock
	 input rst,				 //reset
	 input [1:0]EN,
    input aumento,	    //boton aumento cuenta
    input disminuye,	 //boton dismuye cuenta
    output reg [3:0] cont_mes //salida del contador de 3bits 
	 //output reg a_mes
	);


 always @(posedge clk /*or posedge rst*/)   //se cummple cuando hay un flanco positivo en el clk y el rst
 begin
	 if (rst || cont_mes==4'd12)
		cont_mes <= 4'b0;    // si reset esta activo pone la salida en 1  
	 else  if (EN==2'd1) begin
		 //a_mes<=1;
		 if (aumento ) begin//condicion que se cumple si se aumenta cuenta y no hay un dato previamente guardado del pulsador para evitar rebote 
				cont_mes <= cont_mes + 4'b1; //aumenta cuenta
				 end   //guarda para el antirrebote
		else if (disminuye ) begin //condicion que se cumple si se disminuye cuenta y no hay un dato previamente guardado del pulsador para evitar rebote 
			if (cont_mes==4'd0) cont_mes<=0;
			else begin
				cont_mes <= cont_mes - 4'b1;      //se disminuye cuenta
				  end   end     //guarda para el antirrebote
		else	begin

				cont_mes <= cont_mes;	
				//a_mes<=0; 
				end
	end
end
	
endmodule 