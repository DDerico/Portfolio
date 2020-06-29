library verilog;
use verilog.vl_types.all;
entity maindec is
    port(
        op              : in     vl_logic_vector(5 downto 0);
        regwrited       : out    vl_logic;
        memtoregd       : out    vl_logic;
        memwrited       : out    vl_logic;
        alusrcd         : out    vl_logic;
        regdstd         : out    vl_logic;
        branchd         : out    vl_logic;
        jumpd           : out    vl_logic;
        aluop           : out    vl_logic_vector(1 downto 0)
    );
end maindec;
