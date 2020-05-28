macro(m_generate_acg_project _file_name)
	set(acg_project "${_file_name}Acg")
	set(acg_xml "${_file_name}.xml")
	
	project(${acg_project})
	
	set(CMAKE_EXPORT_COMPILE_COMMANDS "ON")

	file(GLOB sources "*.xml")
	#message("sources: " ${sources})
	
	get_filename_component(acg_xml_abs "${acg_xml}" ABSOLUTE)
	#message("acg_xml_abs: " ${acg_xml_abs})
	
	set(generated_files "${PROJECT_NAME}.h" "${PROJECT_NAME}.cpp")
	#message("generated_files: " ${generated_files})
	
	file(REMOVE ${generated_files})
	
	add_custom_command(
	    OUTPUT ${generated_files}
	    COMMAND "${CMAKE_SOURCE_DIR}\\External\\Loong SDK\\Bin\\${arch_folder}\\Release\\LoCompiler.exe"
	    ARGS -src "${acg_xml_abs}"
	    DEPENDS "${sources}"
	    COMMENT "Generate ${PROJECT_NAME}"
	)   
	
	add_custom_target(${PROJECT_NAME} DEPENDS ${generated_files} VERBATIM SOURCES ${sources})
endmacro()

macro(m_add_source_group_recursive)
  file(GLOB_RECURSE sources
    "./*.cpp"
    "./*.h"
  )

  foreach(current_source_file ${sources})
    file(RELATIVE_PATH current_folder ${CMAKE_CURRENT_SOURCE_DIR} ${current_source_file})
    get_filename_component(current_file_name ${current_folder} NAME)
    string(REPLACE ${current_file_name} "" current_folder ${current_folder})
    if(NOT current_folder STREQUAL "")
      string(REGEX REPLACE "/+$" "" current_folder ${current_folder})
      string(REPLACE "/" "\\" current_folder ${current_folder})
      source_group("${current_folder}" FILES ${current_source_file})
    endif()
  endforeach()
endmacro()

macro(m_stop_cmake)
	message(FATAL_ERROR "stop cmake: ${PROJECT_NAME}")
endmacro()

macro(m_set_mt)
	if(MSVC)
		foreach(flag_var
		CMAKE_CXX_FLAGS CMAKE_CXX_FLAGS_DEBUG CMAKE_CXX_FLAGS_RELEASE
		CMAKE_CXX_FLAGS_MINSIZEREL CMAKE_CXX_FLAGS_RELWITHDEBINFO)
		if(${flag_var} MATCHES "/MD")
			string(REGEX REPLACE "/MD" "/MT" ${flag_var} "${${flag_var}}")
		endif()
		endforeach()
	endif()
endmacro()



# =================================================
# include header
# =================================================

macro(m_inc_dir_curl)
	include_directories("${CMAKE_SOURCE_DIR}/External/curl/include")
endmacro()



# =================================================
# link dir
# =================================================

macro(m_link_dir_boost)
	link_directories("${CMAKE_SOURCE_DIR}/External/boost/lib/${arch_folder}")
endmacro()



# =================================================
# link lib
# =================================================

macro(m_link_lib_curl)
	target_link_libraries(${PROJECT_NAME} 
		debug 		"${CMAKE_SOURCE_DIR}/External/curl/lib/${arch_folder}/Debug/libcurl.lib"
		optimized "${CMAKE_SOURCE_DIR}/External/curl/lib/${arch_folder}/Release/libcurl.lib"
	)
endmacro()



#=================================================

macro(m_add_project_pch)
	set_target_properties(${PROJECT_NAME} PROPERTIES COMPILE_FLAGS "/YuPrecomp.h")
	set_source_files_properties(Precomp.cpp PROPERTIES COMPILE_FLAGS "/YcPrecomp.h")
endmacro()

macro(m_add_project_prefix)
	set_target_properties(${PROJECT_NAME} PROPERTIES PREFIX "Lp")
endmacro()



#=================================================

macro(m_set_vs_debugger_working_directory)
	set_target_properties(${PROJECT_NAME} PROPERTIES VS_DEBUGGER_WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/Run)
endmacro()