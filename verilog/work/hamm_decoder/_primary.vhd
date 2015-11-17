library verilog;
use verilog.vl_types.all;
entity hamm_decoder is
    port(
        \out\           : in     vl_logic_vector(7 downto 0);
        \in\            : out    vl_logic_vector(3 downto 0);
        clk             : in     vl_logic;
        reset           : in     vl_logic
    );
end hamm_decoder;
