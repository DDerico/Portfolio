library verilog;
use verilog.vl_types.all;
entity regfile is
    port(
        clk             : in     vl_logic;
        we3             : in     vl_logic;
        ra1             : in     vl_logic_vector(4 downto 0);
        ra2             : in     vl_logic_vector(4 downto 0);
        wa3             : in     vl_logic_vector(4 downto 0);
        wd3             : in     vl_logic_vector(31 downto 0);
        rd1             : out    vl_logic_vector(31 downto 0);
        rd2             : out    vl_logic_vector(31 downto 0);
        we6             : in     vl_logic;
        ra4             : in     vl_logic_vector(4 downto 0);
        ra5             : in     vl_logic_vector(4 downto 0);
        wa6             : in     vl_logic_vector(4 downto 0);
        wd6             : in     vl_logic_vector(31 downto 0);
        rd4             : out    vl_logic_vector(31 downto 0);
        rd5             : out    vl_logic_vector(31 downto 0)
    );
end regfile;
