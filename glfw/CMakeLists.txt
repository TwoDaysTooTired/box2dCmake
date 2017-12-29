cmake_minimum_required(VERSION 3.10)
project(glfw C)

set(CMAKE_LEGACY_CYGWIN_WIN32 OFF)

if (NOT CMAKE_VERSION VERSION_LESS "3.0")
    # Until all major package systems have moved to CMake 3,
    # we stick with the older INSTALL_NAME_DIR mechanism
    cmake_policy(SET CMP0042 OLD)
endif()

if (NOT CMAKE_VERSION VERSION_LESS "3.1")
    cmake_policy(SET CMP0054 NEW)
endif()

set(GLFW_VERSION_MAJOR "3")
set(GLFW_VERSION_MINOR "3")
set(GLFW_VERSION_PATCH "0")
set(GLFW_VERSION_EXTRA "")
set(GLFW_VERSION "${GLFW_VERSION_MAJOR}.${GLFW_VERSION_MINOR}")
set(GLFW_VERSION_FULL "${GLFW_VERSION}.${GLFW_VERSION_PATCH}${GLFW_VERSION_EXTRA}")
set(LIB_SUFFIX "" CACHE STRING "Takes an empty string or 64. Directory where lib will be installed: lib or lib64")

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

option(BUILD_SHARED_LIBS "Build shared libraries" OFF)
option(GLFW_BUILD_EXAMPLES "Build the GLFW example programs" ON)
option(GLFW_BUILD_TESTS "Build the GLFW test programs" ON)
option(GLFW_BUILD_DOCS "Build the GLFW documentation" ON)
option(GLFW_INSTALL "Generate installation target" ON)
option(GLFW_VULKAN_STATIC "Use the Vulkan loader statically linked into application" OFF)
option(GLFW_DOCUMENT_INTERNALS "Include internals in documentation" OFF)

if (UNIX)
    option(GLFW_USE_OSMESA "Use OSMesa for offscreen context creation" OFF)
endif()

if (WIN32)
    option(GLFW_USE_HYBRID_HPG "Force use of high-performance GPU on hybrid systems" OFF)
endif()

if (UNIX AND NOT APPLE)
    option(GLFW_USE_WAYLAND "Use Wayland for window creation" OFF)
    option(GLFW_USE_MIR     "Use Mir for window creation" OFF)
endif()

if (MSVC)
    option(USE_MSVC_RUNTIME_LIBRARY_DLL "Use MSVC runtime library DLL" ON)
endif()

if (BUILD_SHARED_LIBS)
    set(_GLFW_BUILD_DLL 1)
endif()

if (BUILD_SHARED_LIBS AND UNIX)
    # On Unix-like systems, shared libraries can use the soname system.
    set(glfw_lib_name  glfw)
else()
    set(glfw_lib_name glfw3)
endif()

if (GLFW_VULKAN_STATIC)
    set(_glfw_vulkan_static 1)
endif()

#unused part
#list(APPEND CMAKE_MODULE_PATH "${GLFW_SOURCE_DIR}/CMake/modules")
#find_package(Vulkan)

find_package(Threads REQUIRED)
if(Threads_FOUND)
message(STATUS "find Threads")
else(Threads_FOUND)
message(FATAL_ERROR "not find Threads")
endif()





#--------------------------------------------------------------------
# Set compiler specific flags
#--------------------------------------------------------------------
if (MSVC)
    if (MSVC90)
        # Workaround for VS 2008 not shipping with the DirectX 9 SDK
        include(CheckIncludeFile)
        check_include_file(dinput.h DINPUT_H_FOUND)
        if (NOT DINPUT_H_FOUND)
            message(FATAL_ERROR "DirectX 9 SDK not found")
        endif()
        # Workaround for VS 2008 not shipping with stdint.h
        list(APPEND glfw_INCLUDE_DIRS "${GLFW_SOURCE_DIR}/deps/vs2008")
    endif()

    if (NOT USE_MSVC_RUNTIME_LIBRARY_DLL)
        foreach (flag CMAKE_C_FLAGS
                      CMAKE_C_FLAGS_DEBUG
                      CMAKE_C_FLAGS_RELEASE
                      CMAKE_C_FLAGS_MINSIZEREL
                      CMAKE_C_FLAGS_RELWITHDEBINFO)

            if (${flag} MATCHES "/MD")
                string(REGEX REPLACE "/MD" "/MT" ${flag} "${${flag}}")
            endif()
            if (${flag} MATCHES "/MDd")
                string(REGEX REPLACE "/MDd" "/MTd" ${flag} "${${flag}}")
            endif()

        endforeach()
    endif()
endif()

if (MINGW)
    # Workaround for legacy MinGW not providing XInput and DirectInput
    include(CheckIncludeFile)

    check_include_file(dinput.h DINPUT_H_FOUND)
    check_include_file(xinput.h XINPUT_H_FOUND)
    if (NOT DINPUT_H_FOUND OR NOT XINPUT_H_FOUND)
        list(APPEND glfw_INCLUDE_DIRS "${GLFW_SOURCE_DIR}/deps/mingw")
    endif()

    # Enable link-time exploit mitigation features enabled by default on MSVC
    include(CheckCCompilerFlag)

    # Compatibility with data execution prevention (DEP)
    set(CMAKE_REQUIRED_FLAGS "-Wl,--nxcompat")
    check_c_compiler_flag("" _GLFW_HAS_DEP)
    if (_GLFW_HAS_DEP)
        set(CMAKE_SHARED_LINKER_FLAGS "-Wl,--nxcompat ${CMAKE_SHARED_LINKER_FLAGS}")
    endif()

    # Compatibility with address space layout randomization (ASLR)
    set(CMAKE_REQUIRED_FLAGS "-Wl,--dynamicbase")
    check_c_compiler_flag("" _GLFW_HAS_ASLR)
    if (_GLFW_HAS_ASLR)
        set(CMAKE_SHARED_LINKER_FLAGS "-Wl,--dynamicbase ${CMAKE_SHARED_LINKER_FLAGS}")
    endif()

    # Compatibility with 64-bit address space layout randomization (ASLR)
    set(CMAKE_REQUIRED_FLAGS "-Wl,--high-entropy-va")
    check_c_compiler_flag("" _GLFW_HAS_64ASLR)
    if (_GLFW_HAS_64ASLR)
        set(CMAKE_SHARED_LINKER_FLAGS "-Wl,--high-entropy-va ${CMAKE_SHARED_LINKER_FLAGS}")
    endif()
endif()

if (APPLE)
    # Dependencies required by the MoltenVK static library
    set(GLFW_VULKAN_DEPS
        "-lc++"
        "-framework Cocoa"
        "-framework Metal"
        "-framework QuartzCore")
endif()


#--------------------------------------------------------------------
# Detect and select backend APIs
#--------------------------------------------------------------------
if (GLFW_USE_WAYLAND)
    set(_GLFW_WAYLAND 1)
    message(STATUS "Using Wayland for window creation")
elseif (GLFW_USE_MIR)
    set(_GLFW_MIR 1)
    message(STATUS "Using Mir for window creation")
elseif (GLFW_USE_OSMESA)
    set(_GLFW_OSMESA 1)
    message(STATUS "Using OSMesa for headless context creation")
elseif (WIN32)
    set(_GLFW_WIN32 1)
    message(STATUS "Using Win32 for window creation")
elseif (APPLE)
    set(_GLFW_COCOA 1)
    message(STATUS "Using Cocoa for window creation")
elseif (UNIX)
    set(_GLFW_X11 1)
    message(STATUS "Using X11 for window creation")
else()
    message(FATAL_ERROR "No supported platform was detected")
endif()


#--------------------------------------------------------------------
# Find and add Unix math and time libraries
#--------------------------------------------------------------------
if (UNIX AND NOT APPLE)
    find_library(RT_LIBRARY rt)
    mark_as_advanced(RT_LIBRARY)
    if (RT_LIBRARY)
        list(APPEND glfw_LIBRARIES "${RT_LIBRARY}")
        list(APPEND glfw_PKG_LIBS "-lrt")
    endif()

    find_library(MATH_LIBRARY m)
    mark_as_advanced(MATH_LIBRARY)
    if (MATH_LIBRARY)
        list(APPEND glfw_LIBRARIES "${MATH_LIBRARY}")
        list(APPEND glfw_PKG_LIBS "-lm")
    endif()

    if (CMAKE_DL_LIBS)
        list(APPEND glfw_LIBRARIES "${CMAKE_DL_LIBS}")
        list(APPEND glfw_PKG_LIBS "-l${CMAKE_DL_LIBS}")
    endif()
endif()

#--------------------------------------------------------------------
# Use Win32 for window creation
#--------------------------------------------------------------------
if (_GLFW_WIN32)

    list(APPEND glfw_PKG_LIBS "-lgdi32")

    if (GLFW_USE_HYBRID_HPG)
        set(_GLFW_USE_HYBRID_HPG 1)
    endif()
endif()

#--------------------------------------------------------------------
# Use X11 for window creation
#--------------------------------------------------------------------
if (_GLFW_X11)

    find_package(X11 REQUIRED)

    list(APPEND glfw_PKG_DEPS "x11")

    # Set up library and include paths
    list(APPEND glfw_INCLUDE_DIRS "${X11_X11_INCLUDE_PATH}")
    list(APPEND glfw_LIBRARIES "${X11_X11_LIB}" "${CMAKE_THREAD_LIBS_INIT}")

    # Check for XRandR (modern resolution switching and gamma control)
    if (NOT X11_Xrandr_FOUND)
        message(FATAL_ERROR "The RandR headers were not found")
    endif()

    # Check for Xinerama (legacy multi-monitor support)
    if (NOT X11_Xinerama_FOUND)
        message(FATAL_ERROR "The Xinerama headers were not found")
    endif()

    # Check for Xkb (X keyboard extension)
    if (NOT X11_Xkb_FOUND)
        message(FATAL_ERROR "The X keyboard extension headers were not found")
    endif()

    # Check for Xcursor (cursor creation from RGBA images)
    if (NOT X11_Xcursor_FOUND)
        message(FATAL_ERROR "The Xcursor headers were not found")
    endif()

    list(APPEND glfw_INCLUDE_DIRS "${X11_Xrandr_INCLUDE_PATH}"
                                  "${X11_Xinerama_INCLUDE_PATH}"
                                  "${X11_Xkb_INCLUDE_PATH}"
                                  "${X11_Xcursor_INCLUDE_PATH}")
endif()

#--------------------------------------------------------------------
# Use Wayland for window creation
#--------------------------------------------------------------------
if (_GLFW_WAYLAND)
    find_package(ECM REQUIRED NO_MODULE)
    list(APPEND CMAKE_MODULE_PATH "${ECM_MODULE_PATH}")

    find_package(Wayland REQUIRED)
    find_package(WaylandScanner REQUIRED)
    find_package(WaylandProtocols 1.1 REQUIRED)

    list(APPEND glfw_PKG_DEPS "wayland-egl")

    list(APPEND glfw_INCLUDE_DIRS "${Wayland_INCLUDE_DIR}")
    list(APPEND glfw_LIBRARIES "${Wayland_LIBRARIES}" "${CMAKE_THREAD_LIBS_INIT}")

    find_package(XKBCommon REQUIRED)
    list(APPEND glfw_INCLUDE_DIRS "${XKBCOMMON_INCLUDE_DIRS}")
endif()

#--------------------------------------------------------------------
# Use Mir for window creation
#--------------------------------------------------------------------
if (_GLFW_MIR)
    find_package(Mir REQUIRED)
    list(APPEND glfw_PKG_DEPS "mirclient")

    list(APPEND glfw_INCLUDE_DIRS "${MIR_INCLUDE_DIRS}")
    list(APPEND glfw_LIBRARIES "${MIR_LIBRARIES}" "${CMAKE_THREAD_LIBS_INIT}")

    find_package(XKBCommon REQUIRED)
    list(APPEND glfw_PKG_DEPS "xkbcommon")
    list(APPEND glfw_INCLUDE_DIRS "${XKBCOMMON_INCLUDE_DIRS}")
    list(APPEND glfw_LIBRARIES "${XKBCOMMON_LIBRARY}")
endif()

#--------------------------------------------------------------------
# Use OSMesa for offscreen context creation
#--------------------------------------------------------------------
if (_GLFW_OSMESA)
    find_package(OSMesa REQUIRED)
    list(APPEND glfw_LIBRARIES "${CMAKE_THREAD_LIBS_INIT}")
endif()

#--------------------------------------------------------------------
# Use Cocoa for window creation and NSOpenGL for context creation
#--------------------------------------------------------------------
if (_GLFW_COCOA)

    list(APPEND glfw_LIBRARIES
        "-framework Cocoa"
        "-framework IOKit"
        "-framework CoreFoundation"
        "-framework CoreVideo")

    set(glfw_PKG_DEPS "")
    set(glfw_PKG_LIBS "-framework Cocoa -framework IOKit -framework CoreFoundation -framework CoreVideo")
endif()

#--------------------------------------------------------------------
# Export GLFW library dependencies
#--------------------------------------------------------------------
foreach(arg ${glfw_PKG_DEPS})
    set(GLFW_PKG_DEPS "${GLFW_PKG_DEPS} ${arg}")
endforeach()
foreach(arg ${glfw_PKG_LIBS})
    set(GLFW_PKG_LIBS "${GLFW_PKG_LIBS} ${arg}")
endforeach()


### 

configure_file(glfw_config.h.in glfw_config.h @ONLY)

configure_file(glfw3.pc.in glfw3.pc @ONLY)

### set the library
set(common_HEADERS internal.h glfw_config.h glfw3.h glfw3native.h)
set(common_SOURCES context.c init.c input.c monitor.c vulkan.c window.c)

if (_GLFW_COCOA)
    set(glfw_HEADERS ${common_HEADERS} cocoa_platform.h cocoa_joystick.h
                     posix_thread.h nsgl_context.h egl_context.h osmesa_context.h)
    set(glfw_SOURCES ${common_SOURCES} cocoa_init.m cocoa_joystick.m
                     cocoa_monitor.m cocoa_window.m cocoa_time.c posix_thread.c
                     nsgl_context.m egl_context.c osmesa_context.c)
elseif (_GLFW_WIN32)
    set(glfw_HEADERS ${common_HEADERS} win32_platform.h win32_joystick.h
                     wgl_context.h egl_context.h osmesa_context.h)
    set(glfw_SOURCES ${common_SOURCES} win32_init.c win32_joystick.c
                     win32_monitor.c win32_time.c win32_thread.c win32_window.c
                     wgl_context.c egl_context.c osmesa_context.c)
elseif (_GLFW_X11)
    set(glfw_HEADERS ${common_HEADERS} x11_platform.h xkb_unicode.h posix_time.h
                     posix_thread.h glx_context.h egl_context.h osmesa_context.h)
    set(glfw_SOURCES ${common_SOURCES} x11_init.c x11_monitor.c x11_window.c
                     xkb_unicode.c posix_time.c posix_thread.c glx_context.c
                     egl_context.c osmesa_context.c)

    if ("${CMAKE_SYSTEM_NAME}" STREQUAL "Linux")
        set(glfw_HEADERS ${glfw_HEADERS} linux_joystick.h)
        set(glfw_SOURCES ${glfw_SOURCES} linux_joystick.c)
    else()
        set(glfw_HEADERS ${glfw_HEADERS} null_joystick.h)
        set(glfw_SOURCES ${glfw_SOURCES} null_joystick.c)
    endif()
elseif (_GLFW_WAYLAND)
    set(glfw_HEADERS ${common_HEADERS} wl_platform.h linux_joystick.h
                     posix_time.h posix_thread.h xkb_unicode.h egl_context.h
                     osmesa_context.h)
    set(glfw_SOURCES ${common_SOURCES} wl_init.c wl_monitor.c wl_window.c
                     linux_joystick.c posix_time.c posix_thread.c xkb_unicode.c
                     egl_context.c osmesa_context.c)

    ecm_add_wayland_client_protocol(glfw_SOURCES
        PROTOCOL
        "${WAYLAND_PROTOCOLS_PKGDATADIR}/unstable/relative-pointer/relative-pointer-unstable-v1.xml"
        BASENAME relative-pointer-unstable-v1)
    ecm_add_wayland_client_protocol(glfw_SOURCES
        PROTOCOL
        "${WAYLAND_PROTOCOLS_PKGDATADIR}/unstable/pointer-constraints/pointer-constraints-unstable-v1.xml"
        BASENAME pointer-constraints-unstable-v1)
elseif (_GLFW_MIR)
    set(glfw_HEADERS ${common_HEADERS} mir_platform.h linux_joystick.h
                     posix_time.h posix_thread.h xkb_unicode.h egl_context.h
                     osmesa_context.h)
    set(glfw_SOURCES ${common_SOURCES} mir_init.c mir_monitor.c mir_window.c
                     linux_joystick.c posix_time.c posix_thread.c xkb_unicode.c
                     egl_context.c osmesa_context.c)
elseif (_GLFW_OSMESA)
    set(glfw_HEADERS ${common_HEADERS} null_platform.h null_joystick.h
                     posix_time.h posix_thread.h osmesa_context.h)
    set(glfw_SOURCES ${common_SOURCES} null_init.c null_monitor.c null_window.c
                     null_joystick.c posix_time.c posix_thread.c osmesa_context.c)
endif()

if (APPLE)
    # For some reason, CMake doesn't know about .m
    set_source_files_properties(${glfw_SOURCES} PROPERTIES LANGUAGE C)
endif()

# Make GCC and Clang warn about declarations that VS 2010 and 2012 won't accept
# for all source files that VS will build
if (${CMAKE_C_COMPILER_ID} STREQUAL GNU OR ${CMAKE_C_COMPILER_ID} STREQUAL Clang)
    if (WIN32)
        set(windows_SOURCES ${glfw_SOURCES})
    else()
        set(windows_SOURCES ${common_SOURCES})
    endif()
    set_source_files_properties(${windows_SOURCES} PROPERTIES
        COMPILE_FLAGS -Wdeclaration-after-statement)
endif()

add_library(glfw ${glfw_SOURCES} ${glfw_HEADERS})
set_target_properties(glfw PROPERTIES
                      OUTPUT_NAME ${glfw_lib_name}
                      VERSION ${GLFW_VERSION}
                      SOVERSION ${GLFW_VERSION_MAJOR}
                      POSITION_INDEPENDENT_CODE ON
                      FOLDER "GLFW3")

target_compile_definitions(glfw PRIVATE
                           _GLFW_USE_CONFIG_H
                           $<$<BOOL:${UNIX}>:_XOPEN_SOURCE=600>)

                           
# HACK: When building on MinGW, WINVER and UNICODE need to be defined before
# the inclusion of stddef.h (by glfw3.h), which is itself included before
# win32_platform.h.  We define them here until a saner solution can be found
# NOTE: MinGW-w64 and Visual C++ do /not/ need this hack.
target_compile_definitions(glfw PRIVATE
                           "$<$<BOOL:${MINGW}>:UNICODE;WINVER=0x0501>")

# Enable a reasonable set of warnings (no, -Wextra is not reasonable)
target_compile_options(glfw PRIVATE
                       "$<$<C_COMPILER_ID:Clang>:-Wall>"
                       "$<$<C_COMPILER_ID:GNU>:-Wall>")

if (BUILD_SHARED_LIBS)
    if (WIN32)
        if (MINGW)
            # Remove the lib prefix on the DLL (but not the import library
            set_target_properties(glfw PROPERTIES PREFIX "")

            # Add a suffix to the import library to avoid naming conflicts
            set_target_properties(glfw PROPERTIES IMPORT_SUFFIX "dll.a")
        else()
            # Add a suffix to the import library to avoid naming conflicts
            set_target_properties(glfw PROPERTIES IMPORT_SUFFIX "dll.lib")
        endif()
    elseif (APPLE)
        # Add -fno-common to work around a bug in Apple's GCC
        target_compile_options(glfw PRIVATE "-fno-common")

        set_target_properties(glfw PROPERTIES
                              INSTALL_NAME_DIR "lib${LIB_SUFFIX}")
    elseif (UNIX)
        # Hide symbols not explicitly tagged for export from the shared library
        target_compile_options(glfw PRIVATE "-fvisibility=hidden")
    endif()

    target_compile_definitions(glfw INTERFACE GLFW_DLL)
    target_link_libraries(glfw PRIVATE ${glfw_LIBRARIES})
else()
    target_link_libraries(glfw INTERFACE ${glfw_LIBRARIES})
endif()

if (MSVC)
    target_compile_definitions(glfw PRIVATE _CRT_SECURE_NO_WARNINGS)
endif()

if (GLFW_INSTALL)
    install(TARGETS glfw
            EXPORT glfwTargets
            RUNTIME DESTINATION "bin"
            ARCHIVE DESTINATION "lib${LIB_SUFFIX}"
            LIBRARY DESTINATION "lib${LIB_SUFFIX}")
endif()

