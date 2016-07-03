
SET (gaen_samples_LIB_SOURCES
  gaen_samples_api.cpp
  gaen_samples_api.h
  )

MSVC_PRECOMPILED_HEADER (gaen_samples_lib gaen_samples_LIB_SOURCES)
IDE_SOURCE_PROPERTIES( "/" "${gaen_samples_LIB_SOURCES}")

ADD_LIBRARY (gaen_samples_lib
  ${gaen_samples_LIB_SOURCES}
  )
