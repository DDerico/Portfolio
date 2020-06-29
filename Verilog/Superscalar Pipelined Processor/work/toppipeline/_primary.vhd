library verilog;
use verilog.vl_types.all;
entity toppipeline is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        readdataODD     : out    vl_logic_vector(31 downto 0);
        writedataODD    : out    vl_logic_vector(31 downto 0);
        dataadrODD      : out    vl_logic_vector(31 downto 0);
        memwriteODD     : out    vl_logic;
        readdataEVEN    : out    vl_logic_vector(31 downto 0);
        writedataEVEN   : out    vl_logic_vector(31 downto 0);
        dataadrEVEN     : out    vl_logic_vector(31 downto 0);
        memwriteEVEN    : out    vl_logic;
        ledrEVEN        : out    vl_logic_vector(7 downto 0);
        ledrODD         : out    vl_logic_vector(7 downto 0);
        ledr            : out    vl_logic_vector(15 downto 0);
        key             : out    vl_logic;
        sw              : out    vl_logic
    );
end toppipeline;
