library verilog;
use verilog.vl_types.all;
entity ShiftPC is
    port(
        PC              : in     vl_logic_vector(3 downto 0);
        A               : in     vl_logic_vector(25 downto 0);
        S               : out    vl_logic_vector(31 downto 0)
    );
end ShiftPC;
