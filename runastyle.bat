@REM Script to run AStyle on the sources
@REM The version check in this script is used to avoid commit battles
@REM between different developers that use different astyle versions as
@REM different versions might have different output (this has happened in
@REM the past).

@REM If project management wishes to take a newer astyle version into use
@REM just change this string to match the start of astyle version string.
@SET ASTYLE_VERSION="Artistic Style Version 3.0.1"
@SET ASTYLE="astyle"

@SET DETECTED_VERSION=""
@FOR /F "tokens=*" %%i IN ('%ASTYLE% --version') DO SET DETECTED_VERSION=%%i
@ECHO %DETECTED_VERSION% | FINDSTR /B /C:%ASTYLE_VERSION% > nul && (
    ECHO "%DETECTED_VERSION%" matches %ASTYLE_VERSION%
) || (
    ECHO You should use: %ASTYLE_VERSION%
    ECHO Detected: "%DETECTED_VERSION%"
    GOTO EXIT_ERROR
)

@SET STYLE=--style=kr --indent=spaces=4 --indent-namespaces --lineend=linux --min-conditional-indent=0
@SET OPTIONS=--pad-header --unpad-paren --suffix=none --convert-tabs --attach-inlines --attach-classes --attach-namespaces

%ASTYLE% %STYLE% %OPTIONS% *.cpp
%ASTYLE% %STYLE% %OPTIONS% *.h