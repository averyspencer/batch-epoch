@ECHO OFF

SET SECONDS_IN_NORMAL_YEAR=31536000
SET SECONDS_IN_LEAP_YEAR=31622400
SET SECONDS_IN_DAY=86400
SET SECONDS_IN_HOUR=3600
SET SECONDS_IN_MINUTE=60

SET DAYS_IN_JANUARY=31
SET DAYS_IN_FEBRUARY_NORMAL=28
SET DAYS_IN_FEBRUARY_LEAP=29
SET DAYS_IN_MARCH=31
SET DAYS_IN_APRIL=30
SET DAYS_IN_MAY=31
SET DAYS_IN_JUNE=30
SET DAYS_IN_JULY=31
SET DAYS_IN_AUGUST=31
SET DAYS_IN_SEPTEMBER=30
SET DAYS_IN_OCTOBER=31
SET DAYS_IN_NOVEMBER=30
SET DAYS_IN_DECEMBER=31

GOTO :begin

:calc_leap_year
    SET /A "res=cur_year%%4"
    IF %res% == 0 (
        SET /A "res=cur_year%%100"
        IF %res% == 0 (
            SET /A "res=cur_year%%400"
            IF %res% == 0 (
                SET is_leap_year=yes
            ) ELSE (
                SET is_leap_year=no
            )
        ) ELSE (
            SET is_leap_year=yes
        )
    ) ELSE (
        SET is_leap_year=no
    )
EXIT /B 0

:calc_year_left_to_subtract
    CALL :calc_leap_year
    IF %is_leap_year% == no (
        IF %e% GEQ %SECONDS_IN_NORMAL_YEAR% (
            SET is_year_left_to_subtract=yes
        ) ELSE (
            SET is_year_left_to_subtract=no
        )
    ) ELSE (
        IF %e% GEQ %SECONDS_IN_LEAP_YEAR% (
            SET is_year_left_to_subtract=yes
        ) ELSE (
            SET is_year_left_to_subtract=no
        )
    )
EXIT /B 0

:subtract_year
    CALL :calc_leap_year
    IF %is_leap_year% == no (
        SET /A e-=SECONDS_IN_NORMAL_YEAR
    ) ELSE (
        SET /A e-=SECONDS_IN_LEAP_YEAR
    )
EXIT /B 0

:calc_day_left_to_subtract
    IF %e% GEQ %SECONDS_IN_DAY% (
        SET is_day_left_to_subtract=yes
    ) ELSE (
        SET is_day_left_to_subtract=no
    )
EXIT /B 0

:subtract_day
    SET /A e-=SECONDS_IN_DAY
EXIT /B 0

:calc_hour_left_to_subtract
    IF %e% GEQ %SECONDS_IN_HOUR% (
        SET is_hour_left_to_subtract=yes
    ) ELSE (
        SET is_hour_left_to_subtract=no
    )
EXIT /B 0

:subtract_hour
    SET /A e-=SECONDS_IN_HOUR
EXIT /B 0

:calc_minute_left_to_subtract
    IF %e% GEQ %SECONDS_IN_MINUTE% (
        SET is_minute_left_to_subtract=yes
    ) ELSE (
        SET is_minute_left_to_subtract=no
    )
EXIT /B 0

:subtract_minute
    SET /A e-=SECONDS_IN_MINUTE
EXIT /B 0

:calc_month_left_to_subtract
    IF %cur_month% == 1 (
        IF %cur_day% GEQ %DAYS_IN_JANUARY% (
            SET is_month_left_to_subtract=yes
        ) ELSE (
            SET is_month_left_to_subtract=no
        )
    ) ELSE IF %cur_month% == 2 (
        CALL :calc_leap_year
        IF %is_leap_year% == yes (
            IF %cur_day% GEQ %DAYS_IN_FEBRUARY_LEAP% (
                SET is_month_left_to_subtract=yes
            ) ELSE (
                SET is_month_left_to_subtract=no
            )
        ) ELSE (
            IF %cur_day% GEQ %DAYS_IN_FEBRUARY_NORMAL% (
                SET is_month_left_to_subtract=yes
            ) ELSE (
                SET is_month_left_to_subtract=no
            )
        )
    ) ELSE IF %cur_month% == 3 (
        IF %cur_day% GEQ %DAYS_IN_MARCH% (
            SET is_month_left_to_subtract=yes
        ) ELSE (
            SET is_month_left_to_subtract=no
        )
    ) ELSE IF %cur_month% == 4 (
        IF %cur_day% GEQ %DAYS_IN_APRIL% (
            SET is_month_left_to_subtract=yes
        ) ELSE (
            SET is_month_left_to_subtract=no
        )
    ) ELSE IF %cur_month% == 5 (
        IF %cur_day% GEQ %DAYS_IN_MAY% (
            SET is_month_left_to_subtract=yes
        ) ELSE (
            SET is_month_left_to_subtract=no
        )
    ) ELSE IF %cur_month% == 6 (
        IF %cur_day% GEQ %DAYS_IN_JUNE% (
            SET is_month_left_to_subtract=yes
        ) ELSE (
            SET is_month_left_to_subtract=no
        )
    ) ELSE IF %cur_month% == 7 (
        IF %cur_day% GEQ %DAYS_IN_JULY% (
            SET is_month_left_to_subtract=yes
        ) ELSE (
            SET is_month_left_to_subtract=no
        )
    ) ELSE IF %cur_month% == 8 (
        IF %cur_day% GEQ %DAYS_IN_AUGUST% (
            SET is_month_left_to_subtract=yes
        ) ELSE (
            SET is_month_left_to_subtract=no
        )
    ) ELSE IF %cur_month% == 9 (
        IF %cur_day% GEQ %DAYS_IN_SEPTEMBER% (
            SET is_month_left_to_subtract=yes
        ) ELSE (
            SET is_month_left_to_subtract=no
        )
    ) ELSE IF %cur_month% == 10 (
        IF %cur_day% GEQ %DAYS_IN_OCTOBER% (
            SET is_month_left_to_subtract=yes
        ) ELSE (
            SET is_month_left_to_subtract=no
        )
    ) ELSE IF %cur_month% == 11 (
        IF %cur_day% GEQ %DAYS_IN_NOVEMBER% (
            SET is_month_left_to_subtract=yes
        ) ELSE (
            SET is_month_left_to_subtract=no
        )
    ) ELSE (
        IF %cur_day% GEQ %DAYS_IN_DECEMBER% (
            SET is_month_left_to_subtract=yes
        ) ELSE (
            SET is_month_left_to_subtract=no
        )
    )
EXIT /B 0

:subtract_month
    IF %cur_month% == 1 (
        SET /A cur_day-=DAYS_IN_JANUARY
    ) ELSE IF %cur_month% == 2 (
        CALL :calc_leap_year
        IF !is_leap_year! == yes (
            SET /A cur_day-=DAYS_IN_FEBRUARY_LEAP
        ) ELSE (
            SET /A cur_day-=DAYS_IN_FEBRUARY_NORMAL
        )
    ) ELSE IF %cur_month% == 3 (
        SET /A cur_day-=DAYS_IN_MARCH
    ) ELSE IF %cur_month% == 4 (
        SET /A cur_day-=DAYS_IN_APRIL
    ) ELSE IF %cur_month% == 5 (
        SET /A cur_day-=DAYS_IN_MAY
    ) ELSE IF %cur_month% == 6 (
        SET /A cur_day-=DAYS_IN_JUNE
    ) ELSE IF %cur_month% == 7 (
        SET /A cur_day-=DAYS_IN_JULY
    ) ELSE IF %cur_month% == 8 (
        SET /A cur_day-=DAYS_IN_AUGUST
    ) ELSE IF %cur_month% == 9 (
        SET /A cur_day-=DAYS_IN_SEPTEMBER
    ) ELSE IF %cur_month% == 10 (
        SET /A cur_day-=DAYS_IN_OCTOBER
    ) ELSE IF %cur_month% == 11 (
        SET /A cur_day-=DAYS_IN_NOVEMBER
    ) ELSE (
        SET /A cur_day-=DAYS_IN_DECEMBER
    )
EXIT /B 0

:calc_month
    SET cur_month=1
    CALL :calc_month_left_to_subtract
    :calc_month_do_sub
        IF %is_month_left_to_subtract% == yes (
            CALL :subtract_month

            SET /A cur_month+=1
            CALL :calc_month_left_to_subtract
            
            GOTO :calc_month_do_sub
        )
EXIT /B 0

:begin

SET e=%1
SET cur_year=1970

CALL :calc_year_left_to_subtract
:sub_year_loop
    IF %is_year_left_to_subtract% == yes (
        CALL :subtract_year

        SET /A cur_year+=1
        CALL :calc_year_left_to_subtract
        
        GOTO :sub_year_loop
    )

SET cur_day=1
CALL :calc_day_left_to_subtract
:sub_day_loop
    IF %is_day_left_to_subtract% == yes (
        CALL :subtract_day

        SET /A cur_day+=1
        CALL :calc_day_left_to_subtract

        GOTO :sub_day_loop
    )

SET cur_hour=0
CALL :calc_hour_left_to_subtract
:sub_hour_loop
    IF %is_hour_left_to_subtract% == yes (
        CALL :subtract_hour

        SET /A cur_hour+=1
        CALL :calc_hour_left_to_subtract

        GOTO :sub_hour_loop
    )

SET cur_minute=0
CALL :calc_minute_left_to_subtract
:sub_minute_loop
    IF %is_minute_left_to_subtract% == yes (
        CALL :subtract_minute

        SET /A cur_minute+=1
        CALL :calc_minute_left_to_subtract

        GOTO :sub_minute_loop
    )

SET cur_second=%e%

CALL :calc_month

echo Month: %cur_month%
echo Day: %cur_day%
echo Year: %cur_year%
echo Hour: %cur_hour%
echo Minute: %cur_minute%
echo Second: %cur_second%
