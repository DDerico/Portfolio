//-----
// top.v
//-----

module toppipeline(input          clkin, reset,
				   output reg     clk,
				   output [1:0]	  notused,
                   output [31:0]  readdataODD,
                   output [31:0]  writedataODD, dataadrODD, 
                   output         memwriteODD,
				   
				   output [31:0]  readdataEVEN,
				   output [31:0]  writedataEVEN, dataadrEVEN,
				   output		  memwriteEVEN,
				   output [7:0]   ledrEVEN, ledrODD,
				   output [15:0]  LEDR,
				   output         key, sw);
  
	wire [31:0] pcODD, instrODD, pcEVEN, instrEVEN;
	wire [31:0] writedatamEVEN, writedatamODD;
	wire		memwritemEVEN, memwritemODD;
	reg [25:0]  counter;
   
    // using onboard 50mhz clock because of switch/button debouncing
	always @(posedge clkin)
	begin
		if (counter == 0)
			begin
				counter <= 49999999;
				clk <= ~clk;
			end
		else
			begin
				counter <= counter - 1;
			end
	end
	
	// instantiate processor and memories
	mipspipeline mipspipeline (clk, reset, pcODD, instrODD, memwriteODD, dataadrODD, 
                               writedataODD, readdataODD, writedatamODD, memwritemODD,
							   pcEVEN, instrEVEN, memwriteEVEN, dataadrEVEN,
							   writedataEVEN, readdataEVEN, writedatamEVEN, memwritemEVEN);
							  
	imem imem	(pcODD[7:2], pcEVEN[7:2], instrODD, instrEVEN);
	dmem dmem	(clk, memwritemODD, memwritemEVEN, dataadrODD, dataadrEVEN,
	             writedatamODD, writedatamEVEN, readdataODD, readdataEVEN);

	
	// output data to red LEDs
	assign LEDR = {dataadrODD[7:0], dataadrEVEN[7:0]};
	assign key = clk;
	assign sw = reset;
	assign notused = 2'b11;
	
endmodule

