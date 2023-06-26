LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
LIBRARY work;
USE work.Edge_funcs.ALL;
USE work.std_configs.ALL;

ENTITY main IS
    PORT (
        clk_pin : IN BIT;
        switch1_pin : IN BIT;
        switch2_pin : IN BIT;
        switch3_pin : IN BIT;
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
            diraction : IN BIT;
            switchs_out : OUT STD_LOGIC_VECTOR(0 TO 3)
        );
    END COMPONENT;
    SIGNAL config : std_config;
    SIGNAL frequencyOut : NATURAL := 2000;
    SIGNAL enable : BIT := '1';
    SIGNAL switchs_out : STD_LOGIC_VECTOR(0 TO 3);

    COMPONENT numberIncDec IS
        PORT (
            config : IN std_config;
            switchHigh : IN BIT;
            switchLow : IN BIT;
            numberMax : IN NATURAL;
            numberMin : IN NATURAL;
            numberOut : OUT NATURAL
        );
    END COMPONENT;

    CONSTANT numberMax : NATURAL := 100000;
    CONSTANT numberMin : NATURAL := 0;
    SIGNAL numberOut : NATURAL;
BEGIN
    config.clk_in <= clk_pin;
    config.frequencyStd <= 50e6;

    stepperMap : stepper PORT MAP(
        config => config,
        frequencyOut => frequencyOut,
        enable => enable,
        diraction => switch3_pin,
        switchs_out => switchs_out
    );

    numberIncDecMap : numberIncDec PORT MAP(
        config,
        switchHigh => switch1_pin,
        switchLow => switch2_pin,
        numberMax => numberMax,
        numberMin => numberMin,
        numberOut => frequencyOut
    );

    pmain : PROCESS (clk_pin)
    BEGIN
        s <= switchs_out;
        s2 <= switchs_out;
    END PROCESS;
END;