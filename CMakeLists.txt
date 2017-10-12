cmake_minimum_required(VERSION 3.1)
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules)

SET(PROJECT_NAME "NIFTY_INFUSION_PYTHON")
project(NIFTY_INFUSION_PYTHON)


# set (XTENSOR_SANDBOX_VERSION_MAJOR 0 )
# set (XTENSOR_SANDBOX_VERSION_MINOR 1 )
# set (XTENSOR_SANDBOX_VERSION_PATCH 0 )


# set (XTENSOR_SANDBOX_VERSION_SHORT_STR "${XTENSOR_SANDBOX_VERSION_MAJOR}.${XTENSOR_SANDBOX_VERSION_MINOR}")
# set (XTENSOR_SANDBOX_VERSION_STR "${XTENSOR_SANDBOX_VERSION_MAJOR}.${XTENSOR_SANDBOX_VERSION_MINOR}.${XTENSOR_SANDBOX_VERSION_PATCH}")


include(CheckCXXCompilerFlag)




#-------------------------------------------------------------------------------------------------------------------
# check for c++ 14 support
#-------------------------------------------------------------------------------------------------------------------

# FIXME c++14 checks are broken???
if (CMAKE_CXX_COMPILER_ID MATCHES "Clang" OR CMAKE_CXX_COMPILER_ID MATCHES "GNU")
    CHECK_CXX_COMPILER_FLAG("-std=c++14" HAS_CPP14_FLAG)
    #CHECK_CXX_COMPILER_FLAG("-std=c++11" HAS_CPP11_FLAG)
    if (HAS_CPP14_FLAG)
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++14")
    else()
        message(FATAL_ERROR "Unsupported compiler -- multi-array  requires C++14 support!")
    endif()
endif()


if(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++")
endif()

#-------------------------------------------------------------------------------------------------------------------
# threading package
#-------------------------------------------------------------------------------------------------------------------
find_package(Threads REQUIRED)

#-------------------------------------------------------------------------------------------------------------------
# include include files
#-------------------------------------------------------------------------------------------------------------------
file(GLOB_RECURSE headers include/*.hxx)
include_directories(include)



# nifty infusion related
find_package(NIFTY_INFUSION REQUIRED)
include_directories(${NIFTY_INFUSION_INCLUDE_DIRS})



# python related
find_package(NumPy REQUIRED)
include_directories(${NUMPY_INCLUDE_DIRS})

find_package(pybind11 REQUIRED)
include_directories(${pybind11_INCLUDE_DIRS})

find_package(xtensor REQUIRED)
include_directories(${xtensor_INCLUDE_DIRS})

find_package(xtensor-python REQUIRED)
include_directories(${xtensor-python_INCLUDE_DIRS})



#------------------------------------------------------------------------------------------------------------------
# src folder
#-------------------------------------------------------------------------------------------------------------------
add_subdirectory(src)

