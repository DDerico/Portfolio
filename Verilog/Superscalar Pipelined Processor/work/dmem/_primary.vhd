library verilog;
use verilog.vl_types.all;
entity dmem is
    port(
        clk             : in     vl_logic;
        wea             : in     vl_logic;
        web             : in     vl_logic;
        a               : in     vl_logic_vector(31 downto 0);
        b               : in     vl_logic_vector(31 downto 0);
        wda             : in     vl_logic_vector(31 downto 0);
        wdb             : in     vl_logic_vector(31 downto 0);
        rda             : out    vl_logic_vector(31 downto 0);
        rdb             : out    vl_logic_vector(31 downto 0)
    );
end dmem;
