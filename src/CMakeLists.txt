set(BIN_NAME ${CMAKE_PROJECT_NAME})

include(GNUInstallDirs)
set(APP_BIN_INSTALL_DIR ${CMAKE_INSTALL_PREFIX}/bin/)

list(APPEND RESOURCES music.qrc)
list(APPEND RESOURCES img.qrc)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

find_package(PkgConfig REQUIRED)
find_package(Qt5 COMPONENTS Quick QuickCompiler REQUIRED)
find_package(Qt5 REQUIRED Core Widgets Multimedia Network)

find_package(DtkDeclarative REQUIRED)

pkg_check_modules(Dtk REQUIRED IMPORTED_TARGET dtkwidget)
pkg_check_modules(Dtk REQUIRED IMPORTED_TARGET dtkcore)
pkg_check_modules(Dtk REQUIRED IMPORTED_TARGET dtkgui)

qtquick_compiler_add_resources(RCC_SOURCES ${RESOURCES})

# 保证src目录下的头文件全局可见
include_directories(.)
include_directories(./cpp)
include_directories(./cpp/player)

aux_source_directory(./ ALLSOURCE)
aux_source_directory(./cpp ALLSOURCE)
aux_source_directory(./cpp/player ALLSOURCE)

add_subdirectory(api)

add_executable(${BIN_NAME} ${ALLSOURCE} ${RESOURCES})

set(TARGET_LIBS
    Qt5::Core
    Qt5::Widgets
    Qt5::Multimedia
    Qt5::Network
    Qt5::Quick
    PkgConfig::Dtk
    ${DtkDeclarative_LIBRARIES}
    API
)

target_link_libraries(${BIN_NAME} ${TARGET_LIBS})

# 安装 digimusic
install(TARGETS ${BIN_NAME} DESTINATION ${APP_BIN_INSTALL_DIR})
