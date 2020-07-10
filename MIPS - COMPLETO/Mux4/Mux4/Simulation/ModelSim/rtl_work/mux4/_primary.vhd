library verilog;
use verilog.vl_types.all;
entity mux4 is
    port(
        d0              : in     vl_logic;
        d1              : in     vl_logic;
        d2              : in     vl_logic;
        d3              : in     vl_logic;
        s0              : in     vl_logic;
        s1              : in     vl_logic;
        y               : out    vl_logic
    );
end mux4;
