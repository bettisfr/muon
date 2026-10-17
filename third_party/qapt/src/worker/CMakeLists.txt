configure_file(org.kubuntu.qaptworker.transaction.xml.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/${QAPT_WORKER_RDN_VERSIONED}.transaction.xml)
configure_file(org.kubuntu.qaptworker.xml.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/${QAPT_WORKER_RDN_VERSIONED}.xml)
configure_file(org.kubuntu.qaptworker.service.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/${QAPT_WORKER_RDN_VERSIONED}.service)
configure_file(qaptworker.actions.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/${QAPT_WORKER_RDN_VERSIONED}.actions)
configure_file(org.kubuntu.qaptworker.policy.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/${QAPT_WORKER_RDN_VERSIONED}.policy)
configure_file(org.kubuntu.qaptworker.conf.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/${QAPT_WORKER_RDN_VERSIONED}.conf)
configure_file(urihelper.h.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/urihelper.h)

include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_BINARY_DIR}
    ${PROJECT_SOURCE_DIR}/src)

set(qapt_worker_SRCS
    main.cpp
    aptlock.cpp
    aptworker.cpp
    transaction.cpp
    transactionqueue.cpp
    workeracquire.cpp
    workerdaemon.cpp
    workerinstallprogress.cpp)

qt6_add_dbus_adaptor(qapt_worker_adaptor_SRCS
    ${CMAKE_CURRENT_BINARY_DIR}/${QAPT_WORKER_RDN_VERSIONED}.transaction.xml
    transaction.h
    Transaction
    transactionadaptor
    TransactionAdaptor)

qt6_add_dbus_adaptor(qapt_worker_SRCS
    ${CMAKE_CURRENT_BINARY_DIR}/${QAPT_WORKER_RDN_VERSIONED}.xml
    workerdaemon.h
    WorkerDaemon
    workeradaptor
    WorkerAdaptor)

add_executable(qaptworker${QAPT_WORKER_VERSION}
    ${qapt_worker_SRCS}
    ${qapt_worker_adaptor_SRCS})

target_link_libraries(qaptworker${QAPT_WORKER_VERSION}
    Qt6::Core
    Qt6::Core5Compat
    Qt6::DBus
    PolkitQt6-1::Core
    util
    QApt::Main)

install(TARGETS qaptworker${QAPT_WORKER_VERSION} DESTINATION ${KDE_INSTALL_LIBEXECDIR}/muon)

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/${QAPT_WORKER_RDN_VERSIONED}.service
        DESTINATION ${KDE_INSTALL_DBUSSYSTEMSERVICEDIR})

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/${QAPT_WORKER_RDN_VERSIONED}.policy
    DESTINATION ${KDE_INSTALL_DATAROOTDIR}/polkit-1/actions)

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/${QAPT_WORKER_RDN_VERSIONED}.conf
    DESTINATION ${KDE_INSTALL_DBUSDIR}/system.d/)
