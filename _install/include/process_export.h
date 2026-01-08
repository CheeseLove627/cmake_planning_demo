#pragma once

#if defined(_WIN32) || defined(__CYGWIN__)
  #if defined(PROCESS_BUILDING_DLL)
    #define PROCESS_API __declspec(dllexport)
  #else
    #define PROCESS_API __declspec(dllimport)
  #endif
#else
  #if __GNUC__ >= 4
    #define PROCESS_API __attribute__((visibility("default")))
  #else
    #define PROCESS_API
  #endif
#endif
