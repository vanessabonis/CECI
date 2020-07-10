library verilog;
use verilog.vl_types.all;
entity bancoRegistradores is
    port(
        A1              : in     vl_logic_vector(0 to 4);
        A2              : in     vl_logic_vector(0 to 4);
        A3              : in     vl_logic_vector(4 downto 0);
        WD3             : in     vl_logic;
        WE3             : in     vl_logic;
        ck              : in     vl_logic;
        reset_banco     : in     vl_logic;
        RD1             : out    vl_logic;
        RD2             : out    vl_logic
    );
end bancoRegistradores;
