project(imgui C++)

set(imgui_lib_name imgui)

file(GLOB_RECURSE imgui_headers "*.h")
file(GLOB_RECURSE imgui_sources "*.cpp")

add_library(imgui ${imgui_headers} ${imgui_sources})
set_target_properties(imgui PROPERTIES OUTPUT_NAME ${imgui_lib_name} FOLDER "IMGUI")