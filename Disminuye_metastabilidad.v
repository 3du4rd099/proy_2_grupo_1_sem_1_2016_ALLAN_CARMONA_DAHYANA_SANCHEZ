`timescale 1ns / 1ps

module Disminuye_metastabilidad(//modulo para evitar los efectos del rebote del pulsador
    input botton_disminuir,			    //Declaracion de entradas y salidas
    input clk,			    //el modulo consiste en flipflops tipo D en cascada
	 output disminuir
    );

reg FF_1;
reg FF_2;
reg FF_3;
reg FF_4;
reg FF_5;

always @(posedge clk)
begin
	FF_1<=botton_disminuir;
	FF_2<=FF_1;
	FF_3<=FF_2;
	FF_4<=FF_3;
	FF_5<=FF_4;
end

assign disminuir = FF_1 & FF_2 & FF_3 & FF_4 & FF_5 & !botton_disminuir; 

endmodule
