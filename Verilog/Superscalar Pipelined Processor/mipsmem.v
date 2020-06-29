//-----
//mipsmem.v
//-----

module dmem(input         clk, wea, web,
            input  [31:0] a, b, wda, wdb,
            output [31:0] rda, rdb);

	reg  [31:0] RAM[63:0];

	assign rda = RAM[a[31:2]]; // word aligned
	assign rdb = RAM[b[31:2]];
	always @(posedge clk)
	begin
		if (wea)
			RAM[a[31:2]] <= wda;
		if (web)
			RAM[b[31:2]] <= wdb;
	end
endmodule

//-------------------------------------------------------

module imem(input  [5:0] a, b,
            output [31:0] rda, rdb);

	reg  [31:0] RAM[63:0];

	initial
		begin
			$readmemh("memfile.dat",RAM);
		end
		
	assign rda = RAM[a]; // word aligned
	assign rdb = RAM[b];
	
endmodule
