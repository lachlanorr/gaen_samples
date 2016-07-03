#!/bin/bash

# Run this first on a clean system to prepare gaen_samples build.
GAEN_SAMPLES_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BUILD_ROOT=$GAEN_SAMPLES_ROOT/build

# Clone gaen if it doesn't exist. This will need to happen for
# anyone who has cloned the project specific repository and is running
# bootstrap.sh for the first time.
if [ ! -d "./gaen" ]; then
    git clone -b master https://github.com/lachlanorr/gaen.git gaen
    cd gaen
    git checkout 77872b950df5aea6ca9238c6152decca7207f35f
    cd ..
fi


[ -d "$BUILD_ROOT" ] || mkdir -p "$BUILD_ROOT"

elementIn () {
    local e
    for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done
    return 1
}

if [ "$(uname)" == "Darwin" ]; then
    # for OSX, we just use xcode and allow it to manage configs
    cd $BUILD_ROOT

    PLATFORM_TYPES=( osx ios ios-sim )

    if [ -z "$1" ]
    then
        PLATFORM_TYPE=osx
    else
        PLATFORM_TYPE=$1
    fi

    if ! elementIn "$PLATFORM_TYPE" "${PLATFORM_TYPES[@]}"
    then
        echo Invalid platform type \"$PLATFORM_TYPE\", must be one of:
        printf "  %s\n" "${PLATFORM_TYPES[@]}"
        exit 1
    fi

    PLATFORM_DIR="$BUILD_ROOT/${PLATFORM_TYPE}"

    [ -d "$PLATFORM_DIR" ] || mkdir -p "$PLATFORM_DIR"
    cd $PLATFORM_DIR

    if [ "$PLATFORM_TYPE" == "osx" ]
    then
        cmake -G Xcode ${GAEN_SAMPLES_ROOT}
    elif [ "$PLATFORM_TYPE" == "ios" ]
    then
        cmake -D CMAKE_TOOLCHAIN_FILE=${GAEN_SAMPLES_ROOT}/external/ios-cmake/iOS.cmake -D IOS_ARCH=arm7 -G Xcode ${GAEN_SAMPLES_ROOT}
    elif [ "$PLATFORM_TYPE" == "ios-sim" ]
    then
        cmake -D CMAKE_TOOLCHAIN_FILE=${GAEN_SAMPLES_ROOT}/external/ios-cmake/iOS.cmake -D IOS_PLATFORM=SIMULATOR -G Xcode ${GAEN_SAMPLES_ROOT}
    else
        echo Invalid platform type \"$PLATFORM_TYPE\", must be one of:
        printf "  %s\n" "${PLATFORM_TYPES[@]}"
        exit 1
    fi
else
    # for other unices, we default to makefiles

    BUILD_TYPES=( Debug Release RelWithDebInfo MinSizeRel )
    GAEN_SAMPLES_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


    # If you want to override cc options, create a setcc.sh script and
    # place it next to bootstrap.sh.  It will be ignored by git.
    if [ -f ${GAEN_SAMPLES_ROOT}/setcc.sh ]
    then
        echo Using custom cc defined in setcc.sh
        source ${GAEN_SAMPLES_ROOT}/setcc.sh
    fi


    if [ -z "$1" ]
    then
        BUILD_TYPE=Debug
    else
        BUILD_TYPE=$1
    fi

    if ! elementIn "$BUILD_TYPE" "${BUILD_TYPES[@]}" 
    then
        echo Invalid build type \"$BUILD_TYPE\", must be one of:
        printf "  %s\n" "${BUILD_TYPES[@]}"
        exit 1
    fi

    BUILD_DIR=$BUILD_ROOT/$BUILD_TYPE

    if [ ! -d "$BUILD_DIR" ]
    then
        mkdir -p $BUILD_DIR
    fi

    cd $BUILD_DIR


    # Run cmake
    cmake -DCMAKE_BUILD_TYPE=${BUILD_TYPE} ${GAEN_SAMPLES_ROOT}

    echo
    echo To build, run make within $BUILD_DIR
fi
