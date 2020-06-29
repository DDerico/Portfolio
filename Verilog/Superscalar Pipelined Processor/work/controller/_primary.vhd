library verilog;
use verilog.vl_types.all;
entity controller is
    port(
        op              : in     vl_logic_vector(5 downto 0);
        funct           : in     vl_logic_vector(5 downto 0);
        regwrited       : out    vl_logic;
        memtoregd       : out    vl_logic;
        memwrited       : out    vl_logic;
        alucontrold     : out    vl_logic_vector(3 downto 0);
        alusrcd         : out    vl_logic;
        regdstd         : out    vl_logic;
        branchd         : out    vl_logic;
        jumpd           : out    vl_logic;
        pcsrcd          : out    vl_logic
    );
end controller;
