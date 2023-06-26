PACKAGE std_configs IS
    TYPE std_config IS RECORD
        clk_in : BIT;
        frequencyStd : NATURAL;
    END RECORD;
END PACKAGE std_configs;