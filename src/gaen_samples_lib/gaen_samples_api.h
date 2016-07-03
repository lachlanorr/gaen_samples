//------------------------------------------------------------------------------
//
// gaen_samples_api.h - Project specifc C++ code
//
// Place any project specifyc C++ code here.
//
// In particular, it's a good place for system_api functions that are
// callable from your Compose scripts.
//
//------------------------------------------------------------------------------

#ifndef GAEN_SAMPLES_LIB_GAEN_SAMPLES_API_H
#define GAEN_SAMPLES_LIB_GAEN_SAMPLES_API_H

#include "engine/Entity.h"

namespace gaen
{

// All Compose api calls must be declared in the
// gaen::system_api namespace
namespace system_api
{

// Note that each function must take an Entity& as the last parameter.
//
// The mapping of C++ types to Compose types is as follows:
//
// |---------+-----------|
// | Compose | C++       |
// |---------+-----------|
// | char    | i8        |
// | byte    | u8        |
// | short   | i16       |
// | ushort  | u16       |
// | int     | i32       |
// | uint    | u32       |
// | long    | i64       |
// | ulong   | u64       |
// | half    | f16       |
// | float   | f32       |
// | double  | f64       |
// | bool    | bool      |
// | color   | Color     |
// | vec2    | Vec2      |
// | vec3    | Vec3      |
// | vec4    | Vec4      |
// | mat3    | Mat3      |
// | mat34   | Mat34     |
// | mat4    | Mat4      |
// | void    | void      |
// | handle  | Handle    |
// | entity  | task_id   |
// | string  | CmpString |
// |---------+-----------|

// Here's a trivial system_api function, purely for illustration
// of the api mechanism.
//
// All system_api functions are available in Compose scripts within
// the $ namespace.
//
// Calling this function from Compose would look like:
//
// $.fibanacci(7)
//
// Which would return 13.
//
// For several more examples, refer to gaen/src/engine/system_api.h/cpp
u32 fibonacci(u32 n, Entity & caller);

} // namespace system_api

} // namespace gaen

#endif // #ifndef GAEN_SAMPLES_LIB_GAEN_SAMPLES_API_H

