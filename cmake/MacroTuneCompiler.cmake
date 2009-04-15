# Adds flag to compiler if it supports it
INCLUDE(CheckCSourceCompiles)

MACRO (X_CHECK_C_COMPILER_FLAG _FLAG _RESULT)
   SET(SAFE_CMAKE_REQUIRED_DEFINITIONS "${CMAKE_REQUIRED_DEFINITIONS}")
   SET(CMAKE_REQUIRED_DEFINITIONS "${_FLAG}")
   CHECK_C_SOURCE_COMPILES("int main(void) { return 0;}" ${_RESULT})
   SET (CMAKE_REQUIRED_DEFINITIONS "${SAFE_CMAKE_REQUIRED_DEFINITIONS}")
ENDMACRO (X_CHECK_C_COMPILER_FLAG)


macro (MACRO_TUNE_COMPILER _flag)
    string (TOUPPER "${_flag}" FLAGNAME)
    string (REPLACE " " "_" FLAGNAME "${FLAGNAME}")
    string (REPLACE "-" "_" FLAGNAME "${FLAGNAME}")
    string (REPLACE "=" "_" FLAGNAME "${FLAGNAME}")
    string (REPLACE "," "_" FLAGNAME "${FLAGNAME}")
    string (REPLACE "/" "_" FLAGNAME "${FLAGNAME}")
    string (REPLACE "." "_" FLAGNAME "${FLAGNAME}")
    set (FLAGNAME "COMPILER_HAS${FLAGNAME}")
    x_check_c_compiler_flag("${_flag}" ${FLAGNAME})
    if (${FLAGNAME})
        set (CMAKE_C_FLAGS     "${CMAKE_C_FLAGS} ${_flag}")
    endif (${FLAGNAME})
endmacro (MACRO_TUNE_COMPILER)

macro (MACRO_TUNE_LINKER _flag)
    string (TOUPPER "${_flag}" FLAGNAME)
    string (REPLACE " " "_" FLAGNAME "${FLAGNAME}")
    string (REPLACE "-" "_" FLAGNAME "${FLAGNAME}")
    string (REPLACE "=" "_" FLAGNAME "${FLAGNAME}")
    string (REPLACE "," "_" FLAGNAME "${FLAGNAME}")
    string (REPLACE "/" "_" FLAGNAME "${FLAGNAME}")
    string (REPLACE "." "_" FLAGNAME "${FLAGNAME}")
    set (FLAGNAME "LINKER_HAS${FLAGNAME}")
    set (OLD_CMAKE_REQUIRED_FLAGS "${CMAKE_REQUIRED_FLAGS}")
    set (CMAKE_REQUIRED_FLAGS "${_flag}")
    x_check_c_compiler_flag("${_flag}" ${FLAGNAME})
    set (CMAKE_REQUIRED_FLAGS "${OLD_CMAKE_REQUIRED_FLAGS}")
    if (${FLAGNAME})
        set (CMAKE_C_LINK_FLAGS "${CMAKE_C_LINK_FLAGS} ${_flag}")
    endif (${FLAGNAME})
endmacro (MACRO_TUNE_LINKER)

macro (MACRO_TUNE_COMPILER_LINKER _flag)
    string (TOUPPER "${_flag}" FLAGNAME)
    string (REPLACE " " "_" FLAGNAME "${FLAGNAME}")
    string (REPLACE "-" "_" FLAGNAME "${FLAGNAME}")
    string (REPLACE "=" "_" FLAGNAME "${FLAGNAME}")
    string (REPLACE "," "_" FLAGNAME "${FLAGNAME}")
    string (REPLACE "/" "_" FLAGNAME "${FLAGNAME}")
    string (REPLACE "." "_" FLAGNAME "${FLAGNAME}")
    set (FLAGNAME "LINKER_HAS${FLAGNAME}")
    set (OLD_CMAKE_REQUIRED_FLAGS "${CMAKE_REQUIRED_FLAGS}")
    set (CMAKE_REQUIRED_FLAGS "${_flag}")
    x_check_c_compiler_flag("${_flag}" ${FLAGNAME})
    set (CMAKE_REQUIRED_FLAGS "${OLD_CMAKE_REQUIRED_FLAGS}")
    if (${FLAGNAME})
        set (CMAKE_C_LINK_FLAGS "${CMAKE_C_LINK_FLAGS} ${_flag}")
        set (CMAKE_C_FLAGS     "${CMAKE_C_FLAGS} ${_flag}")
    endif (${FLAGNAME})
endmacro (MACRO_TUNE_COMPILER_LINKER)
