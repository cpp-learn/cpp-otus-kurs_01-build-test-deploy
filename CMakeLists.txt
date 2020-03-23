cmake_minimum_required(VERSION 3.2)

project(classwork01 VERSION 0.0.$ENV{TRAVIS_BUILD_NUMBER})

find_package(Threads REQUIRED)
find_package(Boost COMPONENTS unit_test_framework REQUIRED)

configure_file(version.h.in ${PROJECT_SOURCE_DIR}/version.h)

# бинарник
add_executable(hellowrold_cli main.cpp)

# статическая библиоткеа
add_library(helloworld lib.cpp)

# бинарник
add_executable(test_version test_version.cpp)

set_target_properties(helloworld_cli helloworld test_version PROPERTIES
	CXX_STANDARD 17
	CXX_STANDARD_REQUIRED ON
	COMPILE_OPTIONS "-Wpedantic;-Wall-Wextra" # включение ворнингов
)

set_target_properties(test_version PROPERTIES
	COMPILE_DEFINITIONS BOOST_TEST_DYN_LINK
	INCLUDE_DIRECTORIES ${Boost_INCLUDE_DIR}
)

target_link_libraries(helloworld_cli
	helloworld
	Threads::Threads
)

target_link_libraries(test_version
	${Boost_LIBRARIES}
	helloworld
)

# done

# что дальше делать с бинарниками

install(TARGETS helloworld_cli RUNTIME DESTINATION bin)

set(CPACK_GENERATOR DEB)

set(CPACK_PACKAGE_VERSION_MAJOR "${PROJECT_VERSION_MAJOR}")
set(CPACK_PACKAGE_VERSION_MINOR "${PROJECT_VERSION_MINOR}")
set(CPACK_PACKAGE_VERSION_PATCH "${PROJECT_VERSION_PATCH}")

set(CPACK_PACKAGE_CONTACT ifgeny87@gmail.com)

# проверь бинарники на наличеие необходимых либ
# если они нужны, то найди пакет и добавь зависимости
set(CPACK_DEBIAN_PACKAGE_SHLIBDEPS ON)

include(CPack)

# запустить все тесты после компиляции
enable_testing()

# тестовый бинарник, который надо запустить
add_test(helloworld_tests test_version)
