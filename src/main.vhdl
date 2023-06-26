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

    COMPONENT stepper IS
        PORT (
            config : IN std_config;
            frequencyOut : IN NATURAL;
            enable : IN BIT;
            switchs_out : OUT STD_LOGIC_VECTOR(0 TO 3)
        );
    END COMPONENT;
    SIGNAL config : std_config;
    SIGNAL frequencyOut : NATURAL := 2000;
    SIGNAL enable : BIT := '1';
    SIGNAL switchs_out : STD_LOGIC_VECTOR(0 TO 3);

BEGIN
    config.clk_in <= clk_pin;
    config.frequencyStd <= 50e6;
    stepperMap : stepper PORT MAP(
        config,
        frequencyOut,
        enable,
        switchs_out
    );

    pmain : PROCESS (clk_pin)
    BEGIN
        s <= switchs_out;
        s2 <= switchs_out;
    END PROCESS;
END;