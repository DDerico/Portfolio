library verilog;
use verilog.vl_types.all;
entity flopr2 is
    generic(
        WIDTH           : integer := 32
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        clr             : in     vl_logic;
        en              : in     vl_logic;
        instrF          : in     vl_logic_vector;
        pc4F            : in     vl_logic_vector;
        instrD          : out    vl_logic_vector;
        pc4D            : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH : constant is 1;
end flopr2;
