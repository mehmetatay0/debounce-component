
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity debounce is
  port (
    clk  : in std_logic  := '0';
    sw_i : in std_logic  := '0';
    led  : out std_logic := '0'
  );
end debounce;

architecture Behavioral of debounce is

  signal previous_values : std_logic_vector (3 downto 0) := (others => '0');
  signal and_o           : std_logic                     := '0';
  signal or_o            : std_logic                     := '0';
  signal sw_o            : std_logic                     := '0';

begin

  process (clk) begin
    if clk'event and clk = '1' then
      previous_values(0) <= sw_i;
      previous_values(1) <= previous_values(0);
      previous_values(2) <= previous_values(1);
      previous_values(3) <= previous_values(2);
    end if;
  end process;

  CONT : process (clk) begin
    if clk'event and clk = '1' then

      if or_o = '0' then
        --
        sw_o <= '0';

      end if;

      if and_o = '1' then
        --
        sw_o <= '1';

      end if;

    end if;
  end process;

  --AND_GATE : process (clk) begin
  --if clk'event and clk = '1' then
  and_o <= previous_values(0) and previous_values(1) and previous_values(2) and previous_values(3);

  --for i in inputs'range loop
  --    result := result and inputs(i);
  --end loop;

  --end if;
  --end process;

  --OR_GATE : process (clk) begin
  --    if clk'event and clk = '1' then
  or_o <= previous_values(0) or previous_values(1) or previous_values(2) or previous_values(3);
  --    end if;
  --end process;

  led <= sw_o;

end Behavioral;