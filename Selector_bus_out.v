`timescale 1ns / 1ps
//Al igual que con el bloque control_RD_WR, hay varios bloques que utilizan el bus de salida de los datos, por lo que es necesario elegir
//cual de todos será el que le envíe el dato al RTC
module Selector_bus_out(
	 input clk,
    input enable_inicio, enable_leer, enable_escribir, listo_escribir, //Señales desde la FSM y del bloque Control_Escritura
    input [7:0] bus_out_inicio, bus_out_escribir, bus_out_guardar, bus_out_leer, //Buses de salida de los diferentes bloques
	 output reg [7:0]Bus_Direcciones_Datos //Bus de datos de salida dirigido hacia el RTC
    );

always @(posedge clk)
begin
	if (enable_inicio==1'b1) //Si de la FSM el enable de inicio está activo, entonces el bus de salida sera el de inicio, de igual
	// manera para los demás buses de salida
		Bus_Direcciones_Datos<=bus_out_inicio;
	else  if (enable_leer==1'b1)
		Bus_Direcciones_Datos<=bus_out_leer;
	else if (enable_escribir==1'b1)
		Bus_Direcciones_Datos<=bus_out_escribir;
	else if (listo_escribir==1'b1)
		Bus_Direcciones_Datos<=bus_out_guardar;
	else Bus_Direcciones_Datos<=Bus_Direcciones_Datos;
	
	
	
end

endmodule
