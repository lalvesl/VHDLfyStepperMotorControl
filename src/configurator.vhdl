LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
LIBRARY work;
USE work.Edge_funcs.ALL;
USE work.std_configs.ALL;

ENTITY configurator IS
    PORT (
        clk_in : IN BIT;
        frequencyStd : IN NATURAL;
        config : OUT std_config
    );
END configurator;

ARCHITECTURE aconfigurator OF configurator IS
BEGIN
    pconfigurator : PROCESS (clk_in, frequencyStd)
    BEGIN
        config.clk_in <= clk_in;
        config.frequencyStd <= frequencyStd;
    END PROCESS;
END;