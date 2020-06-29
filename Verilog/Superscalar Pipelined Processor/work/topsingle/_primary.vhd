library verilog;
use verilog.vl_types.all;
entity topsingle is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        readdata        : in     vl_logic_vector(31 downto 0);
        writedata       : out    vl_logic_vector(31 downto 0);
        dataadr         : out    vl_logic_vector(31 downto 0);
        mwM             : out    vl_logic
    );
end topsingle;
