`timescale 1ns / 1ps

module Cont_ajuste_crono( 
    input clk,
    input rst,
	 input sw_hora, input sw_fecha, input sw_cronometro,
    input parametro_der,
    input parametro_izq,
 	 output reg a_cr_hora, a_cr_min, a_cr_seg,
    output reg [1:0] parametro_crono// 2 bits para elegir entre hora, minutos y segundos
    );
initial begin  a_cr_hora=1'b0; a_cr_min=1'b0; a_cr_seg=1'b0; end

  // variables para mitigar el rebote

 always @(posedge clk /*or posedge rst*/)   //se cummple cuando hay un flanco positivo en el clk y el rst
 begin
	if (rst || parametro_crono==2'd3 )
		 parametro_crono <= 2'b0;    // si reset esta activo pone la salida en 1  
	else if (sw_cronometro==1 && sw_fecha==0 && sw_hora==0)begin
		if (parametro_der ) begin //condicion que se cumple si se aumenta cuenta y no hay un dato previamente guardado del pulsador para evitar rebote 
			 parametro_crono <= parametro_crono + 2'b1; //aumenta cuenta
			  end   //guarda para el antirrebote
		else if (parametro_izq ) begin   //condicion que se cumple si se disminuye cuenta y no hay un dato previamente guardado del pulsador para evitar rebote 
			 parametro_crono <= parametro_crono - 2'b1;      //se disminuye cuenta
			  end        //guarda para el antirrebote
		else begin

			 parametro_crono <= parametro_crono; end
if (parametro_crono==2'd0) a_cr_hora <=1'b1; else a_cr_hora <=1'b0;
if (parametro_crono==2'd1) a_cr_min <=1'b1; else a_cr_min <=1'b0;
if (parametro_crono==2'd2) a_cr_seg <=1'b1; else a_cr_seg <=1'b0;  end
else begin a_cr_hora <=1'b0; a_cr_min <=1'b0; a_cr_seg <=1'b0; parametro_crono <= parametro_crono; end end
endmodule 
