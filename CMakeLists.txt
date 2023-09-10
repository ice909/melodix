cmake_minimum_required(VERSION 3.13)

if(NOT DEFINED VERSION)
    set(VERSION 1.1.1)
endif()

set(PROJECT_NAME melodix)

project(${PROJECT_NAME}
    VERSION ${VERSION}
    DESCRIPTION "MusicPlayer"
    HOMEPAGE_URL "https://github.com/student-ice/melodix"
    LANGUAGES CXX
)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_EXPORT_COMPILE_COMMANDS on)

include_directories(${PROJECT_BINARY_DIR})
include_directories(${PROJECT_SOURCE_DIR})

add_definitions(-DAPP_VERSION="${APP_VERSION}")
add_subdirectory(src)

# 安装desktop文件
install(FILES ${CMAKE_SOURCE_DIR}/misc/${PROJECT_NAME}.desktop DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/applications)
# 安装icon
install(FILES ${CMAKE_SOURCE_DIR}/misc/${PROJECT_NAME}.svg DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/icons/hicolor/scalable/apps)
