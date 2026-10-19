cmake_minimum_required(VERSION 3.16)

project(muon)
set(PROJECT_VERSION "5.9.0")
set(PROJECT_VERSION_MAJOR 5)

find_package(ECM REQUIRED NO_MODULE)

set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_DIR})

set(QT_DEFAULT_MAJOR_VERSION 6)
include(KDEInstallDirs6)
include(KDECMakeSettings NO_POLICY_SCOPE)
include(KDECompilerSettings NO_POLICY_SCOPE)
include(ECMInstallIcons)
include(ECMMarkAsTest)
include(GenerateExportHeader)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
find_package(Qt6 6.4 REQUIRED CONFIG COMPONENTS Widgets Concurrent Network)

find_package(KF6 6.11 REQUIRED COMPONENTS KIO DBusAddons I18n IconThemes XmlGui ColorScheme WidgetsAddons)

add_subdirectory(third_party/qapt)
find_package(DebconfKDE 1.2 REQUIRED)

set(MUON_VERSION ${PROJECT_VERSION})
configure_file(MuonVersion.h.in MuonVersion.h)

add_subdirectory(src)

feature_summary(WHAT ALL FATAL_ON_MISSING_REQUIRED_PACKAGES)

include(cmake/Packaging.cmake)
