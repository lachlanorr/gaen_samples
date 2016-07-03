CMAKE_MINIMUM_REQUIRED (VERSION 2.8.12)

PROJECT (gaen_samples)

CMAKE_POLICY(SET CMP0054 NEW)
CMAKE_POLICY(SET CMP0026 OLD)

SET (cmake_dir ${CMAKE_CURRENT_SOURCE_DIR}/gaen/cmake)
INCLUDE (${cmake_dir}/core_defs.cmake)

ADD_DEFINITIONS(-DGLM_FORCE_NO_CTOR_INIT)
INCLUDE_DIRECTORIES (${CMAKE_CURRENT_SOURCE_DIR}/gaen/external/glm-0.9.7.2)
INCLUDE_DIRECTORIES (${CMAKE_CURRENT_SOURCE_DIR}/gaen/src)
INCLUDE_DIRECTORIES (${CMAKE_CURRENT_SOURCE_DIR}/src)

# Link our project specific lib into gaen executable.
# Any additional project specific libs can be added
# to this list and they will be linked in as well.
SET (PROJECT_LINK_LIBS ${CMAKE_PROJECT_NAME}_lib)

ADD_SUBDIRECTORY(gaen)
ADD_SUBDIRECTORY(src)
