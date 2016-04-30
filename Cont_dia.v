`timescale 1ns / 1ps

module Contador_dia(
    input clk,
    input rst,
	 input [1:0]EN,
    input aumento,
    input disminuye,
    output reg [4:0] cont_dia
	 //output reg a_dia
    );



always @(posedge clk /*or posedge rst*/)
begin
	if (rst || cont_dia==5'd31)
		cont_dia<=5'b0;
	else  if (EN==2'd0) begin
		//a_dia<=1;
		if (aumento) begin
			cont_dia<=cont_dia + 5'b1;
			 end
		else if (disminuye) begin
			if(cont_dia==5'd0) cont_dia<=0;
			else begin
				cont_dia<=cont_dia - 5'b1;
				 end end
		else begin
	
			cont_dia <= cont_dia;	
			//a_dia<=0; 
			end
	end
end
endmodule 