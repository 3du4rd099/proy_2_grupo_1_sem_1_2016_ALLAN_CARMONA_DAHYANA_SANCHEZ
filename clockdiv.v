`timescale 1ns / 1ps

module clockdiv(
	input wire clk,		//master clock: 50MHz
	input wire clr,		//asynchronous reset
	output wire dclk		//pixel clock: 25MHz

	);

// 17-bit counter variable
reg [16:0] q;


always @(posedge clk or posedge clr)
begin
	// reset condition
	if (clr == 1)
		q <= 0;
	// increment counter by one
	else
		q <= q + 17'b1;
end

//salida del clk 
assign dclk = q[0];

endmodule
