set(BIN_NAME ${CMAKE_PROJECT_NAME})

find_package(Qt5 COMPONENTS Quick QuickCompiler LinguistTools REQUIRED)
find_package(Qt5 REQUIRED Core Widgets)

find_package(DtkCore REQUIRED)
find_package(DtkGui REQUIRED)
find_package(DtkWidget REQUIRED)
find_package(DtkDeclarative REQUIRED)

# 保证src目录下的头文件全局可见
include_directories(src)
include_directories(../libdmusic)

aux_source_directory(. ALLSOURCE)

LINK_DIRECTORIES(${CMAKE_BINARY_DIR}/src/libimusic)

add_executable(${BIN_NAME} ${ALLSOURCE})

set(TARGET_LIBS Qt5::Quick imusic ${DtkCore_LIBRARIES} ${DtkGui_LIBRARIES} ${DtkWidget_LIBRARIES} ${DtkDeclarative_LIBRARIES})

target_link_libraries(${BIN_NAME} ${TARGET_LIBS})