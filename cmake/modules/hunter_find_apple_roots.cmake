include(CMakeParseArguments) # cmake_parse_arguments

include(hunter_fatal_error)

function(hunter_find_apple_roots)
    # See CMake Darwin-Initialize.cmake
    # Resolves the SDK name into a path
    function(_apple_resolve_sdk_path sdk_name ret)
        execute_process(
        COMMAND xcrun -sdk ${sdk_name} --show-sdk-path
        OUTPUT_VARIABLE _stdout
        OUTPUT_STRIP_TRAILING_WHITESPACE
        ERROR_VARIABLE _stderr
        RESULT_VARIABLE _failed
        )
        set(${ret} "${_stdout}" PARENT_SCOPE)
        message(STATUS "kjhkjhkjhkj ${_stdout}")
    endfunction()

    function(_apple_resolve_sdk_root_path sdk_name ret)
        execute_process(
        COMMAND xcrun -sdk ${sdk_name} --show-sdk-platform-path
        OUTPUT_VARIABLE _stdout
        OUTPUT_STRIP_TRAILING_WHITESPACE
        ERROR_VARIABLE _stderr
        RESULT_VARIABLE _failed
        )
        set(${ret} "${_stdout}/Developer" PARENT_SCOPE)
        message(STATUS "kjhkjhkjhkj ${_stdout}")
    endfunction()

    if("${CMAKE_SYSTEM_NAME}" STREQUAL "iOS" OR "${CMAKE_SYSTEM_NAME}" STREQUAL "tvOS" OR "${CMAKE_SYSTEM_NAME}" STREQUAL "watchOS")
        if(CMAKE_OSX_SYSROOT)

            if("x${CMAKE_OSX_SYSROOT}" MATCHES "/")
                hunter_fatal_error(
                    "CMAKE_OSX_SYSROOT appears to be a path, cannot find simulator and device SDKs:"
                    "  ${CMAKE_OSX_SYSROOT}"
                )
            elseif("${CMAKE_OSX_SYSROOT}" MATCHES "simulator$")
                set(_simulator_sdk "${CMAKE_OSX_SYSROOT}")
                string(REPLACE "simulator" "os" _os_sdk ${CMAKE_OSX_SYSROOT})
            else()
                set(_os_sdk "${CMAKE_OSX_SYSROOT}")
                string(REPLACE "os" "simulator" _simulator_sdk ${CMAKE_OSX_SYSROOT})
            endif()

            _apple_resolve_sdk_path(${_simulator_sdk} _simulator_sdk_path)
            _apple_resolve_sdk_path(${_os_sdk} _os_sdk_path)

            _apple_resolve_sdk_root_path(${_simulator_sdk} _simulator_sdk_root_path)
            _apple_resolve_sdk_root_path(${_os_sdk} _os_sdk_root_path)

            if(NOT IPHONESIMULATOR_SDK_ROOT)
                set(IPHONESIMULATOR_SDK_ROOT "${_simulator_sdk_path}" PARENT_SCOPE)
                set(IPHONESIMULATOR_ROOT "${_simulator_sdk_root_path}" PARENT_SCOPE)
            endif()

            if(NOT IPHONEOS_SDK_ROOT)
                set(IPHONEOS_SDK_ROOT "${_os_sdk_path}" PARENT_SCOPE)
                set(IPHONEOS_ROOT "${_os_sdk_root_path}" PARENT_SCOPE)
            endif()
        endif()
    endif()
endfunction()
