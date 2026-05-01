# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

cmake_minimum_required(VERSION 3.20)

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

include_directories(${CMAKE_SOURCE_DIR}/include)
include_directories(${CMAKE_SOURCE_DIR}/FlyIC.Kernel.Base/include)

if (NOT TARGET FlyIC.Kernel.Base)
	add_subdirectory(FlyIC.Kernel.Base ${CMAKE_CURRENT_SOURCE_DIR}/KernelBaseBuild)
endif()

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/lib/${CMAKE_BUILD_TYPE})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/lib/${CMAKE_BUILD_TYPE})

set(ProjectName FlyIC.Kernel.MemFunc)
project(${ProjectName})

set(COMPILE_BASE_FLAGS -nostdlib -ffreestanding -nostdinc++ -fno-exceptions -fno-rtti -fno-stack-protector -Wall -Wextra --target=x86_64-pc-linux-gnu)
set(LINK_BASE_FLAGS -nostdlib -Wl,e,startup -fuse-ld=lld)

if (${CMAKE_BUILD_TYPE} STREQUAL "Debug")
	set(COMPILE_EXT_FLAGS -g -O0)
else()
	set(COMPILE_EXT_FLAGS -g0 -O2)
endif()

add_library(${ProjectName} STATIC src/lib.cpp)

set_target_properties(${ProjectName} PROPERTIES PREFIX "${CMAKE_BUILD_TYPE} ")

target_compile_options(${ProjectName} PRIVATE ${COMPILE_BASE_FLAGS} ${COMPILE_EXT_FLAGS})
target_link_options(${ProjectName} PRIVATE ${LINK_BASE_FLAGS})
