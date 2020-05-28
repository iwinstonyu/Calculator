m_add_source_group_recursive()

add_library(Calculator ${sources})

target_include_directories(Calculator PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/Inc>
    $<INSTALL_INTERFACE:Inc>
)
	
set_target_properties(Calculator PROPERTIES 
	PUBLIC_HEADER "Inc/Calculator.h"
)

set_target_properties(Calculator PROPERTIES 
	VERSION 1.0.0 
	SOVERSION 1.0.0)
	
install(TARGETS Calculator
	EXPORT Calculator
	PUBLIC_HEADER DESTINATION Inc/Calculator
	ARCHIVE DESTINATION Lib
	LIBRARY DESTINATION Lib
	RUNTIME DESTINATION Bin
)
	
install(EXPORT Calculator
	FILE CalculatorConfig.cmake
	DESTINATION Lib/CMake/Calculator
)

install(FILES ${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/Debug/Calculator.pdb DESTINATION Lib
	CONFIGURATIONS Debug
)