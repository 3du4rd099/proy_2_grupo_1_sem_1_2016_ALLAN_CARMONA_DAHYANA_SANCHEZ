`timescale 1ns / 1ps
//Este bloque decodificador o memoria recibe la salida de todos los contadores de hora, min, seg, dia, mes, year, y los de cronómetro
//De manera que dependiendo del valor que éstos sacan el dato es transformado a hexadecimal para que el dato este listo para enviarlo por el bus de salida
module Decodificador_Escritura(
	 input clk, 
	 input wire [3:0] cont_hora, 
	 input wire [5:0] cont_min, 
	 input wire [5:0] cont_seg,
	 input wire [4:0] cont_dia, 
	 input wire [3:0] cont_mes, 
	 input wire [6:0] cont_year,
	 input wire [3:0] crono_hora, 
	 input wire [5:0] crono_min, 
	 input wire [5:0] crono_seg,
	 input wire am_pm,
	 input wire a_hora, a_min, a_seg, a_dia, a_mes, a_year, a_cr_hora, a_cr_min, a_cr_seg,
	 output reg[7:0] dato_BCD
    );
	 
	 initial begin 
	 	 dato_BCD<=0;
	 	 end
	 
always @(posedge clk) begin //Siempre en un ciclo positivo de reloj
	if (a_hora==1'b1)begin //si el Cont_ajuste_hora se encuentra en la primera posicion activa la señal a_hora, por lo que
	//el dato en la salida del deco corresponde al dato en hexadecimal de hora
		case(cont_hora) // Cuando se manda el dato de hora, el bit 8 corresponde al formato de am/pm
			0 : begin dato_BCD <=7'h00; dato_BCD[7]<=am_pm; end //El bit 8 del dato de salida corresponde al formato de hora, por lo que se envía por separado
 			1 : begin dato_BCD <=7'h01; dato_BCD[7]<=am_pm; end
			2 : begin dato_BCD <=7'h02; dato_BCD[7]<=am_pm; end
			3 : begin dato_BCD <=7'h03; dato_BCD[7]<=am_pm; end
			4 : begin dato_BCD <=7'h04; dato_BCD[7]<=am_pm; end
			5 : begin dato_BCD <=7'h05; dato_BCD[7]<=am_pm; end
			6 : begin dato_BCD <=7'h06; dato_BCD[7]<=am_pm; end
			7 : begin dato_BCD <=7'h07; dato_BCD[7]<=am_pm; end
			8 : begin dato_BCD <=7'h08; dato_BCD[7]<=am_pm; end
			9 : begin dato_BCD <=7'h09; dato_BCD[7]<=am_pm; end
			10 : begin dato_BCD <=7'h10; dato_BCD[7]<=am_pm; end
			11 : begin dato_BCD <=7'h11; dato_BCD[7]<=am_pm; end
			12 : begin dato_BCD <=7'h12; dato_BCD[7]<=am_pm; end
			default: dato_BCD <=8'h00;
		endcase end
	else if (a_dia==1'b1)begin //si el Cont_ajuste_fecha se encuentra en la primera posicion activa la señal a_dia, por lo que
	//el dato en la salida del deco corresponde al dato en hexadecimal de dia
		case (cont_dia) 
			0 : dato_BCD <=8'h00;
 			1 : dato_BCD <=8'h01;
			2 : dato_BCD <=8'h02;
			3 : dato_BCD <=8'h03;
			4 : dato_BCD <=8'h04;
			5 : dato_BCD <=8'h05;
			6 : dato_BCD <=8'h06;
			7 : dato_BCD <=8'h07;
			8 : dato_BCD <=8'h08;
			9 : dato_BCD <=8'h09;
			10 : dato_BCD <=8'h10;
			11 : dato_BCD <=8'h11;
			12 : dato_BCD <=8'h12;
			13 : dato_BCD <=8'h13;
 			14 : dato_BCD <=8'h14;
			15 : dato_BCD <=8'h15;
			16 : dato_BCD <=8'h16;
			17 : dato_BCD <=8'h17;
			18 : dato_BCD <=8'h18;
			19 : dato_BCD <=8'h19;
			20 : dato_BCD <=8'h20;
			21 : dato_BCD <=8'h21;
			22 : dato_BCD <=8'h22;
			23 : dato_BCD <=8'h23;
 			24 : dato_BCD <=8'h24;
			25 : dato_BCD <=8'h25;
			26 : dato_BCD <=8'h26;
			27 : dato_BCD <=8'h27;
			28 : dato_BCD <=8'h28;
			29 : dato_BCD <=8'h29;
			30 : dato_BCD <=8'h30;
			31 : dato_BCD <=8'h31;
			default: dato_BCD <=8'h00;
		endcase end
	else if (a_mes==1'b1)begin//si el Cont_ajuste_fecha se encuentra en la segunda posicion activa la señal a_mes, por lo que
	//el dato en la salida del deco corresponde al dato en hexadecimal de mes
		case (cont_mes)
			0 : dato_BCD <=8'h00;
 			1 : dato_BCD <=8'h01;
			2 : dato_BCD <=8'h02;
			3 : dato_BCD <=8'h03;
			4 : dato_BCD <=8'h04;
			5 : dato_BCD <=8'h05;
			6 : dato_BCD <=8'h06;
			7 : dato_BCD <=8'h07;
			8 : dato_BCD <=8'h08;
			9 : dato_BCD <=8'h09;
			10 : dato_BCD <=8'h10;
			11 : dato_BCD <=8'h11;
			12 : dato_BCD <=8'h12;
			default: dato_BCD <=8'h00;
		endcase end
	else if (a_year==1'b1)begin //si el Cont_ajuste_fecha se encuentra en la tercera posicion activa la señal a_year, por lo que
	//el dato en la salida del deco corresponde al dato en hexadecimal de año
		case (cont_year)  
			0 : dato_BCD <=8'h00;
 			1 : dato_BCD <=8'h01;
			2 : dato_BCD <=8'h02;
			3 : dato_BCD <=8'h03;
			4 : dato_BCD <=8'h04;
			5 : dato_BCD <=8'h05;
			6 : dato_BCD <=8'h06;
			7 : dato_BCD <=8'h07;
			8 : dato_BCD <=8'h08;
			9 : dato_BCD <=8'h09;
			10 : dato_BCD <=8'h10;
			11 : dato_BCD <=8'h11;
			12 : dato_BCD <=8'h12;
			13 : dato_BCD <=8'h13;
 			14 : dato_BCD <=8'h14;
			15 : dato_BCD <=8'h15;
			16 : dato_BCD <=8'h16;
			17 : dato_BCD <=8'h17;
			18 : dato_BCD <=8'h18;
			19 : dato_BCD <=8'h19;
			20 : dato_BCD <=8'h20;
			21 : dato_BCD <=8'h21;
			22 : dato_BCD <=8'h22;
			23 : dato_BCD <=8'h23;
 			24 : dato_BCD <=8'h24;
			25 : dato_BCD <=8'h25;
			26 : dato_BCD <=8'h26;
			27 : dato_BCD <=8'h27;
			28 : dato_BCD <=8'h28;
			29 : dato_BCD <=8'h29;
			30 : dato_BCD <=8'h30;
			31 : dato_BCD <=8'h31;
			32 : dato_BCD <=8'h32;
			33 : dato_BCD <=8'h33;
 			34 : dato_BCD <=8'h34;
			35 : dato_BCD <=8'h35;
			36 : dato_BCD <=8'h36;
			37 : dato_BCD <=8'h37;
			38 : dato_BCD <=8'h38;
			39 : dato_BCD <=8'h39;
			40 : dato_BCD <=8'h40;
			41 : dato_BCD <=8'h41;
			42 : dato_BCD <=8'h42;
			43 : dato_BCD <=8'h43;
 			44 : dato_BCD <=8'h44;
			45 : dato_BCD <=8'h45;
			46 : dato_BCD <=8'h46;
			47 : dato_BCD <=8'h47;
			48 : dato_BCD <=8'h48;
			49 : dato_BCD <=8'h49;
			50 : dato_BCD <=8'h50;
			51 : dato_BCD <=8'h51;
			52 : dato_BCD <=8'h52;
			53 : dato_BCD <=8'h53;
 			54 : dato_BCD <=8'h54;
			55 : dato_BCD <=8'h55;
			56 : dato_BCD <=8'h56;
			57 : dato_BCD <=8'h57;
			58 : dato_BCD <=8'h58;
			59 : dato_BCD <=8'h59;
			60 : dato_BCD <=8'h60;
 			61 : dato_BCD <=8'h61;
			62 : dato_BCD <=8'h62;
			63 : dato_BCD <=8'h63;
			64 : dato_BCD <=8'h64;
			65 : dato_BCD <=8'h65;
			66 : dato_BCD <=8'h66;
			67 : dato_BCD <=8'h67;
			68 : dato_BCD <=8'h68;
			69 : dato_BCD <=8'h69;
			70 : dato_BCD <=8'h70;
			71 : dato_BCD <=8'h71;
			72 : dato_BCD <=8'h72;
			73 : dato_BCD <=8'h73;
 			74 : dato_BCD <=8'h74;
			75 : dato_BCD <=8'h75;
			76 : dato_BCD <=8'h76;
			77 : dato_BCD <=8'h77;
			78 : dato_BCD <=8'h78;
			79 : dato_BCD <=8'h79;
			80 : dato_BCD <=8'h80;
			81 : dato_BCD <=8'h81;
			82 : dato_BCD <=8'h82;
			83 : dato_BCD <=8'h83;
 			84 : dato_BCD <=8'h84;
			85 : dato_BCD <=8'h85;
			86 : dato_BCD <=8'h86;
			87 : dato_BCD <=8'h87;
			88 : dato_BCD <=8'h88;
			89 : dato_BCD <=8'h89;
			90 : dato_BCD <=8'h90;
			91 : dato_BCD <=8'h91;
			92 : dato_BCD <=8'h92;
			93 : dato_BCD <=8'h93;
 			94 : dato_BCD <=8'h94;
			95 : dato_BCD <=8'h95;
			96 : dato_BCD <=8'h96;
			97 : dato_BCD <=8'h97;
			98 : dato_BCD <=8'h98;
			99 : dato_BCD <=8'h99;
			default: dato_BCD <=8'h00;
		endcase end
	else if (a_min==1'b1)begin //si el Cont_ajuste_hora se encuentra en la segunda posicion activa la señal a_min, por lo que
	//el dato en la salida del deco corresponde al dato en hexadecimal de minuto
		case (cont_min)
			6'd0 : dato_BCD <=8'h00;
 			6'd1 : dato_BCD <=8'h01;
			6'd2 : dato_BCD <=8'h02;
			6'd3 : dato_BCD <=8'h03;
			6'd4 : dato_BCD <=8'h04;
			6'd5 : dato_BCD <=8'h05;
			6'd6 : dato_BCD <=8'h06;
			6'd7 : dato_BCD <=8'h07;
			6'd8 : dato_BCD <=8'h08;
			6'd9 : dato_BCD <=8'h09;
			6'd10 : dato_BCD <=8'h10;
			6'd11 : dato_BCD <=8'h11;
			6'd12 : dato_BCD <=8'h12;
			6'd13 : dato_BCD <=8'h13;
 			6'd14 : dato_BCD <=8'h14;
			6'd15 : dato_BCD <=8'h15;
			6'd16 : dato_BCD <=8'h16;
			6'd17 : dato_BCD <=8'h17;
			6'd18 : dato_BCD <=8'h18;
			6'd19 : dato_BCD <=8'h19;
			6'd20 : dato_BCD <=8'h20;
			6'd21 : dato_BCD <=8'h21;
			6'd22 : dato_BCD <=8'h22;
			6'd23 : dato_BCD <=8'h23;
 			6'd24 : dato_BCD <=8'h24;
			6'd25 : dato_BCD <=8'h25;
			6'd26 : dato_BCD <=8'h26;
			6'd27 : dato_BCD <=8'h27;
			6'd28 : dato_BCD <=8'h28;
			6'd29 : dato_BCD <=8'h29;
			6'd30 : dato_BCD <=8'h30;
			6'd31 : dato_BCD <=8'h31;
			6'd32 : dato_BCD <=8'h32;
			6'd33 : dato_BCD <=8'h33;
 			6'd34 : dato_BCD <=8'h34;
			6'd35 : dato_BCD <=8'h35;
			6'd36 : dato_BCD <=8'h36;
			6'd37 : dato_BCD <=8'h37;
			6'd38 : dato_BCD <=8'h38;
			6'd39 : dato_BCD <=8'h39;
			6'd40 : dato_BCD <=8'h40;
			6'd41 : dato_BCD <=8'h41;
			6'd42 : dato_BCD <=8'h42;
			6'd43 : dato_BCD <=8'h43;
 			6'd44 : dato_BCD <=8'h44;
			6'd45 : dato_BCD <=8'h45;
			6'd46 : dato_BCD <=8'h46;
			6'd47 : dato_BCD <=8'h47;
			6'd48 : dato_BCD <=8'h48;
			6'd49 : dato_BCD <=8'h49;
			6'd50 : dato_BCD <=8'h50;
			6'd51 : dato_BCD <=8'h51;
			6'd52 : dato_BCD <=8'h52;
			6'd53 : dato_BCD <=8'h53;
 			6'd54 : dato_BCD <=8'h54;
			6'd55 : dato_BCD <=8'h55;
			6'd56 : dato_BCD <=8'h56;
			6'd57 : dato_BCD <=8'h57;
			6'd58 : dato_BCD <=8'h58;
			6'd59 : dato_BCD <=8'h59;
			default: dato_BCD <=8'h00;
		endcase end
	else if (a_seg==1'b1)begin //si el Cont_ajuste_hora se encuentra en la tercera posicion activa la señal a_seg, por lo que
	//el dato en la salida del deco corresponde al dato en hexadecimal de segundo
		case (cont_seg)
			6'd0 : dato_BCD <=8'h00;
 			6'd1 : dato_BCD <=8'h01;
			6'd2 : dato_BCD <=8'h02;
			6'd3 : dato_BCD <=8'h03;
			6'd4 : dato_BCD <=8'h04;
			6'd5 : dato_BCD <=8'h05;
			6'd6 : dato_BCD <=8'h06;
			6'd7 : dato_BCD <=8'h07;
			6'd8 : dato_BCD <=8'h08;
			6'd9 : dato_BCD <=8'h09;
			6'd10 : dato_BCD <=8'h10;
			6'd11 : dato_BCD <=8'h11;
			6'd12 : dato_BCD <=8'h12;
			6'd13 : dato_BCD <=8'h13;
 			6'd14 : dato_BCD <=8'h14;
			6'd15 : dato_BCD <=8'h15;
			6'd16 : dato_BCD <=8'h16;
			6'd17 : dato_BCD <=8'h17;
			6'd18 : dato_BCD <=8'h18;
			6'd19 : dato_BCD <=8'h19;
			6'd20 : dato_BCD <=8'h20;
			6'd21 : dato_BCD <=8'h21;
			6'd22 : dato_BCD <=8'h22;
			6'd23 : dato_BCD <=8'h23;
 			6'd24 : dato_BCD <=8'h24;
			6'd25 : dato_BCD <=8'h25;
			6'd26 : dato_BCD <=8'h26;
			6'd27 : dato_BCD <=8'h27;
			6'd28 : dato_BCD <=8'h28;
			6'd29 : dato_BCD <=8'h29;
			6'd30 : dato_BCD <=8'h30;
			6'd31 : dato_BCD <=8'h31;
			6'd32 : dato_BCD <=8'h32;
			6'd33 : dato_BCD <=8'h33;
 			6'd34 : dato_BCD <=8'h34;
			6'd35 : dato_BCD <=8'h35;
			6'd36 : dato_BCD <=8'h36;
			6'd37 : dato_BCD <=8'h37;
			6'd38 : dato_BCD <=8'h38;
			6'd39 : dato_BCD <=8'h39;
			6'd40 : dato_BCD <=8'h40;
			6'd41 : dato_BCD <=8'h41;
			6'd42 : dato_BCD <=8'h42;
			6'd43 : dato_BCD <=8'h43;
 			6'd44 : dato_BCD <=8'h44;
			6'd45 : dato_BCD <=8'h45;
			6'd46 : dato_BCD <=8'h46;
			6'd47 : dato_BCD <=8'h47;
			6'd48 : dato_BCD <=8'h48;
			6'd49 : dato_BCD <=8'h49;
			6'd50 : dato_BCD <=8'h50;
			6'd51 : dato_BCD <=8'h51;
			6'd52 : dato_BCD <=8'h52;
			6'd53 : dato_BCD <=8'h53;
 			6'd54 : dato_BCD <=8'h54;
			6'd55 : dato_BCD <=8'h55;
			6'd56 : dato_BCD <=8'h56;
			6'd57 : dato_BCD <=8'h57;
			6'd58 : dato_BCD <=8'h58;
			6'd59 : dato_BCD <=8'h59;
			default: dato_BCD <=8'h00;
		endcase end
	else if (a_cr_hora==1'b1)begin //si el Cont_ajuste_crono se encuentra en la primera posicion activa la señal a_cr_hora, por lo que
	//el dato en la salida del deco corresponde al dato en hexadecimal de hora en el cronómetro
		case (crono_hora)
			0 : dato_BCD <=8'h00;
 			1 : dato_BCD <=8'h01;
			2 : dato_BCD <=8'h02;
			3 : dato_BCD <=8'h03;
			4 : dato_BCD <=8'h04;
			5 : dato_BCD <=8'h05;
			6 : dato_BCD <=8'h06;
			7 : dato_BCD <=8'h07;
			8 : dato_BCD <=8'h08;
			9 : dato_BCD <=8'h09;
			10 : dato_BCD <=8'h10;
			11 : dato_BCD <=8'h11;
			12 : dato_BCD <=8'h12;
			default: dato_BCD <=8'h00;
		endcase end
	else if (a_cr_min==1'b1)begin //si el Cont_ajuste_crono se encuentra en la segunda posicion activa la señal a_cr_min, por lo que
	//el dato en la salida del deco corresponde al dato en hexadecimal de minuto en el cronómetro
		case (crono_min)
		   0 : dato_BCD <=8'h00;
 			1 : dato_BCD <=8'h01;
			2 : dato_BCD <=8'h02;
			3 : dato_BCD <=8'h03;
			4 : dato_BCD <=8'h04;
			5 : dato_BCD <=8'h05;
			6 : dato_BCD <=8'h06;
			7 : dato_BCD <=8'h07;
			8 : dato_BCD <=8'h08;
			9 : dato_BCD <=8'h09;
			10 : dato_BCD <=8'h10;
			11 : dato_BCD <=8'h11;
			12 : dato_BCD <=8'h12;
			13 : dato_BCD <=8'h13;
 			14 : dato_BCD <=8'h14;
			15 : dato_BCD <=8'h15;
			16 : dato_BCD <=8'h16;
			17 : dato_BCD <=8'h17;
			18 : dato_BCD <=8'h18;
			19 : dato_BCD <=8'h19;
			20 : dato_BCD <=8'h20;
			21 : dato_BCD <=8'h21;
			22 : dato_BCD <=8'h22;
			23 : dato_BCD <=8'h23;
 			24 : dato_BCD <=8'h24;
			25 : dato_BCD <=8'h25;
			26 : dato_BCD <=8'h26;
			27 : dato_BCD <=8'h27;
			28 : dato_BCD <=8'h28;
			29 : dato_BCD <=8'h29;
			30 : dato_BCD <=8'h30;
			31 : dato_BCD <=8'h31;
			32 : dato_BCD <=8'h32;
			33 : dato_BCD <=8'h33;
 			34 : dato_BCD <=8'h34;
			35 : dato_BCD <=8'h35;
			36 : dato_BCD <=8'h36;
			37 : dato_BCD <=8'h37;
			38 : dato_BCD <=8'h38;
			39 : dato_BCD <=8'h39;
			40 : dato_BCD <=8'h40;
			41 : dato_BCD <=8'h41;
			42 : dato_BCD <=8'h42;
			43 : dato_BCD <=8'h43;
 			44 : dato_BCD <=8'h44;
			45 : dato_BCD <=8'h45;
			46 : dato_BCD <=8'h46;
			47 : dato_BCD <=8'h47;
			48 : dato_BCD <=8'h48;
			49 : dato_BCD <=8'h49;
			50 : dato_BCD <=8'h50;
			51 : dato_BCD <=8'h51;
			52 : dato_BCD <=8'h52;
			53 : dato_BCD <=8'h53;
 			54 : dato_BCD <=8'h54;
			55 : dato_BCD <=8'h55;
			56 : dato_BCD <=8'h56;
			57 : dato_BCD <=8'h57;
			58 : dato_BCD <=8'h58;
			59 : dato_BCD <=8'h59;
			default: dato_BCD <=8'h00;
		endcase end
	else if (a_cr_seg==1'b1)begin //si el Cont_ajuste_crono se encuentra en la tercera posicion activa la señal a_cr_seg, por lo que
	//el dato en la salida del deco corresponde al dato en hexadecimal de segundo en el cronómetro
		case (crono_seg)
			0 : dato_BCD <=8'h00;
 			1 : dato_BCD <=8'h01;
			2 : dato_BCD <=8'h02;
			3 : dato_BCD <=8'h03;
			4 : dato_BCD <=8'h04;
			5 : dato_BCD <=8'h05;
			6 : dato_BCD <=8'h06;
			7 : dato_BCD <=8'h07;
			8 : dato_BCD <=8'h08;
			9 : dato_BCD <=8'h09;
			10 : dato_BCD <=8'h10;
			11 : dato_BCD <=8'h11;
			12 : dato_BCD <=8'h12;
			13 : dato_BCD <=8'h13;
 			14 : dato_BCD <=8'h14;
			15 : dato_BCD <=8'h15;
			16 : dato_BCD <=8'h16;
			17 : dato_BCD <=8'h17;
			18 : dato_BCD <=8'h18;
			19 : dato_BCD <=8'h19;
			20 : dato_BCD <=8'h20;
			21 : dato_BCD <=8'h21;
			22 : dato_BCD <=8'h22;
			23 : dato_BCD <=8'h23;
 			24 : dato_BCD <=8'h24;
			25 : dato_BCD <=8'h25;
			26 : dato_BCD <=8'h26;
			27 : dato_BCD <=8'h27;
			28 : dato_BCD <=8'h28;
			29 : dato_BCD <=8'h29;
			30 : dato_BCD <=8'h30;
			31 : dato_BCD <=8'h31;
			32 : dato_BCD <=8'h32;
			33 : dato_BCD <=8'h33;
 			34 : dato_BCD <=8'h34;
			35 : dato_BCD <=8'h35;
			36 : dato_BCD <=8'h36;
			37 : dato_BCD <=8'h37;
			38 : dato_BCD <=8'h38;
			39 : dato_BCD <=8'h39;
			40 : dato_BCD <=8'h40;
			41 : dato_BCD <=8'h41;
			42 : dato_BCD <=8'h42;
			43 : dato_BCD <=8'h43;
 			44 : dato_BCD <=8'h44;
			45 : dato_BCD <=8'h45;
			46 : dato_BCD <=8'h46;
			47 : dato_BCD <=8'h47;
			48 : dato_BCD <=8'h48;
			49 : dato_BCD <=8'h49;
			50 : dato_BCD <=8'h50;
			51 : dato_BCD <=8'h51;
			52 : dato_BCD <=8'h52;
			53 : dato_BCD <=8'h53;
 			54 : dato_BCD <=8'h54;
			55 : dato_BCD <=8'h55;
			56 : dato_BCD <=8'h56;
			57 : dato_BCD <=8'h57;
			58 : dato_BCD <=8'h58;
			59 : dato_BCD <=8'h59;
			default: dato_BCD <=8'h00;
		endcase end
		
end
endmodule  

