library verilog;
use verilog.vl_types.all;
entity mipspipeline is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        pcfODD          : out    vl_logic_vector(31 downto 0);
        instrfODD       : in     vl_logic_vector(31 downto 0);
        memwritedODD    : out    vl_logic;
        aluoutmODD      : out    vl_logic_vector(31 downto 0);
        writedataeODD   : out    vl_logic_vector(31 downto 0);
        readdatamODD    : in     vl_logic_vector(31 downto 0);
        writedatamODD   : out    vl_logic_vector(31 downto 0);
        memwritemODD    : out    vl_logic;
        pcfEVEN         : out    vl_logic_vector(31 downto 0);
        instrfEVEN      : in     vl_logic_vector(31 downto 0);
        memwritedEVEN   : out    vl_logic;
        aluoutmEVEN     : out    vl_logic_vector(31 downto 0);
        writedataeEVEN  : out    vl_logic_vector(31 downto 0);
        readdatamEVEN   : in     vl_logic_vector(31 downto 0);
        writedatamEVEN  : out    vl_logic_vector(31 downto 0);
        memwritemEVEN   : out    vl_logic
    );
end mipspipeline;
