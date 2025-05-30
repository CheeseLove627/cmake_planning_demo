cmake_minimum_required(VERSION 3.10)
project(planning
    VERSION 1.0
    DESCRIPTION "Planning module for autonomous systems"
    LANGUAGES CXX
    HOMEPAGE_URL "https://github.com/CheeseLove627/cmake_planning_demo"
)
set(CMAKE_CXX_STANDARD 17)
# 变量设置
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)
set(Process_Dir ${CMAKE_SOURCE_DIR}/src/process)
set(Pnc_Map_Dir ${CMAKE_SOURCE_DIR}/src/pnc_map)


# 添加子目录
add_subdirectory(src)