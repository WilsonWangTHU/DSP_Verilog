library verilog;
use verilog.vl_types.all;
entity CommModem is
    port(
        origin          : in     vl_logic_vector(3 downto 0);
        received        : in     vl_logic_vector(7 downto 0);
        sys_clk         : in     vl_logic;
        reset           : in     vl_logic;
        sent            : out    vl_logic_vector(7 downto 0);
        led_1           : out    vl_logic_vector(7 downto 0);
        led_2           : out    vl_logic_vector(7 downto 0)
    );
end CommModem;
