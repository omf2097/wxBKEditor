
SET(WXWIDGETS_SEARCH_PATHS
    /usr/local/
    /usr
    /opt
)

FIND_PATH(WXWIDGETS_INCLUDE_DIR wx/wx.h 
    HINTS ${WXWIDGETS_ROOT}
    PATH_SUFFIXES include include/wx-2.9
    PATHS ${WXWIDGETS_SEARCH_PATHS}
)

IF(MINGW)
    SET(SEARCH_LIBS wx_mswu_core-2.9 wx_baseu-2.9 wxjpeg-2.9 wxpng-2.9 wxzlib-2.9 )
ELSE(MINGW)
    SET(SEARCH_LIBS wx_baseu-2.9)
ENDIF(MINGW)

FOREACH(SLIB ${SEARCH_LIBS})
    FIND_LIBRARY(FOUND_${SLIB}_LIB ${SLIB} HINTS ${WXWIDGETS_ROOT} PATH_SUFFIXES lib64 lib bin PATHS ${WXWIDGETS_SEARCH_PATHS} )
    SET(WXWIDGETS_LIBRARY ${WXWIDGETS_LIBRARY} ${FOUND_${SLIB}_LIB})
ENDFOREACH(SLIB)

IF(WXWIDGETS_INCLUDE_DIR AND WXWIDGETS_LIBRARY)
    SET(WXWIDGETS_FOUND TRUE)
ENDIF (WXWIDGETS_INCLUDE_DIR AND WXWIDGETS_LIBRARY)

IF(WXWIDGETS_FOUND)
    MESSAGE(STATUS "Found wxWidgets 2.9: ${WXWIDGETS_LIBRARY}")
ELSE(WXWIDGETS_FOUND)
    MESSAGE(WARNING "Could not find wxWidgets 2.9")
ENDIF(WXWIDGETS_FOUND)