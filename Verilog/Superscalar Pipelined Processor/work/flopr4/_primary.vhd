library verilog;
use verilog.vl_types.all;
entity flopr4 is
    generic(
        WIDTH           : integer := 32
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        rwE             : in     vl_logic;
        mrE             : in     vl_logic;
        mwE             : in     vl_logic;
        alurE           : in     vl_logic_vector;
        wdE             : in     vl_logic_vector;
        wrE             : in     vl_logic_vector(4 downto 0);
        rwM             : out    vl_logic;
        mrM             : out    vl_logic;
        mwM             : out    vl_logic;
        alurM           : out    vl_logic_vector;
        wdM             : out    vl_logic_vector;
        wrM             : out    vl_logic_vector(4 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH : constant is 1;
end flopr4;
