library verilog;
use verilog.vl_types.all;
entity meioSomador is
    port(
        input1          : in     vl_logic;
        input2          : in     vl_logic;
        output_s0       : out    vl_logic;
        cout_0          : out    vl_logic
    );
end meioSomador;
