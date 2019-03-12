

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity EX2 is
      Port (
            x1,x2,clk :in std_logic;
            z : out std_logic;
            y : out std_logic_vector(1 downto 0)
             );
end EX2;

architecture EX2_arc of EX2 is
type state is (st0,st1,st2); --st0 = a, st1 = b, st2 = c
signal PS,NS : state;
 
begin
    sync_proc: process(NS, CLK)
    begin
        if rising_edge(clk) then
            PS <= NS;
        end if;
    end process sync_proc;
    
    comb_proc: process(PS, x1, x2) 
    begin
    -- pre-assigned values
    z <= '0';
        case PS is
            when st0 =>
            z <= '0';
                if (x1 = '1') then
                    NS <=st2;
                else NS <= st0;
                end if;
             when st1 =>
                if (x2 = '0') then
                    NS <= st0;
                    z <= '1';
                else 
                    NS <= st1;
                    z <= '0';
                 end if;
             when st2 => 
                 if (x2 = '1') then
                    z <= '0';
                    NS <=st1;
                  else 
                    z <= '1';
                    NS <= st0;
                  end if;
              when others =>
                    z<= '0';
                    NS <= st0;
              end case;
         end process comb_proc;
         
         with PS select
            y <= "10" when st0, "11" when st1, "10" when st2;       
                
end EX2_arc;
