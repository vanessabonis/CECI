library verilog;
use verilog.vl_types.all;
entity mux2 is
    port(
        d0              : in     vl_logic;
        d1              : in     vl_logic;
        s               : in     vl_logic;
        y               : out    vl_logic
    );
end mux2;
