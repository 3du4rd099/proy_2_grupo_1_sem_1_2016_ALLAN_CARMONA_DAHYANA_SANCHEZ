`timescale 1ns / 1ps

module Ajuste_cronometro(
	 input wire clk,
    input wire rst,
    input wire sw_hora,input wire sw_fecha,input wire sw_cronometro,
	 input wire aumento, disminuye, par_der, par_izq,
	 output [3:0]crono_hora, 
	 output[5:0] crono_min, 
	 output [5:0]crono_seg,
	 output a_cr_hora, a_cr_min, a_cr_seg 
    );
	 
wire [1:0] EN;
Cont_ajuste_crono Cont_ajuste_crono (
    .clk(clk), 
    .rst(rst), 
    .sw_hora(sw_hora), 
    .sw_fecha(sw_fecha), 
    .sw_cronometro(sw_cronometro), 
    .parametro_der(par_der), 
    .parametro_izq(par_izq),
	 .a_cr_hora(a_cr_hora),	
	 .a_cr_min(a_cr_min),
	 .a_cr_seg(a_cr_seg),
    .parametro_crono(EN)
    );	 
Cronometro_hora Cronometro_hora (
    .clk(clk), 
    .rst(rst), 
    .EN(EN), 
    .aumento(aumento), 
    .disminuye(disminuye), 
    .crono_hora(crono_hora)	 
    );
	
Cronometro_min Cronometro_min (
    .clk(clk), 
    .rst(rst), 
    .EN(EN), 
    .aumento(aumento), 
    .disminuye(disminuye), 
    .crono_min(crono_min)
	  );

Cronometro_seg Cronometro_seg (
    .clk(clk), 
    .rst(rst), 
    .EN(EN), 
    .aumento(aumento), 
    .disminuye(disminuye), 
    .crono_seg(crono_seg)	 
    );
endmodule
