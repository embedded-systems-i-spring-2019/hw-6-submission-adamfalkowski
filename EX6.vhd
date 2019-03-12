

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity EX6 is
      Port (
            x,clk:in std_logic;
            z1,z2 : out std_logic;
            y : out std_logic_vector(1 downto 0)
             );
end EX6;

architecture EX6_arc of EX6 is
type state is (st0,st1,st2,st3); --st0 = 00, st1 = 01, st2 = 10, st3 = 11;
signal PS,NS : state;
 
begin
    sync_proc: process(NS, CLK)
    begin
        if rising_edge(clk) then
            PS <= NS;
        end if;
    end process sync_proc;
    
    comb_proc: process(PS, x) 
    begin
    -- pre-assigned values
    z1<= '0'; z2<='0';
        case PS is
            when st0 =>
            z1 <= '1';
                if (x = '0') then
                    NS <=st2;
                    z2<='1';
                else 
                    NS <= st0;
                    z2 <= '0';
                end if;
             when st1 =>
             z1 <= '0';
                if (x = '0') then
                    NS <= st3;
                    z2 <= '0';
                else 
                    NS <= st1;
                    z2 <= '0';
                 end if;
             when st2 =>
             z1 <= '1'; 
                 if (x = '1') then
                    z2 <= '0';
                    NS <=st0;
                  else 
                    z2 <= '0';
                    NS <= st1;
                  end if;
             when st3 =>
             z1 <= '0'; 
                 if (x = '1') then
                    z2 <= '0';
                    NS <=st1;
                  else 
                    z2 <= '1';
                    NS <= st0;
                  end if;
              when others =>
                    z1<= '0';
                    z2 <= '0';
                    NS <= st0;
              end case;
         end process comb_proc;
         
         with PS select
            y <= "00" when st0, "01" when st1, "10" when st2, "11" when st3;       
                
end EX6_arc;
