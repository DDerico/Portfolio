library verilog;
use verilog.vl_types.all;
entity product_result_MA is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        Y               : in     vl_logic_vector(15 downto 0);
        A               : out    vl_logic_vector(15 downto 0);
        new_Y           : out    vl_logic_vector(15 downto 0)
    );
end product_result_MA;
