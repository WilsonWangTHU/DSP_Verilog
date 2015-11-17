library verilog;
use verilog.vl_types.all;
entity ClkGen is
    port(
        sys_clk         : in     vl_logic;
        reset           : in     vl_logic;
        clk_1           : out    vl_logic;
        clk_2           : out    vl_logic;
        clk_4           : out    vl_logic;
        clk_8           : out    vl_logic;
        clk_16          : out    vl_logic;
        clk_32          : out    vl_logic;
        clk_64          : out    vl_logic;
        clk_128         : out    vl_logic;
        clk_256         : out    vl_logic;
        clk_512         : out    vl_logic;
        clk_30          : out    vl_logic;
        clk_8k          : out    vl_logic;
        clk_slow        : out    vl_logic
    );
end ClkGen;
