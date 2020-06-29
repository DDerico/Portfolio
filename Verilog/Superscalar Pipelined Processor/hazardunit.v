//-----
//hazardunit.v
//Tyler Gardenhire
//-----

module hazardunit (input 		branchd, memtorege, regwritee, 
				   input		memtoregm, regwritem, regwritew,
				   input  [4:0] rsd, rtd, 
				   input  [4:0] rse, rte, 
				   input  [4:0] writerege, writeregm, writeregw,
				   output 		stallf, stalld, flushe,
				   output		forwardad, forwardbd,
				   output [1:0] forwardae, forwardbe);

	wire branchstall;
	wire lwstall;
				
//forward logic
	assign forwardad = (rsd != 0) & (rsd == writeregm) & regwritem;
	assign forwardbd = (rtd != 0) & (rtd == writeregm) & regwritem;
	assign forwardae = ((rse != 0) & (rse == writeregm) & regwritem) ? 2'b10 : ( ((rse != 0) & (rse == writeregw) & regwritew) ? 2'b01 : 2'b00 );
	assign forwardbe = ((rte != 0) & (rte == writeregm) & regwritem) ? 2'b10 : ( ((rte != 0) & (rte == writeregw) & regwritew) ? 2'b01 : 2'b00 );
	
//stall logic
	assign branchstall = branchd & (regwritee & ((writerege == rsd) | (writerege == rtd)) | memtoregm & ((writeregm == rsd) | (writeregm == rtd)));
	assign lwstall = ((rsd == rte) | (rtd == rte)) & memtorege;
	
	assign stallf = lwstall | branchstall;
	assign stalld = lwstall | branchstall;
	assign flushe = lwstall | branchstall;
	
endmodule