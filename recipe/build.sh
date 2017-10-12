#!/bin/bash
# python setupy.py install

EXTRA_CMAKE_ARGS=""
if [[ `uname` == 'Darwin' ]];
then
    EXTRA_CMAKE_ARGS="-DCMAKE_OSX_DEPLOYMENT_TARGET=${CMAKE_OSX_DEPLOYMENT_TARGET}"
else
    export CXXFLAGS="-pthread ${CXXFLAGS}"
fi
export EXTRA_CMAKE_ARGS

export NIFTY_INFUSION_PYTHON_CXX_FLAGS="${CXXFLAGS}"
#export NIFTY_INFUSION_PYTHON_CXX_FLAGS="${CXXFLAGS} -std=c++11"


export NIFTY_INFUSION_PYTHON_LDFLAGS="${CXX_LDFLAGS} -Wl,-rpath,${PREFIX}/lib -L${PREFIX}/lib"


cmake  \
    -DCMAKE_INSTALL_PREFIX=${PREFIX} \
    -DCMAKE_PREFIX_PATH=${PREFIX} \
    \
    -DCMAKE_CXX_LINK_FLAGS="${NIFTY_INFUSION_PYTHON_LDFLAGS}" \
    -DCMAKE_EXE_LINKER_FLAGS="${NIFTY_INFUSION_PYTHON_LDFLAGS}" \
    -DCMAKE_CXX_FLAGS="${NIFTY_INFUSION_PYTHON_CXX_FLAGS}" \
    -DCMAKE_CXX_FLAGS_RELEASE="${NIFTY_INFUSION_PYTHON_CXX_FLAGS_RELEASE}" \
    -DCMAKE_CXX_FLAGS_DEBUG="${NIFTY_INFUSION_PYTHON_CXX_FLAGS}" \
    \
    -DDEPENDENCY_SEARCH_PREFIX=${PREFIX} \
    -DBoost_INCLUDE_DIRS="${PREFIX}/include" 

make -j${CPU_COUNT}
make install
