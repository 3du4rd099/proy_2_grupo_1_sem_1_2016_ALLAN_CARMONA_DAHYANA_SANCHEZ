`timescale 1ns / 1ps

module Cronometro_hora(    //declaracion de entradas y salidas
	 input clk,				 //clock
	 input rst,				 //reset
	 input [1:0]EN,		 //Proviene del contador de ajuste para elegir entre hr, min,seg
    input aumento,	    //boton aumento cuenta
    input disminuye,	 //boton dismuye cuenta
    output reg [3:0] crono_hora //salida del contador de 3bits 
	 //output reg a_cr_hora 
	 );

 always @(posedge clk /*or posedge rst*/)   //se cummple cuando hay un flanco positivo en el clk y el rst
 begin
	 if (rst || crono_hora==4'd12)
		crono_hora <= 4'b0;    // si reset esta activo pone la salida en 1  
	 else  if (EN==2'd0) begin
		 //a_cr_hora<=1;
		 if (aumento ) begin//condicion que se cumple si se aumenta cuenta y no hay un dato previamente guardado del pulsador para evitar rebote 
				crono_hora <= crono_hora + 4'b1; //aumenta cuenta
				  end   //guarda para el antirrebote
		else if (disminuye ) begin //condicion que se cumple si se disminuye cuenta y no hay un dato previamente guardado del pulsador para evitar rebote 
			if (crono_hora==4'd0) crono_hora<=0;
			else begin
				crono_hora <= crono_hora - 4'b1;      //se disminuye cuenta
				  end  end      //guarda para el antirrebote
		else	begin

				crono_hora <= crono_hora;	
				//a_cr_hora<=0; 
				end
	end
end
	
endmodule 