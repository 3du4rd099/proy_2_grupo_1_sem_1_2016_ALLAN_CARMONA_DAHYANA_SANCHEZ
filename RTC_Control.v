`timescale 1ns / 1ps
// En este bloque se encuentran instanciados todos los módulos que se contempan en el Control de RTC, 
module RTC_Control_Nuevo(
	//Entradas
    input clk,
    input Boton_reset,//    \
    input Boton_Aumento,//   \
    input Boton_Disminuye,//  \
    input Boton_Derecha,//     \
    input Boton_Izquierda,//   /Entradas desde los botones e interruptores de la nexys 4
    input sw_reloj,			// /
    input sw_fecha,		  // / 
    input sw_cronometro, // /
	 //Salida
    output [7:0] bus_out, //Bus de salida hacia el RTC
	 output CS,RD,WR,A_D,  //Señales d eControl hacia el RTC
	 output En_seg, En_min, En_hora, En_dia, En_mes, En_year, En_cr_seg, En_cr_min, En_cr_hora, am_pm, rst //Señales para activar los registros del
	 // banco de memoria.
    );
wire  aumento, disminuye, derecha, izquierda;
wire a_cr_hora, a_cr_min, a_cr_seg, a_hora, a_min, a_seg, a_dia, a_mes, a_year;
wire reset_cambio, cambio;
wire [7:0] bus_direccion;
wire [7:0] Bus_Direcciones_Datos;  // Para bus de tres estados
wire [7:0] dato_BCD;
wire [5:0]cont_escritura;	
wire listo_inicio, listo_escibir,/* listo_leer,*/ listo_guardar;
wire [5:0]cont_lectura;	
wire en_tri_l,en_tri_e;		
wire [7:0]bus_out_inicio, bus_out_escribir, bus_out_guardar, bus_out_leer;
wire CS_e, RD_e, WR_e, A_D_e;
wire CS_l, RD_l, WR_l, A_D_l;
wire enable_escribir_enable_inicio, enable_leer;
wire reset_listo_inicio,reset_listo_escribir, /*reset_listo_leer,*/ reset_listo_guardar;
	 
Bloques_metastabilidad Bloques_metastabilidad (
    .botton_aumento(Boton_Aumento), 
    .botton_disminuye(Boton_Disminuye), 
    .botton_derecha(Boton_Derecha), 
    .botton_izquierda(Boton_Izquierda), 
    .botton_reset(Boton_reset), 
    .clk(clk), 
    .aumento(aumento), 
    .disminuye(disminuye), 
    .derecha(derecha), 
    .izquierda(izquierda), 
    .rst(rst)
    );

//------------------------------------------------
FSM FSM (
    .listo_inicio(listo_inicio), 
    .listo_guardar(listo_guardar), 
    //.listo_leer(listo_leer), 
    .clk(clk), 
    .reset(rst), 
    .cambio(cambio), 
    .enable_inicio(enable_inicio), 
    .enable_escribir(enable_escribir), 
    .enable_leer(enable_leer), 
    .reset_cambio(reset_cambio), 
    .reset_li(reset_listo_inicio), 
    .reset_le(reset_listo_escribir), 
    //.reset_ll(reset_listo_leer), 
    .reset_lg(reset_listo_guardar)
    );	 
//--------------ESCRITURA-------------------------

Contadores_Escritura Contadores_Escritura1 (
    .clk(clk), 
    .rst(rst), 
    .botton_aumento(aumento), 
    .botton_disminuye(disminuye), 
    .botton_derecha(derecha), 
    .botton_izquierda(izquierda), 
    .sw_reloj(sw_reloj), 
    .sw_fecha(sw_fecha), 
    .sw_cronometro(sw_cronometro), 
    .a_hora(a_hora), 
    .a_min(a_min), 
    .a_seg(a_seg), 
    .am_pm(am_pm), 
    .a_dia(a_dia), 
    .a_mes(a_mes), 
    .a_year(a_year), 
    .a_cr_hora(a_cr_hora), 
    .a_cr_min(a_cr_min), 
    .a_cr_seg(a_cr_seg), 
    .dato_escritura(dato_BCD)
    );

 /*Contadores_Escritura Contadores_Escritura (
    .clk(clk), 
    .rst(rst), 
    .botton_aumento(aumento), 
    .botton_disminuye(disminuye), 
    .botton_derecha(derecha), 
    .botton_izquierda(izquierda), 
    .sw_reloj(sw_reloj), 
    .sw_fecha(sw_fecha), 
    .sw_cronometro(sw_cronometro), 
    .a_hora(a_hora), 
    .a_min(a_min), 
    .a_seg(a_seg), 
    .am_pm(am_pm), 
    .a_dia(a_dia), 
    .a_mes(a_mes), 
    .a_year(a_year), 
    .a_cr_hora(a_cr_hora), 
    .a_cr_min(a_cr_min), 
    .a_cr_seg(a_cr_seg), 
    .dato_escritura(dato_BCD)
    );
*/
cambio_escritura cambio_escritura (
    .clk(clk), 
    .rst(rst), 
    .reset_cambio(reset_cambio), 
    .aumentar(aumento), 
    .disminuir(disminuye), 
    .cambio(cambio)
    );	
	 
Signal_Control_Escritura Signal_Control_Escritura (
    .clk(clk), 
    .rst(rst), 
    .enable_inicio(enable_inicio), 
    .enable_escribir(enable_escribir), 
    .listo_escribir(listo_escribir), 
    .cont_escritura(cont_escritura), 
	 .en_tri(en_tri_e),
    .CS_e(CS_e), 
    .RD_e(RD_e), 
    .WR_e(WR_e), 
    .A_D_e(A_D_e)
    );	 
Direccion_Escritura Direccion_Escritura (
    .clk(clk), 
    .a_hora(a_hora), 
    .a_min(a_min), 
    .a_seg(a_seg), 
    .a_dia(a_dia), 
    .a_mes(a_mes), 
    .a_year(a_year), 
    .a_cr_hora(a_cr_hora), 
    .a_cr_min(a_cr_min), 
    .a_cr_seg(a_cr_seg), 
    .direccion(bus_direccion)
    );

Control_Escritura Control_Escritura (
    .clk(clk), 
    .enable_escribir(enable_escribir), 
    .cont_escritura(cont_escritura), 
    .dato_escritura(dato_BCD), 
    .direccion(bus_direccion),
	 .reset_listo_escritura(reset_listo_escribir),
    .listo_escribir(listo_escribir), 
    .bus_out_escribir(bus_out_escribir)
     );
	 
Guardar_RTC Guardar_RTC (
    .clk(clk), 
    .listo_escritura(listo_escribir), 
    .cont_escritura(cont_escritura),
	 .reset_listo_guardar(reset_listo_guardar),
    .bus_out_guardar(bus_out_guardar), 
    .listo_guardar(listo_guardar)
    );

Inicializar Inicializar (
    .clk(clk), 
    .enable_inicio(enable_inicio), 
    .cont_escritura(cont_escritura),
	 .reset_listo_inicio(reset_listo_inicio),
    .bus_out_inicio(bus_out_inicio), 
    .listo_inicio(listo_inicio)
    );

//---------Leer--------------------------------

Signal_Control_Lectura Signal_Control_Lectura (
    .clk(clk), 
    .rst(rst), 
    .enable_leer(enable_leer), 
    .CS_l(CS_l), 
    .RD_l(RD_l), 
    .WR_l(WR_l), 
    .A_D_l(A_D_l), 
    .cont_lectura(cont_lectura),
	 .en_tri(en_tri_l)
    );

Secuencia_leer Secuencia_leer (
    .clk(clk), 
    .rst(rst), 
    .enable_leer(enable_leer), 
    .cont_lectura(cont_lectura), 
	 //.reset_listo_leer(reset_listo_leer), 
    //.listo_leer(listo_leer), 
    .bus_out_leer(bus_out_leer),  
    .En_seg(En_seg), 
    .En_min(En_min), 
    .En_hora(En_hora), 
    .En_dia(En_dia), 
    .En_mes(En_mes), 
    .En_year(En_year), 
    .En_cr_seg(En_cr_seg), 
    .En_cr_min(En_cr_min), 
    .En_cr_hora(En_cr_hora)
    );
 
control_RD_WR control_RD_WR (
    .clk(clk), 
    .enable_leer(enable_leer), 
    .listo_escribir(listo_escribir), 
    .enable_inicio(enable_inicio), 
    .enable_escribir(enable_escribir), 
    .CS_l(CS_l), 
    .RD_l(RD_l), 
    .WR_l(WR_l), 
    .A_D_l(A_D_l), 
    .CS_e(CS_e), 
    .RD_e(RD_e), 
    .WR_e(WR_e), 
    .A_D_e(A_D_e), 
    .CS(CS), 
    .RD(RD), 
    .WR(WR), 
    .A_D(A_D)
    ); 
//---------------------------------------------
Selector_bus_out Selector_bus_out (
    .clk(clk), 
    .enable_inicio(enable_inicio), 
    .enable_leer(enable_leer), 
    .enable_escribir(enable_escribir), 
    .listo_escribir(listo_escribir), 
    .bus_out_inicio(bus_out_inicio), 
    .bus_out_escribir(bus_out_escribir), 
    .bus_out_guardar(bus_out_guardar), 
    .bus_out_leer(bus_out_leer), 
    .Bus_Direcciones_Datos(Bus_Direcciones_Datos)
    );
	 
Tristate_bus Tristate_bus (
    .en_tri_e(en_tri_e),
    .en_tri_l(en_tri_l),	 
    .bus_out(Bus_Direcciones_Datos), 
    .Bus_datos(bus_out)
    );
endmodule
