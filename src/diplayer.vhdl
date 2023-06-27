LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
LIBRARY work;
USE work.Edge_funcs.ALL;
USE work.std_configs.ALL;

ENTITY displayer IS
    PORT (
        enable : IN BIT;
        number : IN NATURAL;
        seg : OUT STD_LOGIC_VECTOR(57 DOWNTO 0)
    );
END ENTITY displayer;

ARCHITECTURE adisplayer OF displayer IS

    -- COMPONENT frequencer IS
    --     PORT (
    --         config : IN std_config;
    --         frequencyOut : IN NATURAL;
    --         clk_out : OUT BIT
    --     );
    -- END COMPONENT;
    -- SIGNAL clk_out : BIT;
    -- SIGNAL frequency : NATURAL;

    TYPE mapperSegment IS ARRAY (0 TO 9) OF STD_LOGIC_VECTOR(6 DOWNTO 0);
    CONSTANT mapper : mapperSegment :=
    ("1000000", -- 0
    "1111001", -- 1
    "0100100", -- 2
    "0110000", -- 3
    "0011001", -- 4
    "0010010", -- 5
    "0000010", -- 6
    "1111000", -- 7
    "0000000", -- 8
    "0010000"); -- 9
    -- ("0000001", -- 0
    -- "1001111", -- 1
    -- "0010010", -- 2
    -- "0000110", -- 3
    -- "1001100", -- 4
    -- "0100100", -- 5
    -- "0100000", -- 6
    -- "0001111", -- 7
    -- "0000000", -- 8
    -- "0000100"); -- 9
    SIGNAL subSeg : STD_LOGIC_VECTOR(57 DOWNTO 0);
    SIGNAL subNumber : NATURAL;
    SIGNAL display : STD_LOGIC_VECTOR(6 DOWNTO 0);
    SIGNAL state : STD_LOGIC := '1';
    SIGNAL which : NATURAL;
    SIGNAL ddisplay : mapperSegment;
BEGIN
    PROCESS (enable, number)
    BEGIN
        IF enable = '1' THEN
            subNumber <= number;
            FOR i IN 0 TO 5 LOOP
                ddisplay(i) <= mapper((subNumber/(10 ** i)) MOD 10);
            END LOOP;

            subSeg <= "1" & ddisplay(5) & "111" & ddisplay(4) & "111" & ddisplay(3) & "111" & ddisplay(2) & "111" & ddisplay(1) & "111" & ddisplay(0);

            -- FOR i IN 0 TO 4 LOOP
            --     display <= mapper(i);--(number/(10**i)) MOD 10);
            --     FOR j IN 0 TO 6 LOOP
            --         subSeg((i * 10) + j) <= display(6 - j);
            --     END LOOP;
            -- END LOOP;

            ELSE
            FOR i IN 0 TO (subSeg'length - 1) LOOP
                subSeg(i) <= '1';
            END LOOP;
        END IF;
    END PROCESS;
    seg <= subSeg;
END ARCHITECTURE adisplayer;