library verilog;
use verilog.vl_types.all;
entity alu is
    port(
        A               : in     vl_logic_vector(31 downto 0);
        B               : in     vl_logic_vector(31 downto 0);
        F               : in     vl_logic_vector(3 downto 0);
        shamt           : in     vl_logic_vector(4 downto 0);
        Y               : out    vl_logic_vector(31 downto 0)
    );
end alu;
