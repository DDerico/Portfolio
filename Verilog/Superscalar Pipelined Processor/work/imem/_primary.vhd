library verilog;
use verilog.vl_types.all;
entity imem is
    port(
        a               : in     vl_logic_vector(5 downto 0);
        b               : in     vl_logic_vector(5 downto 0);
        rda             : out    vl_logic_vector(31 downto 0);
        rdb             : out    vl_logic_vector(31 downto 0)
    );
end imem;
