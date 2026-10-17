set(qapt_SRCS
    backend.cpp
    cache.cpp
    package.cpp
    config.cpp
    history.cpp
    debfile.cpp
    dependencyinfo.cpp
    changelog.cpp
    transaction.cpp
    downloadprogress.cpp
    markingerrorinfo.cpp
    sourceentry.cpp
    sourceslist.cpp)

add_subdirectory(worker)

set_property(SOURCE ${CMAKE_CURRENT_BINARY_DIR}/worker/${QAPT_WORKER_RDN_VERSIONED}.transaction.xml
    APPEND PROPERTY
        INCLUDE downloadprogress.h
)
set_property(SOURCE ${CMAKE_CURRENT_BINARY_DIR}/worker/${QAPT_WORKER_RDN_VERSIONED}.transaction.xml
    APPEND PROPERTY
        NO_NAMESPACE 1
)

qt6_add_dbus_interface(qapt_SRCS
                       ${CMAKE_CURRENT_BINARY_DIR}/worker/${QAPT_WORKER_RDN_VERSIONED}.transaction.xml
                       transactioninterface_p)

set_property(SOURCE ${CMAKE_CURRENT_BINARY_DIR}/worker/${QAPT_WORKER_RDN_VERSIONED}.xml
    APPEND PROPERTY
        NO_NAMESPACE 1
)

qt6_add_dbus_interface(qapt_SRCS
                       ${CMAKE_CURRENT_BINARY_DIR}/worker/${QAPT_WORKER_RDN_VERSIONED}.xml
                       workerinterface_p)

configure_file(dbusinterfaces_p.h.cmake ${CMAKE_CURRENT_BINARY_DIR}/dbusinterfaces_p.h)


add_library(QApt STATIC ${qapt_SRCS})
add_library(QApt::Main ALIAS QApt)

# Set header paths for target so the utils can find them.
target_include_directories(QApt PUBLIC "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/..;${CMAKE_CURRENT_BINARY_DIR}/..>")

target_link_libraries(QApt
    PUBLIC
        Qt6::Widgets
        ${APTPKG_LIBRARIES}
    PRIVATE
        Qt6::DBus
        ${XAPIAN_LIBRARIES})


