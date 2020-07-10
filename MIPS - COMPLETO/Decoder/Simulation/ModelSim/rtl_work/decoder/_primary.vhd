library verilog;
use verilog.vl_types.all;
entity decoder is
    port(
        Sel             : in     vl_logic_vector(4 downto 0);
        Output          : out    vl_logic_vector(31 downto 0)
    );
end decoder;
