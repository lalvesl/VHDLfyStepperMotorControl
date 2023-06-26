LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
LIBRARY work;
USE work.Edge_funcs.ALL;
USE work.std_configs.ALL;

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
            config : IN std_config;
            frequencyOut : IN NATURAL;
            clk_out : OUT BIT
        );
    END COMPONENT;
    SIGNAL config : std_config;
    SIGNAL frequencyOut2 : NATURAL := 2000;
    SIGNAL clk_out2 : BIT;

    SIGNAL state : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0111";
BEGIN
    config.clk_in <= clk_pin;
    config.frequencyStd <= 50e6;
    frequencerMap : frequencer PORT MAP(
        config,
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