cmake_minimum_required(VERSION 3.16)

project(waves VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(Qt6_DIR "$ENV{QT_DIR}/6.4.2/gcc_64/lib/cmake/Qt6")

find_package(Qt6 6.2 COMPONENTS Quick REQUIRED)

qt_add_executable(appwaves
    main.cpp
    delayaudiofeedback.cpp
)

qt_add_qml_module(appwaves
    URI waves
    VERSION 1.0
    QML_FILES main.qml 
)


set_target_properties(appwaves PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appwaves
    PRIVATE Qt6::Quick)

install(TARGETS appwaves
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
