LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY stepper IS
    PORT (
        state : IN STD_LOGIC_VECTOR(0 TO 3);
        switchs : OUT STD_LOGIC_VECTOR(0 TO 3)
    );
END;

ARCHITECTURE astepper OF stepper IS

COMPONENT frequencer IS
PORT (
    frequency : IN NATURAL;
    clk_out : OUT BIT
);
END COMPONENT;
SIGNAL frequencyIn : NATURAL := 50e6;
SIGNAL frequencyOut2 : NATURAL := 2000;
SIGNAL clk_out2 : BIT;
    SIGNAL subState : STD_LOGIC_VECTOR(0 TO 1);
BEGIN
pstepper: process 
begin
    subState <= state(0) & state(1);
    end process;
END;