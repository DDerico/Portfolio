module testbench2();
  reg         clk, reset;

//hazard unit declarations 
                    reg BranchD;
                    reg [4:0]WriteRegE;
                    reg  MemtoRegE, RegWriteE;
                    reg [4:0] WriteRegM; 
                    reg MemtoRegM, RegWriteM; 
                    reg [4:0] WriteRegW;
                    reg  RegWriteW;
                   reg [4:0] rsD, rtD, rsE, rtE; 

  wire StallF, StallD, ForwardAD, ForwardBD, FlushE;
  wire [1:0] ForwardAE, ForwardBE;


reg StallF_expected, StallD_expected, ForwardAD_expected, ForwardBD_expected, FlushE_expected;
reg [1:0] ForwardAE_expected, ForwardBE_expected;

  reg  [31:0] vectornum, errors;
  reg  [49:0]  testvectors[10000:0];

  // instantiate device under test                
                   
hazard      dut(WriteRegE, WriteRegM, WriteRegW,
                RegWriteE, RegWriteM, RegWriteW,
                MemtoRegE, MemtoRegM,
                rsD, rtD, rsE, rtE, 
                BranchD,
                StallF, StallD, FlushE,
                ForwardAD, ForwardBD,
                ForwardAE, ForwardBE);

  // generate clock
  always 
    begin
      clk = 1; #5; clk = 0; #5;
    end

  // at start of test, load vectors
  // and pulse reset
  initial
    begin
      $readmemb("textvector.tv", testvectors);
      vectornum = 0; errors = 0;
      reset = 1; #27; reset = 0;
    end

  // apply test vectors on rising edge of clk
  always @(posedge clk) 
    begin 
          #1; {WriteRegE, WriteRegM, WriteRegW,
           RegWriteE, RegWriteM, RegWriteW,
           MemtoRegE, MemtoRegM,
           rsD, rtD, rsE, rtE, BranchD,
           StallF_expected, StallD_expected, FlushE_expected,
           ForwardAD_expected, ForwardBD_expected,
           ForwardAE_expected, ForwardBE_expected} = testvectors[vectornum];           
    end

  // check results on falling edge of clk
  always @(negedge clk)
    if (~reset) begin // skip cycles during reset
    // check result  
      if (StallF !== StallF_expected | StallD !== StallD_expected | ForwardAD !== ForwardAD_expected | 
      ForwardBD !== ForwardBD_expected | FlushE !== FlushE_expected | ForwardAE !== ForwardAE_expected |
      ForwardBE !== ForwardBE_expected) begin
    
        $display("Error, %d", vectornum);
	errors = errors + 1;
	$stop;
	
      end
      vectornum = vectornum + 1;
      if (testvectors[vectornum] === 50'bx) begin 
        $display("%d tests completed with %d errors", 
	         vectornum, errors);
        $stop;
      end
    end
endmodule