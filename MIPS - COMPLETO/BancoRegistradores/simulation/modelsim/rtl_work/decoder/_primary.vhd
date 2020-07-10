library verilog;
use verilog.vl_types.all;
entity decoder is
    port(
        sel             : in     vl_logic_vector(4 downto 0);
        Y               : out    vl_logic_vector(31 downto 0)
    );
end decoder;
