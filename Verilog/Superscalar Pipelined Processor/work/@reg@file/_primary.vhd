library verilog;
use verilog.vl_types.all;
entity RegFile is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        bit1            : in     vl_logic;
        bit2            : in     vl_logic;
        bit3            : in     vl_logic;
        bit4            : in     vl_logic;
        nbit1           : out    vl_logic;
        nbit2           : out    vl_logic;
        nbit3           : out    vl_logic;
        nbit4           : out    vl_logic
    );
end RegFile;
