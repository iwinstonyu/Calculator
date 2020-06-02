m_source_group_recurse(sources)

add_executable(Test ${sources})

find_package(GTest REQUIRED
	PATHS ${GTEST_ROOT}
)
	
#target_include_directories(Test ${CMAKE_SOURCE_DIR}/Inc)

target_link_libraries(Test Calculator)
target_link_libraries(Test GTest::gtest)

add_test(NAME RunTest
	COMMAND Test
)

add_custom_command(TARGET Test
	COMMENT "Auto Run Test"
	POST_BUILD COMMAND Test
)