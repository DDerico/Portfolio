library verilog;
use verilog.vl_types.all;
entity sl226 is
    port(
        a               : in     vl_logic_vector(25 downto 0);
        y               : out    vl_logic_vector(27 downto 0)
    );
end sl226;
