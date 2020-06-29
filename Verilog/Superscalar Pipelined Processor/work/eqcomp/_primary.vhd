library verilog;
use verilog.vl_types.all;
entity eqcomp is
    generic(
        WIDTH           : integer := 32
    );
    port(
        eq1             : in     vl_logic_vector;
        eq2             : in     vl_logic_vector;
        eqd             : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH : constant is 1;
end eqcomp;
