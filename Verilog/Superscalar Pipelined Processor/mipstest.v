//------------------------------------------------
// mipstest.v
// Testbench MIPS processor
//------------------------------------------------

module testbench();

  reg         clk;
  reg         reset;

  wire [31:0] aluoutODD, writedataODD, readdataODD;
  wire [31:0] aluoutEVEN, writedataEVEN, readdataEVEN;
  wire        memwriteODD, memwriteEVEN;
  wire [7:0]  ledrEVEN, ledrODD;
  wire [15:0] ledr;
  wire 		  key, sw;
  
						
  // instantiate device to be tested
  toppipeline dut	(clk, reset, 
					 readdataODD, writedataODD, 
					 aluoutODD, memwriteODD, 
					 readdataEVEN, writedataEVEN,
					 aluoutEVEN, memwriteEVEN, ledrEVEN,
					 ledrODD, ledr, key, sw);
  
  // initialize test
  initial
    begin
      reset <= 1; # 22; reset <= 0; //#22
    end

  // generate clock to sequence tests
  always
    begin
      clk <= 1; # 5; clk <= 0; # 5;
    end

endmodule