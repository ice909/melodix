project(libimusic)

set(CMD_NAME imusic)
add_definitions(-DLIBIMUSIC_LIBRARY)

set(QT_MODULES Core Multimedia DBus Network)

set(CMAKE_AUTOMOC ON)

include_directories(.)
include_directories(./network)

aux_source_directory(. ALL_SOURCES)
aux_source_directory(./network ALL_SOURCES)

find_package(Qt5 REQUIRED ${QT_MODULES})
find_package(DtkCore REQUIRED)

add_library(${CMD_NAME} SHARED ${ALL_SOURCES})

set_target_properties(imusic PROPERTIES VERSION 1.0.0 SOVERSION 1.0)

target_link_libraries(${CMD_NAME} Qt5::Core Qt5::Multimedia Qt5::DBus Qt5::Network Dtk::Core)
