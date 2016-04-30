`timescale 1ns / 1ps
//Este bloque detecta si se presionan algunos de los botones de aumento o disminuye, en caso de que alguna este activa
//activar� el proceso de escritura, de lo contrario permanecer� en el proceso de lectura
 module cambio_escritura(
	 input wire clk, rst,
	 input wire reset_cambio, //Se�al que proviene de la m�quina de estados
    input wire aumentar, //Se�ales despues de los bloques de metastabilidad
    input wire disminuir,//
    output reg cambio // hacia la FSM
    );
 
 initial begin 
 cambio <=0;
 end
 
 always@(posedge clk) begin
 if (aumentar ||disminuir) begin
 cambio<=1;
 end else begin 
 if(reset_cambio || rst)begin
 cambio<=0;
 end
 end
 
 end

endmodule
