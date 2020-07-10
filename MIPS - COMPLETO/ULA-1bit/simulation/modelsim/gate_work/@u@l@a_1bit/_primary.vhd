library verilog;
use verilog.vl_types.all;
entity ULA_1bit is
    port(
        ALUcontrol      : in     vl_logic_vector(2 downto 0);
        A               : in     vl_logic;
        B               : in     vl_logic;
        cin             : in     vl_logic;
        addSubSignal    : in     vl_logic;
        less            : in     vl_logic;
        set             : out    vl_logic;
        ALUresult       : out    vl_logic;
        cout            : out    vl_logic
    );
end ULA_1bit;
