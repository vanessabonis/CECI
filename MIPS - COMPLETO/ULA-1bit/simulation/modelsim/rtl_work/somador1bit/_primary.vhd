library verilog;
use verilog.vl_types.all;
entity somador1bit is
    port(
        inputA          : in     vl_logic;
        inputB          : in     vl_logic;
        cin             : in     vl_logic;
        output_s        : out    vl_logic;
        cout            : out    vl_logic
    );
end somador1bit;
