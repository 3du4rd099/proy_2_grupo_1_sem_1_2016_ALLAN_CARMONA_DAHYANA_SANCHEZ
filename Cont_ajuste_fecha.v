`timescale 1ns / 1ps

module Cont_ajuste_fecha( 
    input clk,
    input rst,
	 input sw_hora, input sw_fecha, input sw_cronometro,
    input parametro_der,
    input parametro_izq,
	 output reg a_dia, a_mes, a_year,
    output reg [1:0] parametro_fecha// 2 bits para elegir entre hora, minutos y segundos
    );
initial begin  a_dia=1'b0; a_mes=1'b0; a_year=1'b0; end



 always @(posedge clk /*or posedge rst*/)   //se cummple cuando hay un flanco positivo en el clk y el rst
 begin
	if (rst || parametro_fecha==2'd3 )
		 parametro_fecha <= 2'b0;    // si reset esta activo pone la salida en 1  
	else if (sw_fecha==1 && sw_hora==0 && sw_cronometro==0)begin
		if (parametro_der ) begin //condicion que se cumple si se aumenta cuenta y no hay un dato previamente guardado del pulsador para evitar rebote 
			 parametro_fecha <= parametro_fecha + 2'b1; //aumenta cuenta
			  end   //guarda para el antirrebote
		else if (parametro_izq ) begin   //condicion que se cumple si se disminuye cuenta y no hay un dato previamente guardado del pulsador para evitar rebote 
			 parametro_fecha <= parametro_fecha - 2'b1;      //se disminuye cuenta
			  end        //guarda para el antirrebote
		else begin

			 parametro_fecha <= parametro_fecha; end
if (parametro_fecha==2'd0) a_dia <=1'b1; else a_dia <=1'b0;
if (parametro_fecha==2'd1) a_mes <=1'b1; else a_mes <=1'b0;
if (parametro_fecha==2'd2) a_year <=1'b1; else a_year <=1'b0;  end
else begin a_dia <=1'b0; a_mes <=1'b0; a_year <=1'b0; parametro_fecha <= parametro_fecha; end end
endmodule 
