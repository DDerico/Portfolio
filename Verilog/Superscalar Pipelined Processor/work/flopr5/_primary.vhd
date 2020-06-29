library verilog;
use verilog.vl_types.all;
entity flopr5 is
    generic(
        WIDTH           : integer := 32
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        rwM             : in     vl_logic;
        mrM             : in     vl_logic;
        rdM             : in     vl_logic_vector;
        alurM           : in     vl_logic_vector;
        wrM             : in     vl_logic_vector(4 downto 0);
        rwW             : out    vl_logic;
        mrW             : out    vl_logic;
        rdW             : out    vl_logic_vector;
        alurW           : out    vl_logic_vector;
        wrW             : out    vl_logic_vector(4 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH : constant is 1;
end flopr5;
