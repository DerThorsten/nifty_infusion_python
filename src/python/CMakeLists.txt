
#-------------------------------------------------------------------------------------------------------------------
# Setup python bindings
#-------------------------------------------------------------------------------------------------------------------


find_package(NumPy REQUIRED)
include_directories(${NUMPY_INCLUDE_DIRS})

find_package(pybind11 REQUIRED)
include_directories(${pybind11_INCLUDE_DIRS})

find_package(xtensor-python REQUIRED)
include_directories(${xtensor-python_INCLUDE_DIRS})


#-------------------------------------------------------------------------------------------------------------------
# Add The module
#-------------------------------------------------------------------------------------------------------------------
pybind11_add_module(nifty_infusion main.cpp)


