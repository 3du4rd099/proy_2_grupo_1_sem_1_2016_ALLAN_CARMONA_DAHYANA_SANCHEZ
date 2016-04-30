
module pong_top   //modulo de control de VGA tomado del Pong P.Chu modificado
   (
	
	
	//declaración de todos los datos de entrada a pintar en pantalla, salidas de sincronización vertical y horizontal, salida RGB y entrada am_pm
    input wire clkd,reset,
	 input wire [3:0] d0,d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13,d14,d15,d16,d17,/*d18,d19,d20,*/
    output wire hsync, vsync, //sincronizaciones
    output wire [2:0] rgb, //salida principal RGB
	 input wire am_pm
   );

	reg [1:0] state_reg, state_next;   //declaración de estado siguiente y actual
   wire [9:0] pixel_x, pixel_y;			//pixeles por los que va el barrido provenientes del sincronizador
   wire video_on, pixel_tick;				
   wire [9:0] text_on;
   wire [2:0] text_rgb; 					
   reg [2:0] rgb_reg, rgb_next;		//declaración estado siguiente y actual
  
   wire timer_tick;

	
	clockdiv clockdiv (   //instanciacion del div de frecuencia
    .clk(clkd), 
    .clr(reset), 
    .dclk(clk)
    );
	 
   vga_sync vsync_unit
      (.clk(clk), .reset(reset), .hsync(hsync), .vsync(vsync),   //instanciacion de modulo sincronizacion VGA 
       .video_on(video_on), .p_tick(pixel_tick),
       .pixel_x(pixel_x), .pixel_y(pixel_y));
   
	pong_text pong_text (    //instanciacion de modulo generador de texto
    .clk(clk), 
    .dig0(d0), 
    .dig1(d1),  
    .dig2(d2), 
    .dig3(d3), 
    .dig4(d4), 
    .dig5(d5), 
    .dig6(d6), 
    .dig7(d7), 
    .dig8(d8), 
    .dig9(d9), 
    .dig10(d10), 
    .dig11(d11), 
    .dig12(d12), 
    .dig13(d13), 
    .dig14(d14), 
    .dig15(d15), 
    .dig16(d16),
    .dig17(d17),	 
    .pix_x(pixel_x), 
    .pix_y(pixel_y), 
    .text_on(text_on), 
    .text_rgb(text_rgb)
    );
		
assign timer_tick = (pixel_x==0) && (pixel_y==0);
    always @(posedge clk, posedge reset)
       if (reset)
          begin
																					//máquina de estados para salida RGB
             rgb_reg <= 0;
          end
       else
          begin
            state_reg <= state_next;
            if (pixel_tick)
               rgb_reg <= rgb_next;
          end
  
   always @*
      if (~video_on)
         rgb_next = "000";     //cuando el barrido no se encuentra en ninguna parte de impresion coloca el color negro a la salida
      else
         
         if (text_on[1]||(text_on[0]))
            rgb_next = text_rgb;
        
         else if (text_on[2]) 
           rgb_next = text_rgb;
         else if (text_on[3]) 
           rgb_next = text_rgb;
         else if (text_on[4]) 
           rgb_next = text_rgb;
         else if (text_on[5]) 						//Para algun cambio a la salida cambia el estado siguiente de RGB
           rgb_next = text_rgb;
         else if (text_on[6]) 
           rgb_next = text_rgb;
         else if (text_on[7]&&am_pm) 
           rgb_next = text_rgb;
         else if (text_on[8]&&~am_pm) 
           rgb_next = text_rgb;
        // else if (text_on[9]&&d20) 
//rgb_next = text_rgb;
         else
           rgb_next = 3'b111; 
   
   assign rgb = rgb_reg;
endmodule
