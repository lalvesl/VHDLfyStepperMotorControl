LIBRARY ieee;
USE IEEE.STD_LOGIC_1164.ALL;
PACKAGE Edge_funcs IS -- sample package declaration
    FUNCTION isUp(SIGNAL arg : BIT) RETURN BOOLEAN;
    FUNCTION isDown(SIGNAL arg : BIT) RETURN BOOLEAN;
    FUNCTION unshift(l : STD_LOGIC_VECTOR; r : INTEGER) RETURN STD_LOGIC_VECTOR;
    FUNCTION shift (l : STD_LOGIC_VECTOR; r : INTEGER) RETURN STD_LOGIC_VECTOR;
END PACKAGE Edge_funcs;

PACKAGE BODY Edge_funcs IS -- corresponding package body
    FUNCTION isUp(SIGNAL arg : BIT) RETURN BOOLEAN IS
    BEGIN
        RETURN (arg'EVENT AND (arg = '1'));
    END FUNCTION;

    FUNCTION isDown (SIGNAL arg : BIT) RETURN BOOLEAN IS
    BEGIN
        RETURN (arg'EVENT AND (arg = '0'));
    END FUNCTION;

    FUNCTION unshift(l : STD_LOGIC_VECTOR; r : INTEGER)
        RETURN STD_LOGIC_VECTOR
        IS
        ALIAS lv : STD_LOGIC_VECTOR (1 TO l'length) IS l;
        VARIABLE result : STD_LOGIC_VECTOR (1 TO l'length);
        CONSTANT rm : INTEGER := r MOD l'length;
    BEGIN
        IF r >= 0 THEN
            result(1 TO l'length - rm) := lv(rm + 1 TO l'length);
            result(l'length - rm + 1 TO l'length) := lv(1 TO rm);
        ELSE
            result := shift(l, -r);
        END IF;
        RETURN result;
    END FUNCTION;

    FUNCTION shift(l : STD_LOGIC_VECTOR; r : INTEGER)
        RETURN STD_LOGIC_VECTOR
        IS
        ALIAS lv : STD_LOGIC_VECTOR (1 TO l'length) IS l;
        VARIABLE result : STD_LOGIC_VECTOR (1 TO l'length) := (OTHERS => '0');
        CONSTANT rm : INTEGER := r MOD l'length;
    BEGIN
        IF r >= 0 THEN
            result(rm + 1 TO l'length) := lv(1 TO l'length - rm);
            result(1 TO rm) := lv(l'length - rm + 1 TO l'length);
        ELSE
            result := unshift(l, -r);
        END IF;
        RETURN result;
    END FUNCTION;
END PACKAGE BODY Edge_funcs;