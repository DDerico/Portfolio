library verilog;
use verilog.vl_types.all;
entity comparator is
    port(
        a               : in     vl_logic_vector(31 downto 0);
        b               : in     vl_logic_vector(31 downto 0);
        y               : out    vl_logic
    );
end comparator;
