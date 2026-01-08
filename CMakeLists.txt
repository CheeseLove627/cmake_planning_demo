cmake_minimum_required(VERSION 3.10)
project(planning
    VERSION 1.0
    DESCRIPTION "Planning module for autonomous systems"
    LANGUAGES CXX
    HOMEPAGE_URL "https://github.com/CheeseLove627/cmake_planning_demo"
)

include(GNUInstallDirs)
include(CMakePackageConfigHelpers)
set(CMAKE_CXX_STANDARD 17)
# 变量设置
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)

# 多配置生成器（VS/Xcode）也输出到同一个 bin/
foreach(_cfg Debug Release RelWithDebInfo MinSizeRel)
    string(TOUPPER "${_cfg}" _cfg_upper)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_${_cfg_upper} ${CMAKE_SOURCE_DIR}/bin)
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_${_cfg_upper} ${CMAKE_SOURCE_DIR}/bin)
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_${_cfg_upper} ${CMAKE_SOURCE_DIR}/bin)
endforeach()

if(MSVC)
    # MSVC 下若不写 __declspec(dllexport/dllimport)，SHARED 库可能不导出符号。
    # Demo 工程最省事的方式是让 CMake 自动导出符号。
    set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)
endif()
set(Process_Dir ${CMAKE_SOURCE_DIR}/src/process)
set(Pnc_Map_Dir ${CMAKE_SOURCE_DIR}/src/pnc_map)


# 添加子目录
add_subdirectory(src)

# -------- SDK 安装与 find_package(planning) 支持 --------
set(planning_cmake_config_dir "${CMAKE_INSTALL_LIBDIR}/cmake/planning")

configure_package_config_file(
    "${CMAKE_SOURCE_DIR}/cmake/planningConfig.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/planningConfig.cmake"
    INSTALL_DESTINATION "${planning_cmake_config_dir}"
)

write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/planningConfigVersion.cmake"
    VERSION "${PROJECT_VERSION}"
    COMPATIBILITY SameMajorVersion
)

install(EXPORT planningTargets
    FILE planningTargets.cmake
    NAMESPACE planning::
    DESTINATION "${planning_cmake_config_dir}"
)

install(FILES
    "${CMAKE_CURRENT_BINARY_DIR}/planningConfig.cmake"
    "${CMAKE_CURRENT_BINARY_DIR}/planningConfigVersion.cmake"
    DESTINATION "${planning_cmake_config_dir}"
)