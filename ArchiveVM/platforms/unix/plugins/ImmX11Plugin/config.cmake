IF (NOT X11_FOUND)
    PLUGIN_DISABLE ()
ENDIF (NOT X11_FOUND)

CONFIG_DEFINE(USE_XICFONT_OPTION)
CONFIG_DEFINE(USE_XICFONT_RESOURCE)
CONFIG_DEFINE(USE_XICFONT_DEFAULT)
