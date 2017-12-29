set(glew_lib_name glew)

project(glew C)
set(glew_headers glew.h glxew.h wglew.h)
set(glew_sources glew.c)

add_library(glew ${glew_sources} ${glew_headers})
set_target_properties(glew PROPERTIES OUTPUT_NAME ${glew_lib_name} FOLDER "GLEW")
