#pragma once

#if defined(_WIN32) || defined(__CYGWIN__)
  #if defined(PNC_MAP_BUILDING_DLL)
    #define PNC_MAP_API __declspec(dllexport)
  #else
    #define PNC_MAP_API __declspec(dllimport)
  #endif
#else
  #if __GNUC__ >= 4
    #define PNC_MAP_API __attribute__((visibility("default")))
  #else
    #define PNC_MAP_API
  #endif
#endif
