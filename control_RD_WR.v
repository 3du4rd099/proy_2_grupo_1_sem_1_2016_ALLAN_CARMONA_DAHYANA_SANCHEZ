`timescale 1ns / 1ps
// DEbido a que hay dos bloques de los cuales salen se�ales de control, es necesario elegir cuales se�ales enviar al RTC, 
//por esto este bloque se encarga de elegir entre las se�ales de control de lectura o de escritura

module control_RD_WR(
    input clk, enable_leer, enable_inicio, enable_escribir, listo_escribir,
    input CS_l, //\
    input RD_l, // \ Se�ales de control del bloque Signal_Control_Lectura
    input WR_l, // /
    input A_D_l,///
	 input CS_e, //\
    input RD_e, // \ Se�ales de control del bloque Signal_Control_escritura
    input WR_e, // /
    input A_D_e,///
    output reg CS, //\
    output reg RD, // \ Se�ales de salida dirigidas al RTC
    output reg WR, // /
    output reg A_D ///
    );

always @(posedge clk)
begin
	if (enable_inicio==1'b1 || enable_escribir==1'b1 || listo_escribir==1'b1) begin //Si alguna de las mismas se�ales que habilitan el
	//bloque de escritura se encuentra en 1; entondes las 4 salidas de control van a corresponde a las del proceso escritura
		CS<=CS_e;
		RD<=RD_e;
      WR<=WR_e;
      A_D<=A_D_e; end
	else if (enable_leer) begin //Si la se�al de enable_leer de la FSM se encuentra en 1; entondes las 4 salidas de control 
	//van a corresponde a las del proceso de lectura
		CS<=CS_l;
		RD<=RD_l;
      WR<=WR_l;
      A_D<=A_D_l; end
		
	else begin CS<=1'b1;RD<=1'b1;WR<=1'b1;A_D<=1'b1; end //De lo contrario todas las se�ales permanecer�n en estado 1
		
end

endmodule
