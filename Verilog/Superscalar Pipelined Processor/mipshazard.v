//-------------------------------------------------
//mipshazard.v
//Hazard unit component for MIPS pipeline processor
//-------------------------------------------------

module hazard(input  [4:0] WriteRegE1, WriteRegM1, WriteRegW1, WriteRegE2, WriteRegM2, WriteRegW2,
              input        RegWriteE1, RegWriteM1, RegWriteW1, RegWriteE2, RegWriteM2, RegWriteW2,
              input        MemtoRegE1, MemtoRegM1, MemtoRegE2, MemtoRegM2,
              input  [4:0] rsD1, rtD1, rsE1, rtE1, rsD2, rtD2, rsE2, rtE2,
              input        BranchD1, BranchD2,
              output       StallF, StallD, FlushE,
              output reg [1:0] ForwardAD1, ForwardBD1, ForwardAD2, ForwardBD2,
              output reg [2:0] ForwardAE1, ForwardBE1, ForwardAE2, ForwardBE2); //Use reg if using the alternative always@ if statements.
  
  
  //Notes for superscalar modification:
  //Stall signals are shared between paths.
  
  wire lwstall;
  wire branchstall;
  
  //Stall detection logic
  assign branchstall=(BranchD1&RegWriteE1&(WriteRegE1==rsD1|WriteRegE1==rtD1))|
					 (BranchD1&MemtoRegM1&(WriteRegM1==rsD1|WriteRegM1==rtD1))|
					 (BranchD2&RegWriteE2&(WriteRegE2==rsD2|WriteRegE2==rtD2))|
					 (BranchD2&MemtoRegM2&(WriteRegM2==rsD2|WriteRegM2==rtD2));
  
  always@(*)
  begin 
  
  //Forwarding logic for SrcAODD
  if((rsE1!=5'b00000) & (rsE1==WriteRegM2) & RegWriteM2) //100: Forward from EVEN Memory stage.
    ForwardAE1=3'b100;
  else if((rsE1!=5'b00000) & (rsE1==WriteRegM1) & RegWriteM1) //010: Forward from ODD Memory stage.
    ForwardAE1=3'b011;
  else if((rsE1!=5'b00000) & (rsE1==WriteRegW2) & RegWriteW2) //011: Forward from EVEN Write stage.
    ForwardAE1=3'b010;
  else if((rsE1!=5'b00000) & (rsE1==WriteRegW1) & RegWriteW1) //001: Forward from ODD Write stage.
    ForwardAE1=3'b001;
  else //000: Use Register File value.
    ForwardAE1=3'b000;
	
	//Forwarding logic for SrcAEVEN
  if((rsE2!=5'b00000)      & (rsE2==WriteRegE1) & RegWriteE1) //101: Forward from ODD Execute stage.
	ForwardAE2=3'b101;
  else if((rsE2!=5'b00000) & (rsE2==WriteRegM2) & RegWriteM2) //010: Forward from EVEN Memory stage.
    ForwardAE2=3'b100;
  else if((rsE2!=5'b00000) & (rsE2==WriteRegM1) & RegWriteM1) //100: Forward from ODD Memory stage.
    ForwardAE2=3'b011;
  else if((rsE2!=5'b00000) & (rsE2==WriteRegW2) & RegWriteW2) //001: Forward from EVEN Write stage.
    ForwardAE2=3'b010;
  else if((rsE2!=5'b00000) & (rsE2==WriteRegW1) & RegWriteW1) //011: Forward from ODD Write stage.
    ForwardAE2=3'b001;
  else //000: Use Register File value.
    ForwardAE2=3'b000;
	
  end
    
  always@(*)
  begin          
  
  //Forwarding logic for SRCBODD
  if((rtE1!=5'b00000) & (rtE1==WriteRegM2) & RegWriteM2) //100: Forward from EVEN Memory stage.
    ForwardBE1=3'b100;
  else if((rtE1!=5'b00000) & (rtE1==WriteRegM1) & RegWriteM1) //010: Forward from ODD Memory stage.
    ForwardBE1=3'b011;
  else if((rtE1!=5'b00000) & (rtE1==WriteRegW2) & RegWriteW2) //011: Forward from EVEN Write stage.
    ForwardBE1=3'b010;
  else if((rtE1!=5'b00000) & (rtE1==WriteRegW1) & RegWriteW1) //001: Forward from ODD Write stage.
    ForwardBE1=3'b001;
  else 														  //000: Use Register File value.
    ForwardBE1=3'b000;
	
	//Forwarding logic for SRCBEVEN
  if((rtE2!=5'b00000)      & (rtE2==WriteRegE1) & RegWriteE1) //101: Forward from ODD Execute stage.
	ForwardBE2=3'b101;
  else if((rtE2!=5'b00000) & (rtE2==WriteRegM2) & RegWriteM2) //010: Forward from EVEN Memory stage.
    ForwardBE2=3'b100;
  else if((rtE2!=5'b00000) & (rtE2==WriteRegM1) & RegWriteM1) //100: Forward from ODD Memory stage.
    ForwardBE2=3'b011;
  else if((rtE2!=5'b00000) & (rtE2==WriteRegW2) & RegWriteW2) //001: Forward from EVEN Write stage.
    ForwardBE2=3'b010;
  else if((rtE2!=5'b00000) & (rtE2==WriteRegW1) & RegWriteW1) //011: Forward from ODD Write stage.
    ForwardBE2=3'b001;
  else 														  //000: Use Register File value.
    ForwardBE2=3'b000;
	
	end
	
  //Logic to computer stalls and FlushEs.  
  assign lwstall=
  ((rsD1==rtE1)|(rtD1==rtE1))&MemtoRegE1|
  ((rsD2==rtE2)|(rtD2==rtE2))&MemtoRegE2;
  
  assign StallF=lwstall|branchstall;
  assign StallD=lwstall|branchstall;
  assign FlushE=lwstall|branchstall;
  
  //Decode stage forwarding logic (ForwardAD1 & ForwardBD1)  
  always@(*)
  begin
  if ((rsD1!=5'b00000)			  & (rsD1==WriteRegE2) & RegWriteE2)
	ForwardAD1=2'b11;
  else if  ((rsD1!=5'b00000)      & (rsD1==WriteRegM2) & RegWriteM2) //10: Forward from EVEN Memory stage.
	ForwardAD1=2'b10;
  else if       ((rsD1!=5'b00000) & (rsD1==WriteRegM1) & RegWriteM1) //01: Forward from ODD Memory stage.
    ForwardAD1=2'b01;
  else															     //00: Use Register File Value
	ForwardAD1=2'b00;

  if ((rsD1!=5'b00000)			  & (rsD2==WriteRegE1) & RegWriteE1)
	ForwardAD2=2'b11;
  else if  ((rsD2!=5'b00000)      & (rsD2==WriteRegM2) & RegWriteM2) //01: Forward from EVEN Memory stage.
    ForwardAD2=2'b10;	
  else if  ((rsD2!=5'b00000)      & (rsD2==WriteRegM1) & RegWriteM1) //10: Forward from ODD Memory stage.
	ForwardAD2=2'b01;	
  else															     //00: Use Register File Value
	ForwardAD2=2'b00;
  end
 
 
  always@(*)
  begin
  if ((rtD1!=5'b00000)			  & (rtD1==WriteRegE2) & RegWriteE2)
	ForwardBD1=2'b11;
  else if  ((rtD1!=5'b00000)      & (rtD1==WriteRegM2) & RegWriteM2) //10: Forward from EVEN Memory stage.
	ForwardBD1=2'b10;
  else if       ((rtD1!=5'b00000) & (rtD1==WriteRegM1) & RegWriteM1) //01: Forward from ODD Memory stage.
    ForwardBD1=2'b01;
  else														         //00: Use Register File Value
	ForwardBD1=2'b00;

  if ((rtD2!=5'b00000)			  & (rtD2==WriteRegE1) & RegWriteE1)
	ForwardBD2=2'b11;
  else if       ((rtD2!=5'b00000) & (rtD2==WriteRegM2) & RegWriteM2) //01: Forward from EVEN Memory stage.
    ForwardBD2=2'b10;	
  else if  ((rtD2!=5'b00000)      & (rtD2==WriteRegM1) & RegWriteM1) //10: Forward from ODD Memory stage.
	ForwardBD2=2'b01;
  else															     //00: Use Register File Value
	ForwardBD2=2'b00;
  end
  
endmodule 