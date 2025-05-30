project(planning_main)

add_subdirectory(pnc_map)
add_subdirectory(process)

add_executable(${PROJECT_NAME} main.cpp)

target_include_directories(${PROJECT_NAME}
PUBLIC
${Process_Dir}
${Pnc_Map_Dir}
)
target_link_libraries(${PROJECT_NAME}
PUBLIC
process
)
