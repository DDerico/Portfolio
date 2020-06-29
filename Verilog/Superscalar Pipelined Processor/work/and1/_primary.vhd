library verilog;
use verilog.vl_types.all;
entity and1 is
    port(
        branchm         : in     vl_logic;
        equald          : in     vl_logic;
        pcsrcd          : out    vl_logic
    );
end and1;
