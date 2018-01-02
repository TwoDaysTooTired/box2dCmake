cmake_minimum_required(VERSION 3.1)
set(project_name cbox)
project(${project_name}  C CXX)
message(STATUS "cbox source dir ${PROJECT_SOURCE_DIR} ")
message(STATUS "cbox binary dir ${PROJECT_BINARY_DIR}")
message(STATUS "cbox source dir cmake ${CMAKE_SOURCE_DIR}")
message(STATUS "cbox current source dir ${CMAKE_CURRENT_SOURCE_DIR}")
set(box2d_root_dir ${CMAKE_SOURCE_DIR}/Box2D)
set(glew_root_dir ${CMAKE_SOURCE_DIR}/glew)
set(glfw_root_dir ${CMAKE_SOURCE_DIR}/glfw)
set(imgui_root_dir ${CMAKE_SOURCE_DIR}/imgui)
set(testbed_root_dir ${CMAKE_SOURCE_DIR}/testbed)
set(glm_root_dir ${CMAKE_SOURCE_DIR}/glm/glm)

set(CMAKE_C_FLAGS_DEBUG "-g -Wall")
set(CMAKE_CXX_FLAGS_DEBUG ${CMAKE_C_FLAGS_DEBUG})
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=c99")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++14 -Wno-deprecated-declarations -Wno-reorder")


set(GLM_STATIC_LIBRARY_ENABLE 1)


# include_directories(
#   /usr/local/include/GLFW
#   /usr/include/GLFW
#   ${COCOS2D_ROOT}
#   ${COCOS2D_ROOT}/cocos
#   ${COCOS2D_ROOT}/external
#   ${COCOS2D_ROOT}/cocos/platform
#   ${COCOS2D_ROOT}/cocos/audio/include/
#   Classes
# )

set(game_src_files)
set(game_src_headers)
file(GLOB_RECURSE game_src_files  "Classes/*.cpp")
file(GLOB_RECURSE game_src_headers "Classes/*.hpp")
set(ALL_FILES ${game_src_files} ${game_src_headers})
foreach(FILE ${ALL_FILES}) 
  get_filename_component(PARENT_DIR "${FILE}" PATH)

  string(REPLACE "/" "\\" GROUP "${PARENT_DIR}")

  if ("${FILE}" MATCHES ".*\\.cpp")
    set(GROUP "\\${GROUP}")
  elseif("${FILE}" MATCHES ".*\\.hpp")
    set(GROUP "\\${GROUP}")
  endif()

  source_group("${GROUP}" FILES "${FILE}")
endforeach()


include_directories(${CMAKE_SOURCE_DIR})
include_directories(${CMAKE_SOURCE_DIR}/Classes)
include_directories(${glm_root_dir})

add_subdirectory(${box2d_root_dir})
add_subdirectory(${glew_root_dir})
add_subdirectory(${glfw_root_dir})
add_subdirectory(${imgui_root_dir})
add_subdirectory(${testbed_root_dir})
add_subdirectory(${glm_root_dir})

add_executable(${project_name} ${ALL_FILES})
target_link_libraries(${project_name} ${glew_lib_name} ${glfw_lib_name} ${imgui_lib_name} ${box2d_lib_name} glm_static)

set_target_properties(${PROJECT_NAME} PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${PROJECT_NAME})