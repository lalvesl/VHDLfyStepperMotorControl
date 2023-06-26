PACKAGE configuratons IS
    TYPE configs IS RECORD
        clk_pin : IN BIT;
        SIGNAL frequencyIn : NATURAL := 5e5;
    END RECORD;
END PACKAGE;