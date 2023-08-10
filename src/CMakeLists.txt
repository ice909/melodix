set(BIN_NAME ${CMAKE_PROJECT_NAME})
list(APPEND RESOURCES music.qrc)
list(APPEND RESOURCES img.qrc)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

find_package(Qt5 COMPONENTS Quick QuickCompiler LinguistTools REQUIRED)
find_package(Qt5 REQUIRED Core Widgets Multimedia Network)

find_package(DtkCore REQUIRED)
find_package(DtkGui REQUIRED)
find_package(DtkWidget REQUIRED)
find_package(DtkDeclarative REQUIRED)

qtquick_compiler_add_resources(RCC_SOURCES ${RESOURCES})

# 保证src目录下的头文件全局可见
include_directories(.)
include_directories(./cpp/network)
include_directories(./cpp/player)

aux_source_directory(./ ALLSOURCE)
aux_source_directory(./cpp/network ALLSOURCE)
aux_source_directory(./cpp/player ALLSOURCE)

add_executable(${BIN_NAME} ${ALLSOURCE} ${RESOURCES})

set(TARGET_LIBS
    Qt5::Core
    Qt5::Widgets
    Qt5::Multimedia
    Qt5::Network
    Qt5::Quick
    ${DtkCore_LIBRARIES}
    ${DtkGui_LIBRARIES}
    ${DtkWidget_LIBRARIES}
    ${DtkDeclarative_LIBRARIES}
)

target_link_libraries(${BIN_NAME} ${TARGET_LIBS})