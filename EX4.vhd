

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity EX4 is
      Port (
            x1,x2,clk,INIT :in std_logic;
            z1,z2 : out std_logic;
            y : out std_logic_vector(1 downto 0)
             );
end EX4;

architecture EX4_arc of EX4 is
type state is (st0,st1,st2); --st0 = a, st1 = b, st2 = c
signal PS,NS : state;
 
begin
    sync_proc: process(NS, CLK, INIT)
    begin
        if (INIT = '1') then
            PS <= st0;
        elsif rising_edge(clk) then
            PS <= NS;
        end if;
    end process sync_proc;
    
    comb_proc: process(PS, x1, x2) 
    begin
    -- pre-assigned values
    z1<= '0'; z2<='0';
        case PS is
            when st0 =>
            z1 <= '0';
                if (x1 = '1') then
                    NS <=st1;
                    z2<='1';
                else NS <= st2;
                end if;
             when st1 =>
             z1 <= '1';
                if (x2 = '1') then
                    NS <= st0;
                    z2 <= '0';
                else 
                    NS <= st2;
                    z2 <= '1';
                 end if;
             when st2 =>
             z1 <= '1'; 
                 if (x1 = '1') then
                    z2 <= '1';
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
            y <= "00" when st0, "01" when st1, "10" when st2;       
                
end EX4_arc;
