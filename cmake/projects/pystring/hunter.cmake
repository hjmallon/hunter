# Copyright (c) 2016-2020, Rahul Sheth, Ruslan Baratov
# All rights reserved.

# !!! DO NOT PLACE HEADER GUARDS HERE !!!

include(hunter_add_version)
include(hunter_cacheable)
include(hunter_cmake_args)
include(hunter_download)
include(hunter_pick_scheme)

hunter_add_version(
    PACKAGE_NAME
    pystring
    VERSION
    20200204
    URL
    "https://github.com/hjmallon/pystring/tarball/4f653fc35421129eae8a2c424901ca7170059370"
    SHA1
    542bc9b83297fdf2ca39536beb4b1118a51fc507
)

hunter_cmake_args(
    pystring
    CMAKE_ARGS
        ENABLE_TESTING=OFF
)

hunter_pick_scheme(DEFAULT url_sha1_cmake)
hunter_cacheable(pystring)
hunter_download(PACKAGE_NAME pystring)
