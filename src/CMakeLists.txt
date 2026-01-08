project(planning_main)

add_subdirectory(pnc_map)
add_subdirectory(process)

add_executable(${PROJECT_NAME} main.cpp)

if(APPLE)
	# 让 @rpath 指向可执行文件所在目录（也就是 bin/）
	set_target_properties(${PROJECT_NAME} PROPERTIES
		BUILD_WITH_INSTALL_RPATH TRUE
		BUILD_RPATH "@executable_path"
		INSTALL_RPATH "@executable_path"
		MACOSX_RPATH ON
	)
endif()

target_include_directories(${PROJECT_NAME}
PUBLIC
${Process_Dir}
${Pnc_Map_Dir}
)
target_link_libraries(${PROJECT_NAME}
PUBLIC
process
)

install(TARGETS ${PROJECT_NAME}
	RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
