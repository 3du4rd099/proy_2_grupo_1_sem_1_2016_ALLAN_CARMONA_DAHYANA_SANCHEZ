`timescale 1ns / 1ps

module Cronometro_min(
    input clk,
    input rst,
	 input [1:0]EN,
    input aumento,
    input disminuye,
    output reg [5:0] crono_min
	 //output reg a_cr_min
    );



always @(posedge clk /*or posedge rst*/)
begin
	if (rst || crono_min==6'd60)
		crono_min<=6'b0;
	else  if (EN==2'd1) begin
		//a_cr_min<=1;
		if (aumento) begin
			crono_min<=crono_min + 6'b1;
			 end
		else if (disminuye ) begin
			if (crono_min==6'd0) crono_min<=0;
			else begin
				crono_min<=crono_min - 6'b1;
				 end end
		else begin
		
			crono_min <= crono_min;	
			//a_cr_min<=0; 
			end
	end
end
endmodule
