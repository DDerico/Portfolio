library verilog;
use verilog.vl_types.all;
entity flopr3 is
    generic(
        WIDTH           : integer := 32
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        clr             : in     vl_logic;
        rwD             : in     vl_logic;
        mrD             : in     vl_logic;
        mwD             : in     vl_logic;
        alucD           : in     vl_logic_vector(3 downto 0);
        alusD           : in     vl_logic;
        regdD           : in     vl_logic;
        srcaD           : in     vl_logic_vector;
        wdD             : in     vl_logic_vector;
        rsD             : in     vl_logic_vector(4 downto 0);
        rtD             : in     vl_logic_vector(4 downto 0);
        rdD             : in     vl_logic_vector(4 downto 0);
        siD             : in     vl_logic_vector;
        aluinstrD       : in     vl_logic_vector(4 downto 0);
        rwE             : out    vl_logic;
        mrE             : out    vl_logic;
        mwE             : out    vl_logic;
        alucE           : out    vl_logic_vector(3 downto 0);
        alusE           : out    vl_logic;
        regdE           : out    vl_logic;
        srcaE           : out    vl_logic_vector;
        wdE             : out    vl_logic_vector;
        rsE             : out    vl_logic_vector(4 downto 0);
        rtE             : out    vl_logic_vector(4 downto 0);
        rdE             : out    vl_logic_vector(4 downto 0);
        siE             : out    vl_logic_vector;
        aluinstrE       : out    vl_logic_vector(4 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH : constant is 1;
end flopr3;
