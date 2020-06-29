library verilog;
use verilog.vl_types.all;
entity hazardunit is
    port(
        branchd         : in     vl_logic;
        memtorege       : in     vl_logic;
        regwritee       : in     vl_logic;
        memtoregm       : in     vl_logic;
        regwritem       : in     vl_logic;
        regwritew       : in     vl_logic;
        rsd             : in     vl_logic_vector(4 downto 0);
        rtd             : in     vl_logic_vector(4 downto 0);
        rse             : in     vl_logic_vector(4 downto 0);
        rte             : in     vl_logic_vector(4 downto 0);
        writerege       : in     vl_logic_vector(4 downto 0);
        writeregm       : in     vl_logic_vector(4 downto 0);
        writeregw       : in     vl_logic_vector(4 downto 0);
        stallf          : out    vl_logic;
        stalld          : out    vl_logic;
        flushe          : out    vl_logic;
        forwardad       : out    vl_logic;
        forwardbd       : out    vl_logic;
        forwardae       : out    vl_logic_vector(1 downto 0);
        forwardbe       : out    vl_logic_vector(1 downto 0)
    );
end hazardunit;
