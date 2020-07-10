library verilog;
use verilog.vl_types.all;
entity tristate is
    port(
        a               : in     vl_logic;
        en              : in     vl_logic;
        y               : out    vl_logic
    );
end tristate;
