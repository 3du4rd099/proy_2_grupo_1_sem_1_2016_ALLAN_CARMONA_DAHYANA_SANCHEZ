`timescale 1ns / 1ps

module FSM(

/* 

En este módulo se encuentra la máquina de estados del control de rtc


*/

input wire listo_inicio,listo_guardar, //declaración de señales de entrada que dicen que intervienen en el estadop presente
input wire clk,
input wire reset,cambio, //declaración de la variable cambio que determina cuando el usuario realiza un cambio en el rtc
output reg enable_inicio,enable_escribir,enable_leer,reset_cambio,reset_li,reset_le,reset_ll,reset_lg //salidas de la FSM para activar cada uno de los procesos y para resetear las señales de bandera de procesos terminados como los reset
 
    );


localparam[1:0]  // declaración de los sstados
					 inicio = 2'b00,
				    escribir = 2'b01,
					 leer = 2'b10;
					 
					 
reg [1:0] estado_actual,estado_sig; //lógica estado siguiente y estado actual


initial begin 
	enable_inicio<=0;
	enable_escribir<=0;    //declaración de salidas en cero para TB
	enable_leer<=0;
	reset_cambio<=0;
	reset_li<=0;
	reset_le<=0;
	reset_lg<=0;
   reset_ll<=0;
	estado_actual<=0;
	end


always @(posedge clk) //lista sensitiva con clk

begin

if(reset) begin
estado_actual <= inicio; //reinicio de máquina



end else begin
estado_actual <= estado_sig; //lógica estado siguiente
end


end

always @ (estado_actual or listo_inicio or listo_guardar or cambio  ) begin 

estado_sig = 0;

	case(estado_actual)							// Lógica para pasar de estados mediante el cambio de una entrada de la FSM
	
		inicio: if(listo_inicio ) begin
			estado_sig = leer;
			reset_li<=1;						//si se termina la inicializacion del rtc cambie al estado de lectura
			reset_le<=0;
			reset_lg<=0;						
			//reset_ll<=0;
			reset_cambio <=0;
			
			end else  begin
			estado_sig = inicio;
			reset_li<=0;					//si aún no termina quedese inicializando
			reset_le<=1;
			reset_lg<=1;
			//reset_ll<=1;
			reset_cambio <=0;
				end
			
		escribir: if(cambio) begin
		if(listo_guardar) begin
			estado_sig = leer;			//si se realiza un cambio y se terminó de guardar, pasar al estado de lectura
			
			reset_li<=0;
			reset_le<=1;
			reset_lg<=1;
			//reset_ll<=1;
			reset_cambio <=1;
			end else begin          // si ha terminado permanece en estado
			estado_sig = escribir;
			reset_li<=1;
			reset_le<=0;
			reset_lg<=0;
			//reset_ll<=1;
			reset_cambio <=0;
			end
				
		end else begin
			estado_sig = leer; 
			reset_li<=0;        				//si NO se realiza un cambio en algun numero permanecer en el estado
			reset_le<=1;
			reset_lg<=1;
			//reset_ll<=1;
			reset_cambio <=0;
			end
			
		leer: 
			if(cambio==1)begin
			estado_sig =escribir;				//si hay un cambio pasar al estado de escritura
			reset_li<=0;
			reset_le<=0;
			reset_lg<=0;
			//reset_ll<=1;
			reset_cambio <=0;
			end 
			else begin estado_sig =leer;
			reset_li<=1;							//si no hay cambio permanece leyendo
			reset_le<=1;
			reset_lg<=1;
			//reset_ll<=1;
			reset_cambio <=0;end
	
	
		default: begin estado_sig= inicio;			
		   reset_li<=0;
			reset_le<=0;							//caso por defecto en otro estado
			reset_lg<=0;
			reset_cambio <=0;
			//reset_ll<=0;
		end
endcase		
end

always @ (posedge clk)   			//Lógica para funciones de enable de salida según el estado actual
	begin
	if(reset == 1)begin

	enable_inicio<=0;
	enable_escribir<=0;
	enable_leer<=0;

	

	end else

	begin
	case(estado_actual)

				inicio: begin
				enable_inicio<=1;
				enable_escribir<=0;
				enable_leer<=0;					//si se encuentra en estado inicio habilita el proceso de inicializar
				 
				end
				
				escribir:begin
				enable_inicio<=0;
				enable_escribir<=1;  //si se encuentra en estado escribir habilita la escritura
				enable_leer<=0;
				
				end
				leer:begin
				enable_inicio<=0;
				enable_escribir<=0;   //si se encuentra en estado leer habilita la lectura
				enable_leer<=1;
				
				end
				
			endcase


end


	end
	

	
			 

endmodule
