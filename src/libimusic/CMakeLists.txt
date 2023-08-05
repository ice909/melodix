project(libimusic)

set(CMD_NAME imusic)
add_definitions(-DLIBIMUSIC_LIBRARY)

set(QT_MODULES Core Multimedia DBus)

set(CMAKE_AUTOMOC ON)

find_package(Qt5 REQUIRED ${QT_MODULES})

add_library(${CMD_NAME} SHARED)

set_target_properties(imusic PROPERTIES VERSION 1.0.0 SOVERSION 1.0)
