library ieee;
use ieee.std_logic_1164.all;
entity mux is
    port(
        in1,in2,sel:in std_logic;
        sort :out std_logic
    );
end mux;
architecture mux of mux is
    begin
    sort<= in1 after 2 ns when  sel='0' else in2 after 2 ns;
end mux;