library verilog;
use verilog.vl_types.all;
entity mux8 is
    port(
        d0              : in     vl_logic;
        d1              : in     vl_logic;
        d2              : in     vl_logic;
        d3              : in     vl_logic;
        d4              : in     vl_logic;
        d5              : in     vl_logic;
        d6              : in     vl_logic;
        d7              : in     vl_logic;
        s               : in     vl_logic_vector(2 downto 0);
        \out\           : out    vl_logic
    );
end mux8;
