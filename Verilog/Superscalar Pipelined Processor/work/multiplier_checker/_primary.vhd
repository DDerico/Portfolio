library verilog;
use verilog.vl_types.all;
entity multiplier_checker is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        sel             : out    vl_logic_vector(2 downto 0);
        multiplier      : in     vl_logic_vector(3 downto 0);
        flag            : out    vl_logic;
        bit1            : out    vl_logic;
        bit2            : out    vl_logic;
        bit3            : out    vl_logic;
        bit4            : out    vl_logic;
        nbit1           : in     vl_logic;
        nbit2           : in     vl_logic;
        nbit3           : in     vl_logic;
        nbit4           : in     vl_logic
    );
end multiplier_checker;
