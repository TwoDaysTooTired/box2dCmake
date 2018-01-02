set(box2d_lib_name Box2D)
project(${box2d_lib_name})

message(STATUS "box2d source dir ${PROJECT_SOURCE_DIR} ")
message(STATUS "box2d binary dir ${PROJECT_BINARY_DIR}")
message(STATUS "box2d source dir cmake ${CMAKE_SOURCE_DIR}")
message(STATUS "box2d current source dir ${CMAKE_CURRENT_SOURCE_DIR}/../")

file(GLOB_RECURSE box2d_headers "*.h")
file(GLOB_RECURSE box2d_sources "*.cpp")
# message(STATUS "box2d header files: ${box2d_headers}")
# message(STATUS "box2d source files: ${box2d_sources}")

add_library(${box2d_lib_name} ${box2d_headers} ${box2d_sources})
