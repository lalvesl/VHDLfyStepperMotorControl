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
        switch4_pin : IN BIT;
        buttom : IN BIT;
        buttom2 : IN BIT;
        seg : OUT STD_LOGIC_VECTOR(57 DOWNTO 0);
        s : OUT STD_LOGIC_VECTOR(0 TO 3) := "0000";
        s2 : OUT STD_LOGIC_VECTOR(0 TO 3) := "0000"
    );
END main;

ARCHITECTURE amain OF main IS

    COMPONENT configurator IS
        PORT (
            clk_in : IN BIT;
            frequencyStd : IN NATURAL;
            config : OUT std_config
        );
    END COMPONENT;
    SIGNAL config : std_config;

    COMPONENT stepper IS
        PORT (
            config : IN std_config;
            frequencyOut : IN NATURAL;
            enable : IN BIT;
            diraction : IN BIT;
            switchs_out : OUT STD_LOGIC_VECTOR(0 TO 3)
        );
    END COMPONENT;
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

    COMPONENT displayer IS
        PORT (
            enable : IN BIT;
            number : IN NATURAL;
            seg : OUT STD_LOGIC_VECTOR(0 TO 57)
        );
    END COMPONENT;
    SIGNAL displayerNumber : NATURAL;

    SIGNAL counter : NATURAL := 0;

BEGIN
    configuratorMap : configurator PORT MAP(
        clk_in => clk_pin,
        frequencyStd => 50e6,
        config => config
    );

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

    displayerMap : displayer PORT MAP(
        enable => enable,
        number => displayerNumber,
        seg => seg
    );

    pmain : PROCESS (clk_pin, buttom, buttom2)
    BEGIN
        s <= switchs_out;
        s2 <= switchs_out;
        displayerNumber <= frequencyOut;
        IF isUp(buttom) THEN
            counter <= counter + 1;
        END IF;
        IF (switch4_pin = '1') THEN
            displayerNumber <= frequencyOut;
            ELSE
            displayerNumber <= counter;
        END IF;
        IF (buttom2 = '0') THEN
            counter <= 0;
        END IF;
    END PROCESS;
END;