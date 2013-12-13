
IF(MINGW)
    SET(WXWIDGETS_SEARCH_PATHS
        /usr/local/
        /usr
        /opt
    )

    FIND_PATH(WXWIDGETS_INCLUDE_DIR wx/wx.h 
        HINTS ${WXWIDGETS_ROOT}
        PATH_SUFFIXES include include/wx-3.0
        PATHS ${WXWIDGETS_SEARCH_PATHS}
    )

    FIND_PATH(WXWIDGETS_SETUP_PATH wx/setup.h
        HINTS ${WXWIDGETS_ROOT}
        PATH_SUFFIXES 
            lib/wx/include/msw-unicode-static-3.0/ 
            lib/wx/include/msw-unicode-dynamic-3.0/
        PATHS ${WXWIDGETS_SEARCH_PATHS}
    )

    SET(SEARCH_LIBS wx_mswu_html-3.0 wx_mswu_adv-3.0 wx_mswu_aui-3.0 wx_mswu_core-3.0 wx_baseu-3.0 wxjpeg-3.0 wxpng-3.0 wxzlib-3.0 )

    FOREACH(SLIB ${SEARCH_LIBS})
    FIND_LIBRARY(FOUND_${SLIB}_LIB ${SLIB} HINTS ${WXWIDGETS_ROOT} PATH_SUFFIXES lib64 lib bin PATHS ${WXWIDGETS_SEARCH_PATHS} )
    SET(WXWIDGETS_LIBRARY ${WXWIDGETS_LIBRARY} ${FOUND_${SLIB}_LIB})
    ENDFOREACH(SLIB)

    SET(WXWIDGETS_INCLUDE_DIR ${WXWIDGETS_INCLUDE_DIR} ${WXWIDGETS_SETUP_PATH})

    IF(WXWIDGETS_INCLUDE_DIR AND WXWIDGETS_LIBRARY)
        SET(WXWIDGETS_FOUND TRUE)
    ENDIF(WXWIDGETS_INCLUDE_DIR AND WXWIDGETS_LIBRARY)

    SET(WX_OPTS "")
ELSE(MINGW)
    FIND_PROGRAM(WX_CONFIG
        NAMES wx-config-3.0 wx-config-2.9
        PATHS
            /usr/bin
            /usr/local/bin
    )

    SET(WXWIDGETS_INCLUDE_DIR "")
    SET(WXWIDGETS_LIBRARY "")

    EXECUTE_PROCESS(
        COMMAND ${WX_CONFIG} "--cxxflags" "--libs"
        OUTPUT_VARIABLE WX_OPTS
    )

    STRING(REGEX REPLACE "(\r?\n)+$" "" WX_OPTS "${WX_OPTS}")

    IF(WX_OPTS)
        SET(WXWIDGETS_FOUND TRUE)
    ENDIF(WX_OPTS)
ENDIF(MINGW)

IF(WXWIDGETS_FOUND)
    MESSAGE(STATUS "Found wxWidgets.")
ELSE(WXWIDGETS_FOUND)
    MESSAGE(WARNING "Could not find wxWidgets")
ENDIF(WXWIDGETS_FOUND)

