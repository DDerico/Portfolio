//-----
//mipspipeline.v
//-----

module mipspipeline(input			clk, reset,
					output	[31:0]	pcfODD,
					input	[31:0]	instrfODD,
					output			memwritedODD,
					output	[31:0]	aluoutmODD, writedataeODD,
					input	[31:0]	readdatamODD,
					output  [31:0]  writedatamODD,
					output			memwritemODD,
					
					output	[31:0]	pcfEVEN,
					input	[31:0]	instrfEVEN,
					output			memwritedEVEN,
					output	[31:0]	aluoutmEVEN, writedataeEVEN,
					input	[31:0]	readdatamEVEN,
					output  [31:0]  writedatamEVEN,
					output			memwritemEVEN);
					
	wire 		memtoregdODD, memtoregdEVEN;
	wire 	 	alusrcdODD, alusrcdEVEN;
	wire 	 	regdstdODD, regdstdEVEN;
	wire		regwritedODD, jumpdODD, pcsrcdODD, branchdODD;
	wire		regwritedEVEN, jumpdEVEN, pcsrcdEVEN, branchdEVEN;
	wire [3:0]	alucontroldODD, alucontroldEVEN;
	wire [31:0] instrdODD, instrdEVEN;
	
	controller cODD		(instrdODD[31:26], instrdODD[5:0],
						 regwritedODD, memtoregdODD, memwritedODD,
						 alucontroldODD, alusrcdODD, regdstdODD,
						 branchdODD, jumpdODD, pcsrcdODD);
	controller cEVEN	(instrdEVEN[31:26], instrdEVEN[5:0],
						 regwritedEVEN, memtoregdEVEN, memwritedEVEN,
						 alucontroldEVEN, alusrcdEVEN, regdstdEVEN,
						 branchdEVEN, jumpdEVEN, pcsrcdEVEN);
	
	datapath dp	(clk, reset, pcfODD, instrdODD, aluoutmODD, writedataeODD,
				 readdatamODD, memtoregdODD, pcsrcdODD, alusrcdODD,
				 regdstdODD, regwritedODD, jumpdODD, alucontroldODD,
				 memwritedODD, branchdODD, instrfODD,
				 pcfEVEN, instrdEVEN, aluoutmEVEN, writedataeEVEN,
				 readdatamEVEN, memtoregdEVEN, pcsrcdEVEN, alusrcdEVEN,
				 regdstdEVEN, regwritedEVEN, jumpdEVEN, alucontroldEVEN,
				 memwritedEVEN, branchdEVEN, instrfEVEN,
				 memwritemODD, memwritemEVEN, writedatamODD, writedatamEVEN);
						 
endmodule

//-------------------------------------------------------

module controller(input	[5:0]	op, funct,
				  output		regwrited,
				  output 		memtoregd,
				  output		memwrited,
				  output [3:0]	alucontrold,
				  output 		alusrcd,
				  output 		regdstd,
				  output		branchd,
				  output		jumpd,
				  output		pcsrcd);
				  
	wire [1:0]  aluop;
	
	
	maindec md (op, regwrited, memtoregd, memwrited,
				alusrcd, regdstd, branchd, jumpd, aluop);
				
	aludec  ad (funct, aluop, alucontrold);
	
endmodule

//-------------------------------------------------------

module maindec (input [5:0]	op,
				output		regwrited,
				output		memtoregd,
				output		memwrited,
				output		alusrcd,
				output		regdstd,
				output		branchd,
				output		jumpd,
				output[1:0]	aluop);
	
	reg [8:0]	controls;
	
	assign {regwrited, regdstd, alusrcd,
			branchd, memwrited,
			memtoregd, aluop, jumpd}
			= controls;
			
	always @(*)
		case(op)
			6'b000000: controls <= 9'b110000100; //RTYPE	
			6'b100011: controls <= 9'b101001000; //LW
			6'b101011: controls <= 9'b001010000; //SW
			6'b000100: controls <= 9'b000100010; //BEQ
			6'b001000: controls <= 9'b101000000; //ADDI
			6'b000010: controls <= 9'b000000001; //J
			default:   controls <= 9'bxxxxxxxxx; //???
		endcase
endmodule

//-------------------------------------------------------

module aludec(input		[5:0]	funct,
			  input		[1:0]	aluop,
			  output reg[3:0]	alucontrol);
			  
	always @(*)
		case(aluop)
			2'b00: alucontrol <= 4'b0010;  // add
			2'b01: alucontrol <= 4'b1010;  // sub
			2'b11: alucontrol <= 4'b0000;  // and
			default: case(funct)          // RTYPE
				6'b100000: alucontrol <= 4'b0010; // ADD
				6'b100010: alucontrol <= 4'b1010; // SUB
				6'b100100: alucontrol <= 4'b0000; // AND
				6'b100101: alucontrol <= 4'b0001; // OR
				6'b101010: alucontrol <= 4'b1011; // SLT
				default:   alucontrol <= 4'bxxxx; // ???
			endcase
		endcase
endmodule

//-------------------------------------------------------

module datapath(input		clk, reset,
				output[31:0]pcfODD,
				output [31:0]instrdODD, 
				output[31:0]aluoutmODD, writedataeODD, 
				input [31:0]readdatamODD,
				input 		memtoregdODD, 
				output 		pcsrcdODD,
				input 		alusrcdODD, regdstdODD,
				input		regwritedODD, jumpdODD,
				input [3:0]	alucontroldODD,
				input		memwritedODD, branchdODD,
				input [31:0]instrfODD,
				
				output[31:0]pcfEVEN,
				output [31:0]instrdEVEN, 
				output[31:0]aluoutmEVEN, writedataeEVEN, 
				input [31:0]readdatamEVEN,
				input 		memtoregdEVEN, 
				output 		pcsrcdEVEN,
				input 		alusrcdEVEN, regdstdEVEN,
				input		regwritedEVEN, jumpdEVEN,
				input [3:0]	alucontroldEVEN,
				input		memwritedEVEN, branchdEVEN,
				input [31:0]instrfEVEN,
				input		memwritemODD, memwritemEVEN,
				input [31:0]writedatamODD, writedatamEVEN);
				
			
	wire [31:0] pcnextbrfODD, pcnextbrfEVEN;
	wire [31:0] resultwODD, resultwEVEN;
	
	//f stage
	wire [31:0] pcplus8fODD, pcplus8fEVEN;
	wire [31:0] pcplus4fODD, pcplus4fEVEN;
	wire [31:0] pcnextfODD, pcnextfEVEN;
	wire		stallf;
	
	//d stage
	wire [31:0] pcplus4dODD, pcplus4dEVEN;
	wire [4:0]	rsdODD, rtdODD, rddODD, rsdEVEN, rtdEVEN, rddEVEN;
	wire [31:0] signimmdODD, signimmshdODD, pcbranchdODD, pcjumpdfinalODD;
	wire [31:0] signimmdEVEN, signimmshdEVEN, pcbranchdEVEN, pcjumpdfinalEVEN;
	wire		equaldODD, equaldEVEN;
	wire [31:0]	srcadODD, srcbdODD, srcadequalsODD, srcbdequalsODD;
	wire [31:0]	srcadEVEN, srcbdEVEN, srcadequalsEVEN, srcbdequalsEVEN;
	wire		stalld;
	wire [1:0]	forwardadODD, forwardbdODD;
	wire [1:0]	forwardadEVEN, forwardbdEVEN;
	
	//e stage
	wire		regwriteeODD, memtoregeODD, memwriteeODD;
	wire		regwriteeEVEN, memtoregeEVEN, memwriteeEVEN;
	wire [3:0]  alucontroleODD, alucontroleEVEN;
	wire		alusrceODD, regdsteODD;
	wire		alusrceEVEN, regdsteEVEN;
	wire [31:0]	srcaeODD, srcbeODD, srcaefinalODD, srcbefinalODD;
	wire [31:0]	srcaeEVEN, srcbeEVEN, srcaefinalEVEN, srcbefinalEVEN;
	wire [31:0] signimmeODD;
	wire [4:0]  rseODD, rteODD, rdeODD, writeregeODD;
	wire [2:0]  forwardaeODD, forwardbeODD;
	wire [31:0] signimmeEVEN;
	wire [4:0]  rseEVEN, rteEVEN, rdeEVEN, writeregeEVEN;
	wire [2:0]  forwardaeEVEN, forwardbeEVEN;
	wire		flushe, flusheODD, flusheEVEN;
	
	//m stage
	wire 		regwritemODD, memtoregmODD; //memwritemODD;
	//wire [31:0]	writedatamODD;
	wire [4:0]  writeregmODD;
	wire 		regwritemEVEN, memtoregmEVEN; //memwritemEVEN;
	//wire [31:0]	writedatamEVEN;
	wire [4:0]  writeregmEVEN;
	
	//w stage
	wire		regwritewODD, memtoregwODD;
	wire [31:0]	readdatawODD, aluoutwODD;
	wire [4:0]	writeregwODD;	
	wire [31:0] aluresulteODD;
	wire [27:0] pcjumpdODD;
	wire		regwritewEVEN, memtoregwEVEN;
	wire [31:0]	readdatawEVEN, aluoutwEVEN;
	wire [4:0]	writeregwEVEN;	
	wire [31:0] aluresulteEVEN;
	wire [27:0] pcjumpdEVEN;
	
	//hazardunit
						 
	hazard hu 	(writeregeODD, writeregmODD, writeregwODD,writeregeEVEN, writeregmEVEN, writeregwEVEN,
				 regwriteeODD, regwritemODD, regwritewODD, regwriteeEVEN, regwritemEVEN, regwritewEVEN,
				 memtoregeODD, memtoregmODD, memtoregeEVEN, memtoregmEVEN,
				 rsdODD, rtdODD, rseODD, rteODD, rsdEVEN, rtdEVEN, rseEVEN, rteEVEN,
				 branchdODD, branchdEVEN,
				 stallf, stalld, flushe,
				 forwardadODD, forwardbdODD, forwardadEVEN, forwardbdEVEN,
				 forwardaeODD, forwardbeODD, forwardaeEVEN, forwardbeEVEN);
	
	//next PC ODD logic
	flopenr #(32)	pcregODD	(clk, reset, ~stallf, pcnextfEVEN, pcfODD);
	adder			pcadd1ODD	(pcfODD, 32'b1000, pcplus8fODD);
	sl2				immshODD	(signimmdODD, signimmshdODD);
	adder			pcadd2ODD	(pcplus4dODD, signimmshdODD, pcbranchdODD);
	mux2 #(32)		pcbrmuxODD	(pcplus8fODD, pcbranchdODD, pcsrcdODD, pcnextbrfODD);
	mux2 #(32)		pcjmuxODD	(pcnextbrfEVEN, {pcplus4fODD[31:28],
								 instrdODD[25:0], 2'b00}, jumpdODD, pcnextfODD);
	adder			pcadd3ODD	(pcfODD, 32'b100, pcplus4fODD);
	
	// pc represents ODD datapath, pc+4 represents EVEN datapath
	adder			pcODDtoEVEN	(pcfODD, 32'b100, pcfEVEN);
	
	// next PC EVEN logic
	adder			pcadd1EVEN	(pcfEVEN, 32'b1000, pcplus8fEVEN);
	sl2				immshEVEN	(signimmdEVEN, signimmshdEVEN);
	adder			pcadd2EVEN	(pcplus4dEVEN, signimmshdEVEN, pcbranchdEVEN);
	mux2 #(32)		pcbrmuxEVEN	(pcnextbrfODD, pcbranchdEVEN, pcsrcdEVEN, pcnextbrfEVEN);
	mux2 #(32)		pcjmuxEVEN	(pcnextfODD, {pcplus4fEVEN[31:28],
								 instrdEVEN[25:0], 2'b00}, jumpdEVEN, pcnextfEVEN);
	adder			pcadd3EVEN	(pcfEVEN, 32'b100, pcplus4fEVEN);
						  	
	//ff from f to d stage
	flopenrclr #(64)ftodODD		(clk, reset, ~stalld, pcsrcdODD, pcsrcdEVEN, 
								 {instrfODD, pcplus4fODD},
								 {instrdODD, pcplus4dODD});
	flopenrclr #(64)ftodEVEN	(clk, reset, ~stalld, pcsrcdEVEN, pcsrcdODD,
								 {instrfEVEN, pcplus4fEVEN},
								 {instrdEVEN, pcplus4dEVEN});
						  
	//register file logic
	regfile		rf	(clk, regwritewODD, instrdODD[25:21], instrdODD[20:16],
				     writeregwODD, resultwODD, srcadODD, srcbdODD,
					 regwritewEVEN, instrdEVEN[25:21], instrdEVEN[20:16],
				     writeregwEVEN, resultwEVEN, srcadEVEN, srcbdEVEN);				   				   
		
	//d stage ODD
	comparator 	eqODD 		(srcadequalsODD, srcbdequalsODD, equaldODD);
	signext		seODD		(instrdODD[15:0], signimmdODD);
	mux3 #(32)	srcadmuxODD	(srcadODD, aluoutmODD, aluoutmEVEN, forwardadODD, srcadequalsODD);	
	mux3 #(32)	srcbdmuxODD	(srcbdODD, aluoutmODD, aluoutmEVEN, forwardbdODD, srcbdequalsODD);
	sl226		jshODD		(instrdODD[25:0], pcjumpdODD);
	attach		jfinalODD	(pcjumpdODD, pcplus8fODD, pcjumpdfinalODD);
	and1		a1ODD		(branchdODD, equaldODD, pcsrcdODD);
	assign rsdODD = instrdODD[25:21];
	assign rtdODD = instrdODD[20:16];
	assign rddODD = instrdODD[15:11];
	
	//d stage EVEN
	comparator 	eqEVEN 		(srcadequalsEVEN, srcbdequalsEVEN, equaldEVEN);
	signext		seEVEN		(instrdEVEN[15:0], signimmdEVEN);
	mux3 #(32)	srcadmuxEVEN(srcadEVEN, aluoutmODD, aluoutmEVEN, forwardadEVEN, srcadequalsEVEN);
	mux3 #(32)	srcbdmuxEVEN(srcbdEVEN, aluoutmODD, aluoutmEVEN, forwardbdEVEN, srcbdequalsEVEN);
	sl226		jshEVEN		(instrdEVEN[25:0], pcjumpdEVEN);
	attach		jfinalEVEN	(pcjumpdEVEN, pcplus8fEVEN, pcjumpdfinalEVEN);
	and1		a1EVEN		(branchdEVEN, equaldEVEN, pcsrcdEVEN);	
	assign rsdEVEN = instrdEVEN[25:21];
	assign rtdEVEN = instrdEVEN[20:16];
	assign rddEVEN = instrdEVEN[15:11];

		
	//ff from d to e stage
	floprclr #(111) dtoeODD		(clk, reset,  flushe, flusheEVEN, {srcadODD, srcbdODD, instrdODD[25:21], 
										      instrdODD[20:16], instrdODD[15:11], signimmdODD},
									         {srcaeODD, srcbeODD, rseODD, 		   
										      rteODD, rdeODD, signimmeODD});
	floprclr #(9)	dtoecuODD	(clk, reset,  flushe, flusheEVEN, {regwritedODD, memtoregdODD, 
										      memwritedODD, alucontroldODD, 
 										      alusrcdODD, regdstdODD},		   
										     {regwriteeODD, memtoregeODD, 
										      memwriteeODD, alucontroleODD,
										      alusrceODD, regdsteODD});
	
	floprclr #(111) dtoeEVEN	(clk, reset,  flushe, flusheODD, {srcadEVEN, srcbdEVEN, instrdEVEN[25:21], 
										      instrdEVEN[20:16], instrdEVEN[15:11], signimmdEVEN},
										     {srcaeEVEN, srcbeEVEN, rseEVEN, 		   
										      rteEVEN, rdeEVEN, signimmeEVEN});
	floprclr #(9)	dtoecuEVEN	(clk, reset,  flushe, flusheODD, {regwritedEVEN, memtoregdEVEN, 
										      memwritedEVEN, alucontroldEVEN, 
										      alusrcdEVEN, regdstdEVEN},		   
										     {regwriteeEVEN, memtoregeEVEN, 
										      memwriteeEVEN, alucontroleEVEN,
										      alusrceEVEN, regdsteEVEN});
											  
	// extra flush in case there is a jump in the current ODD datapath
	assign flusheODD = pcsrcdODD|jumpdODD;
				   
	// e stage ODD
	mux5 #(32)		srcaemuxODD	(srcaeODD, resultwODD, resultwEVEN, aluoutmODD, aluoutmEVEN, forwardaeODD, srcaefinalODD);	
	mux5 #(32)		srcbemuxODD	(srcbeODD, resultwODD, resultwEVEN, aluoutmODD, aluoutmEVEN, forwardbeODD, writedataeODD);
	mux2 #(32)		srcbemux2ODD(writedataeODD, signimmeODD, alusrceODD, srcbefinalODD);
	mux2 #(5)		regmuxODD	(rteODD, rdeODD, regdsteODD, writeregeODD);
	alu				aluODD		(srcaefinalODD, srcbefinalODD, alucontroleODD, instrdODD[10:6], aluresulteODD);
	
	// estage EVEN
	mux6 #(32)		srcaemuxEVEN (srcaeEVEN, resultwODD, resultwEVEN, aluoutmODD, aluoutmEVEN, aluresulteODD, forwardaeEVEN, srcaefinalEVEN);	
	mux6 #(32)		srcbemuxEVEN (srcbeEVEN, resultwODD, resultwEVEN, aluoutmODD, aluoutmEVEN, aluresulteODD, forwardbeEVEN, writedataeEVEN);	
	mux2 #(32)		srcbemux2EVEN(writedataeEVEN, signimmeEVEN, alusrceEVEN, srcbefinalEVEN);
	mux2 #(5)		regmuxEVEN	 (rteEVEN, rdeEVEN, regdsteEVEN, writeregeEVEN);
	alu				aluEVEN		 (srcaefinalEVEN, srcbefinalEVEN, alucontroleEVEN, instrdEVEN[10:6], aluresulteEVEN);
							
	// ff from e to m stage
	flopr #(69)		etomODD		(clk, reset, {aluresulteODD, writedataeODD, writeregeODD},
											 {aluoutmODD,    writedatamODD, writeregmODD});
	flopr #(3)		etomcuODD	(clk, reset, {regwriteeODD, memtoregeODD, memwriteeODD},
											 {regwritemODD, memtoregmODD, memwritemODD});
									   
	flopr #(69)		etomEVEN	(clk, reset, {aluresulteEVEN, writedataeEVEN, writeregeEVEN},
											 {aluoutmEVEN,    writedatamEVEN, writeregmEVEN});
	flopr #(3)		etomcuEVEN	(clk, reset, {regwriteeEVEN, memtoregeEVEN, memwriteeEVEN},
											 {regwritemEVEN, memtoregmEVEN, memwritemEVEN});
									 									 
	//m stage
		
	//ff from m to w stage
	flopr #(69)		mtowODD		(clk, reset, {readdatamODD, aluoutmODD, writeregmODD},
											 {readdatawODD, aluoutwODD, writeregwODD});
	flopr #(2)		mtowcuODD	(clk, reset, {regwritemODD, memtoregmODD},
											 {regwritewODD, memtoregwODD});
									   
	flopr #(69)		mtowEVEN	(clk, reset, {readdatamEVEN, aluoutmEVEN, writeregmEVEN},
											 {readdatawEVEN, aluoutwEVEN, writeregwEVEN});
	flopr #(2)		mtowcuEVEN	(clk, reset, {regwritemEVEN, memtoregmEVEN},
											 {regwritewEVEN, memtoregwEVEN});
									 									 
	//w stage
	mux2 #(32)		resultmuxODD	(aluoutwODD, readdatawODD, memtoregwODD, resultwODD);	
	mux2 #(32)		resultmuxEVEN	(aluoutwEVEN, readdatawEVEN, memtoregwEVEN, resultwEVEN);	
	
endmodule