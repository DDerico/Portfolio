library verilog;
use verilog.vl_types.all;
entity ShiftAddMult_Control is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        multiplier      : in     vl_logic_vector(3 downto 0);
        multiplicand    : in     vl_logic_vector(15 downto 0);
        output_product  : out    vl_logic_vector(15 downto 0);
        flag            : out    vl_logic
    );
end ShiftAddMult_Control;
