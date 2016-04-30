// Listing 14.6
module pong_text
   (
	
	// generador de texto
	
    input wire clk, 
    input wire [3:0] dig0, dig1,dig2,dig3,dig4,dig5,dig6,dig7,dig8,dig9,dig10,dig11,dig12,dig13,dig14,dig15,dig16,dig17,
	 input wire [9:0] pix_x, pix_y,
    output wire [8:0] text_on,
    output reg [2:0] text_rgb
   );

   wire [10:0] rom_addr;
   reg [6:0] char_addr, char_addr_s, char_addr_l,
             char_addr_r, char_addr_o,char_addr_a,char_addr_b,char_addr_c,char_addr_am,char_addr_pm,char_addr_alerta;
   reg [3:0] row_addr;
   wire [3:0] row_addr_s, row_addr_l, row_addr_r, row_addr_o,row_addr_a,row_addr_b,row_addr_c,row_addr_am,row_addr_pm/*,row_addr_alerta*/;
   reg [2:0] bit_addr;
   wire [2:0] bit_addr_s, bit_addr_l,bit_addr_r, bit_addr_o,bit_addr_a,bit_addr_b,bit_addr_c,bit_addr_am,bit_addr_pm/*,bit_addr_alerta*/;
   wire [7:0] font_word;
   wire font_bit, score_on, logo_on, rule_on, over_on,hora_1,hora_2,fecha,am,pm/*,alerta*/;
   wire [7:0] rule_rom_addr;

   // instanciacion de ROM DE CARACTERES
   font_rom font_unit
      (.clk(clk), .addr(rom_addr), .data(font_word));
		
		
		//declaracion de cada una de las letras y numeros a generar

   assign score_on = (pix_y[9:5]==2) && (pix_x[9:4]<15); //posición en pantalla
   assign row_addr_s = pix_y[4:1];  //escalamiento
   assign bit_addr_s = pix_x[3:1];
   always @*
      case (pix_x[7:4])
			4'h0: char_addr_s = 7'h00; //
			4'h1: char_addr_s = 7'h00; //
			4'h2: char_addr_s = 7'h44; // D
         4'h3: char_addr_s = 7'h49; // I
         4'h4: char_addr_s = 7'h41; // A
         4'h5: char_addr_s = 7'h00; // 
			4'h6: char_addr_s = 7'h00; //
         4'h7: char_addr_s = 7'h4d; // M
         4'h8: char_addr_s = 7'h45; // E
			4'h9: char_addr_s = 7'h53; // S
         4'ha: char_addr_s = 7'h00; //
		   4'hb: char_addr_s = 7'h00; //
         4'hc: char_addr_s = 7'h41; //A
         4'hd: char_addr_s = 7'h4e; //N
         4'he: char_addr_s = 7'h4f; //O
			4'hf: char_addr_s = 7'h00; 
      endcase

  
  
   assign logo_on = (pix_y[9:5]==10) && (pix_x[9:4]<=15);
   assign row_addr_l = pix_y[4:1];
   assign bit_addr_l = pix_x[3:1];
   always @*
      case (pix_x[7:4])
			4'h0: char_addr_l = 7'h00; // 
         4'h1: char_addr_l = 7'h00; // 
         4'h2: char_addr_l = 7'h43; // C
         4'h3: char_addr_l = 7'h52; // R
			4'h4: char_addr_l = 7'h4f; // O
         4'h5: char_addr_l = 7'h4e; // N
         4'h6: char_addr_l = 7'h4f; // O
			4'h7: char_addr_l = 7'h4d; // M
         4'h8: char_addr_l = 7'h45; //E
			4'h9: char_addr_l = 7'h54; //T
         4'ha: char_addr_l = 7'h52; //R
         4'hb: char_addr_l = 7'h4f; //O
         4'hc: char_addr_l = 7'h00; //
			4'hd: char_addr_l = 7'h00; //
			4'he: char_addr_l = 7'h00; //
			default:  char_addr_l = 7'h00;
      endcase

   assign rule_on = (pix_y[9:5]==5) && (pix_x[9:4]<15);
   assign row_addr_r = pix_y[4:1];
   assign bit_addr_r = pix_x[3:1];
   always @*
      case (pix_x[7:4])
         
         6'h00: char_addr_r = 7'h00; // 
         6'h01: char_addr_r = 7'h00; // 
         6'h02: char_addr_r = 7'h48; // H
         6'h03: char_addr_r = 7'h4f; // O
         6'h04: char_addr_r = 7'h52; // R
         6'h05: char_addr_r = 7'h41; // A
         6'h06: char_addr_r = 7'h00; //
         6'h07: char_addr_r = 7'h00; //
         6'h08: char_addr_r = 7'h00; //
         6'h09: char_addr_r = 7'h00; //
         6'h0a: char_addr_r = 7'h00; //
         6'h0b: char_addr_r = 7'h00; //
         6'h0c: char_addr_r = 7'h00; //
         6'h0d: char_addr_r = 7'h00; //
         6'h0e: char_addr_r = 7'h00; //
         6'h0f: char_addr_r = 7'h00; //

      endcase

   assign over_on = (pix_y[9:5]==3) && (pix_x[9:4]<=15);
   assign row_addr_o = pix_y[4:1];
   assign bit_addr_o = pix_x[3:1];
   always @*
      case(pix_x[7:4])
			4'h0: char_addr_o = 7'h00; //
			4'h1: char_addr_o = 7'h00; //
			4'h2: char_addr_o = 7'h00; // 
         4'h3: char_addr_o = {3'b011, dig0}; // num dia
         4'h4: char_addr_o = {3'b011, dig1}; // num dia
         4'h5: char_addr_o = 7'h00; // 
			4'h6: char_addr_o = 7'h00; //
         4'h7: char_addr_o = 7'h00; // 
         4'h8: char_addr_o = {3'b011, dig2}; // num mes 
			4'h9: char_addr_o = {3'b011, dig3}; // num mes
         4'ha: char_addr_o = 7'h00; //
			4'hb: char_addr_o = 7'h00; //
         4'hc: char_addr_o = 7'h32; //num año
         4'hd: char_addr_o = 7'h30; //num año
			4'he: char_addr_o = {3'b011, dig4}; //num año
			4'hf: char_addr_o = {3'b011, dig5};
      endcase
		
		
	assign hora_1 = (pix_y[9:5]==8) && /*(pix_x[9:4]>15) &&*/ (pix_x[9:4]<15);
   assign row_addr_a = pix_y[4:1];
   assign bit_addr_a = pix_x[3:1];
   always @*
      case (pix_x[7:4])
			4'h0: char_addr_a = 7'h00; //numeros de el reloj
			4'h1: char_addr_a = 7'h00; //
			4'h2: char_addr_a = {3'b011, dig6}; //  hora
         4'h3: char_addr_a = {3'b011, dig7}; // 
         4'h4: char_addr_a = 7'h3a; // 
         4'h5: char_addr_a = {3'b011, dig8}; // min
			4'h6: char_addr_a = {3'b011, dig9}; //
         4'h7: char_addr_a = 7'h3a; // 
         4'h8: char_addr_a = {3'b011, dig10}; // seg
			4'h9: char_addr_a = {3'b011, dig11}; // 
         4'ha: char_addr_a = 7'h00; //
			4'hb: char_addr_a = 7'h00; //
         4'hc: char_addr_a = 7'h00; //
         4'hd: char_addr_a = 7'h00; //
         4'he: char_addr_a = 7'h00; //
      	4'hf: char_addr_a = 7'h00; //

      endcase
		
	assign hora_2 = (pix_y[9:5]==11) && /*(pix_x[9:4]>15) &&*/ (pix_x[9:4]<15);
   assign row_addr_b = pix_y[4:1];
   assign bit_addr_b = pix_x[3:1];
   always @*
      case (pix_x[7:4])
			4'h0: char_addr_b = 7'h00; //				cronometro
			4'h1: char_addr_b = 7'h00; //
			4'h2: char_addr_b = {3'b011, dig12}; // 
         4'h3: char_addr_b = {3'b011, dig13}; // hors
         4'h4: char_addr_b = 7'h3a; // 
         4'h5: char_addr_b = {3'b011, dig14}; // min
			4'h6: char_addr_b = {3'b011, dig15}; //
         4'h7: char_addr_b = 7'h3a; // 
         4'h8: char_addr_b = {3'b011, dig16}; // 
			4'h9: char_addr_b = {3'b011, dig17}; // seg
         4'ha: char_addr_b = 7'h00; //
			4'hb: char_addr_b = 7'h00; //
         4'hc: char_addr_b = 7'h00; //
         4'hd: char_addr_b = 7'h00; //
         4'he: char_addr_b = 7'h00; //
      	4'hf: char_addr_b = 7'h00; //

      endcase
				
	assign fecha = (pix_y[9:5]==1) && /*(pix_x[9:4]>15) &&*/ (pix_x[9:4]<15);
   assign row_addr_c = pix_y[4:1];
   assign bit_addr_c = pix_x[3:1];
   always @*
      case (pix_x[7:4])
			4'h0: char_addr_c = 7'h00; //
			4'h1: char_addr_c = 7'h00; //
			4'h2: char_addr_c = 7'h46; // 
         4'h3: char_addr_c = 7'h45; // 
         4'h4: char_addr_c = 7'h43; // 
         4'h5: char_addr_c = 7'h48; //F 
			4'h6: char_addr_c = 7'h41; //E
         4'h7: char_addr_c = 7'h00; //C
         4'h8: char_addr_c = 7'h00; //H 
			4'h9: char_addr_c = 7'h00; //A
         4'ha: char_addr_c = 7'h00; //
			4'hb: char_addr_c = 7'h00; //
         4'hc: char_addr_c = 7'h00; //
         4'hd: char_addr_c = 7'h00; //
         4'he: char_addr_c = 7'h00; //
      	4'hf: char_addr_c = 7'h00; //

      endcase
	
	assign am = (pix_y[9:5]==6) && /*(pix_x[9:4]>15) &&*/ (pix_x[9:4]<15);
   assign row_addr_am = pix_y[4:1];
   assign bit_addr_am = pix_x[3:1];
   always @*
      case (pix_x[7:4])
			4'h0: char_addr_am = 7'h00; //
			4'h1: char_addr_am = 7'h00; //
			4'h2: char_addr_am = 7'h00; // 
         4'h3: char_addr_am = 7'h00; // 
         4'h4: char_addr_am = 7'h00; // 
         4'h5: char_addr_am = 7'h00; // 
			4'h6: char_addr_am = 7'h00; //
         4'h7: char_addr_am = 7'h00; //
         4'h8: char_addr_am = 7'h00; // 
			4'h9: char_addr_am = 7'h00; //
         4'ha: char_addr_am = 7'h41; //A
			4'hb: char_addr_am = 7'h4d; //M
         4'hc: char_addr_am = 7'h00; //
         4'hd: char_addr_am = 7'h00; //
         4'he: char_addr_am = 7'h00; //
      	4'hf: char_addr_am = 7'h00; //

      endcase
		
	assign pm = (pix_y[9:5]==7) && /*(pix_x[9:4]>15) &&*/ (pix_x[9:4]<15);
   assign row_addr_pm = pix_y[4:1];
   assign bit_addr_pm = pix_x[3:1];
   always @*
      case (pix_x[7:4])
			4'h0: char_addr_pm = 7'h00; //
			4'h1: char_addr_pm = 7'h00; //
			4'h2: char_addr_pm = 7'h00; // 
         4'h3: char_addr_pm = 7'h00; // 
         4'h4: char_addr_pm = 7'h00; // 
         4'h5: char_addr_pm = 7'h00; // 
			4'h6: char_addr_pm = 7'h00; //
         4'h7: char_addr_pm = 7'h00; //
         4'h8: char_addr_pm = 7'h00; // 
			4'h9: char_addr_pm=  7'h00; //
         4'ha: char_addr_pm = 7'h50; //P
			4'hb: char_addr_pm = 7'h4d; //M
         4'hc: char_addr_pm = 7'h00; //
         4'hd: char_addr_pm = 7'h00; //
         4'he: char_addr_pm = 7'h00; //
      	4'hf: char_addr_pm = 7'h00; //

      endcase
		
	assign alerta = (pix_y[9:5]==12) && /*(pix_x[9:4]>15) &&*/ (pix_x[9:4]<15);
   assign row_addr_alerta = pix_y[4:1];
   assign bit_addr_alerta = pix_x[3:1];
   always @*
      case (pix_x[7:4])
			4'h0: char_addr_alerta = 7'h00; //
			4'h1: char_addr_alerta = 7'h00; //
			4'h2: char_addr_alerta = 7'h2a; //* 
         4'h3: char_addr_alerta = 7'h2a; //* 
         4'h4: char_addr_alerta = 7'h41; //A 
         4'h5: char_addr_alerta = 7'h4c; //L 
			4'h6: char_addr_alerta = 7'h41; //A
         4'h7: char_addr_alerta = 7'h52; //R
         4'h8: char_addr_alerta = 7'h4d; //M
			4'h9: char_addr_alerta = 7'h41; //A
         4'ha: char_addr_alerta = 7'h2a; //*
			4'hb: char_addr_alerta = 7'h2a; //*
         4'hc: char_addr_alerta = 7'h00; //
         4'hd: char_addr_alerta = 7'h00; //
         4'he: char_addr_alerta = 7'h00; //
      	4'hf: char_addr_alerta = 7'h00; //

      endcase
		
		
//declaración de los colores y salidas mediante un MUX
   always @*
   begin
      text_rgb = 3'b111;  // fondo blanco
      if (score_on)
         begin
            char_addr = char_addr_s;
            row_addr = row_addr_s;
            bit_addr = bit_addr_s;
            if (font_bit)
               text_rgb = 3'b000;
         end
      else if (rule_on)
         begin
            char_addr = char_addr_r;
            row_addr = row_addr_r;
            bit_addr = bit_addr_r;
            if (font_bit)
               text_rgb = 3'b001;
         end
      else if (logo_on)
         begin
            char_addr = char_addr_l;
            row_addr = row_addr_l;
            bit_addr = bit_addr_l;
            if (font_bit)
               text_rgb = 3'b001;
         end
      else 
		
		if (hora_1)
         begin
            char_addr = char_addr_a;
            row_addr = row_addr_a;
            bit_addr = bit_addr_a;
            if (font_bit)
               text_rgb = 3'b000;
         end
      else 
		
		if (hora_2)
         begin
            char_addr = char_addr_b;
            row_addr = row_addr_b;
            bit_addr = bit_addr_b;
            if (font_bit)
               text_rgb = 3'b000;
         end
      else 
		if (fecha)
         begin
            char_addr = char_addr_c;
            row_addr = row_addr_c;
            bit_addr = bit_addr_c;
            if (font_bit)
               text_rgb = 3'b001;
         end
      else 
		
				if (am)
         begin
            char_addr = char_addr_am;
            row_addr = row_addr_am;
            bit_addr = bit_addr_am;
            if (font_bit)
               text_rgb = 3'b000;
         end	
      else 
		
				if (pm)
         begin
            char_addr = char_addr_pm;
            row_addr = row_addr_pm;
            bit_addr = bit_addr_pm;
            if (font_bit)
               text_rgb = 3'b000;
         end
      else /*if (alerta)
         begin
            char_addr = char_addr_alerta;
            row_addr = row_addr_alerta;
            bit_addr = bit_addr_alerta;
            if (font_bit)begin
					if(dig4==0) //revisar
               text_rgb = 3'b000;
					else
					text_rgb = 3'b100;
				end
         end
      else */
		
		// game over
         begin
            char_addr = char_addr_o;
            row_addr = row_addr_o;
            bit_addr = bit_addr_o;
            if (font_bit)
               text_rgb = 3'b000;
         end
   end

   assign text_on = {/*alerta,*/pm,am,fecha,hora_2,hora_1,score_on, logo_on, rule_on, over_on};

   assign rom_addr = {char_addr, row_addr};
   assign font_bit = font_word[~bit_addr];    //salidas de direccion de la memoria

endmodule
