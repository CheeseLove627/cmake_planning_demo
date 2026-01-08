#pragma once 
#include "process_export.h"
#include "pnc_map.h"

class PROCESS_API Process
{

public:
    void planProcess();
    
public:
    PNC_MAP my_map;    
};