#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "planning::pnc_map" for configuration ""
set_property(TARGET planning::pnc_map APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(planning::pnc_map PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libpnc_map.dylib"
  IMPORTED_SONAME_NOCONFIG "@rpath/libpnc_map.dylib"
  )

list(APPEND _cmake_import_check_targets planning::pnc_map )
list(APPEND _cmake_import_check_files_for_planning::pnc_map "${_IMPORT_PREFIX}/lib/libpnc_map.dylib" )

# Import target "planning::process" for configuration ""
set_property(TARGET planning::process APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(planning::process PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libprocess.dylib"
  IMPORTED_SONAME_NOCONFIG "@rpath/libprocess.dylib"
  )

list(APPEND _cmake_import_check_targets planning::process )
list(APPEND _cmake_import_check_files_for_planning::process "${_IMPORT_PREFIX}/lib/libprocess.dylib" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
