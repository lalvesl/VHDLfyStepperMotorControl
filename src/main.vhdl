LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
LIBRARY work;
USE work.edge_funcs.ALL;
-- use work.configurations.All;

ENTITY main IS
    PORT (
        clk_pin : IN BIT;
        s : OUT STD_LOGIC_VECTOR(0 TO 3) := "0000";
        s2 : OUT STD_LOGIC_VECTOR(0 TO 3) := "0000"
    );
END main;

ARCHITECTURE amain OF main IS

    COMPONENT frequencer IS
        PORT (
            clk_in : IN BIT;
            frequencyIn : IN NATURAL;
            frequencyOut : IN NATURAL;
            clk_out : OUT BIT
        );
    END COMPONENT;
    SIGNAL frequencyIn : NATURAL := 50e6;
    SIGNAL frequencyOut2 : NATURAL := 2000;
    SIGNAL clk_out2 : BIT;

    SIGNAL state : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0111";
BEGIN

    frequencerMap : frequencer PORT MAP(
        clk_in => clk_pin,
        frequencyIn => frequencyIn,
        frequencyOut => frequencyOut2,
        clk_out => clk_out2
    );

    pmain : PROCESS (clk_pin)
    BEGIN
        IF isUp(clk_out2) THEN
            state <= shift(state, 1);
            s <= state;
            s2 <= state;
        END IF;
    END PROCESS;
END;