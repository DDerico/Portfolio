library verilog;
use verilog.vl_types.all;
entity alu_MA is
    port(
        A               : in     vl_logic_vector(15 downto 0);
        B               : inout  vl_logic_vector(15 downto 0);
        F               : in     vl_logic_vector(1 downto 0);
        count           : in     vl_logic_vector(3 downto 0);
        stop            : in     vl_logic_vector(3 downto 0);
        Y               : out    vl_logic_vector(15 downto 0)
    );
end alu_MA;
