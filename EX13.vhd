

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity EX13 is
      Port (
            x1,x2,clk:in std_logic;
            CS,RD : out std_logic;
            y : out std_logic_vector(2 downto 0)
             );
end EX13;

architecture EX13_arc of EX13 is
type state_type is (st0,st1,st2); 
attribute enum_encoding : string; --attribute declaration of user defined attribute
attribute enum_encoding of state_type : type is "100 010 001 "; --attribute specification
signal PS,NS : state_type;

 
begin
    sync_proc: process(NS, CLK)
    begin
        if rising_edge(clk) then
            PS <= NS;
        end if;
    end process sync_proc;
    
    comb_proc: process(PS, x1,x2) 
    begin
    -- pre-assigned values
    CS<= '0'; RD<='0';
        case PS is
            when st0 =>
            
                if (x1 = '1') then
                    NS <=st2;
                    CS <='1'; RD <= '0'; 
                else 
                    NS <= st1;
                    CS <= '0'; RD <= '1';
                end if;
             when st1 =>
             
                    NS <= st2;
                    CS <= '1'; RD <= '1';
                
             when st2 =>
             
                 if (x2 = '0') then
                    CS <= '0'; RD<= '0';
                    NS <= st0;
                  else 
                    CS <= '0'; RD <= '1';
                    NS <= st2;
                  end if;
            
              when others =>
                    CS<= '0';
                    RD <= '0';
                    NS <= st0;
              end case;
         end process comb_proc;
         
         with PS select
            y <= "001" when st0, "010" when st1, "100" when st2;       
                
end EX13_arc;
