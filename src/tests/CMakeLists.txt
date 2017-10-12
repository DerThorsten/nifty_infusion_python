
#-------------------------------------------------------------------------------------------------------------------
# Setup unit testing
#-------------------------------------------------------------------------------------------------------------------

#------------------------------------
# download doctests
#-----------------------------------
ExternalProject_Add(
    external_doctest
    PREFIX ${CMAKE_BINARY_DIR}/external_projects/doctest
    GIT_REPOSITORY https://github.com/onqtam/doctest.git
    TIMEOUT 10
    #UPDATE_COMMAND ${GIT_EXECUTABLE} pull
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND ""
    LOG_DOWNLOAD ON
)

# Expose required variable (DOCTEST_INCLUDE_DIR) to parent scope
ExternalProject_Get_Property(external_doctest source_dir)
set(DOCTEST_INCLUDE_DIR ${source_dir}/doctest CACHE INTERNAL "Path to include folder for doctest")
MESSAGE(STATUS DOCTEST_INCLUDE_DIR ${DOCTEST_INCLUDE_DIR})
include_directories(${DOCTEST_INCLUDE_DIR})


# meta target for all to handle dependencies
add_custom_target(externl_headers_test)
add_dependencies(externl_headers_test
    externl_headers 
    external_doctest
)



#-------------------------------------------------------------------------------------------------------------------
# Add Unit Tests
#-------------------------------------------------------------------------------------------------------------------

add_executable(test_nifty_infusion_python
    test_nifty_infusion_python.cxx
    test_nifty_infusion_python_a.cxx
)


if(NOT MSVC)
    # Make sure C++11/14 are enabled
    target_compile_options(test_nifty_infusion_python  PUBLIC  -std=c++14)
endif()


add_test(NAME test_nifty_infusion_python COMMAND test_nifty_infusion_python)
#target_link_libraries(test_xtensor_sandbox)
add_dependencies(test_nifty_infusion_python
    externl_headers_test)


