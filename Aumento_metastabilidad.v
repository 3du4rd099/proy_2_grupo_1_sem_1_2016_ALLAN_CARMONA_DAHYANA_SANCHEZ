`timescale 1ns / 1ps

module Aumento_metastabilidad(//modulo para evitar los efectos del rebote del pulsador
    input botton_aumentar,			    //Declaracion de entradas y salidas
    input clk,			    //el modulo consiste en flipflops tipo D en cascada
	 output aumentar
    );

//Se utilizan 5 registros para filtrar la señal de pulso de los botones
reg FF_1;
reg FF_2;
reg FF_3;
reg FF_4;
reg FF_5;

always @(posedge clk)
begin
	FF_1<=botton_aumentar;
	FF_2<=FF_1;
	FF_3<=FF_2;
	FF_4<=FF_3;
	FF_5<=FF_4; //En conexion en cascada se colocan los biestables, es decir los valores de las salidas dependen del valor 
	//que tenga la entrada
end

assign aumentar = FF_1 & FF_2 & FF_3 & FF_4 & FF_5 &!botton_aumentar; //Para activar la señal en alto es necesario que todos los 
// flipflips se encuentren en 1 y que el boton de aumento ya no esté presionado, de esta manera se asegura un dato estable.

endmodule
