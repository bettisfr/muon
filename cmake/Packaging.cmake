# Runtime dependencies are derived by dpkg-shlibdeps on the build host.
set(CPACK_GENERATOR DEB)
set(CPACK_PACKAGE_NAME muon)
set(CPACK_PACKAGE_VERSION "${PROJECT_VERSION}+qt6.1")
set(CPACK_PACKAGE_CONTACT "Muon fork maintainers")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "APT package manager for KDE Plasma 6")
set(CPACK_DEBIAN_PACKAGE_SECTION "kde")
set(CPACK_DEBIAN_PACKAGE_PRIORITY "optional")
set(CPACK_DEBIAN_FILE_NAME DEB-DEFAULT)
set(CPACK_DEBIAN_PACKAGE_SHLIBDEPS ON)
set(CPACK_DEBIAN_PACKAGE_DEPENDS "apt, debconf, polkitd, libdebconf-kde1 (>= 1.2.0)")
set(CPACK_DEBIAN_PACKAGE_RECOMMENDS "apt-xapian-index, software-properties-qt, kde-cli-tools")
set(CPACK_PACKAGING_INSTALL_PREFIX "/usr")
install(FILES "${PROJECT_SOURCE_DIR}/COPYING" "${PROJECT_SOURCE_DIR}/COPYING.GFDL"
    "${PROJECT_SOURCE_DIR}/AUTHORS"
    DESTINATION "${KDE_INSTALL_DATAROOTDIR}/doc/muon")
install(FILES "${PROJECT_SOURCE_DIR}/third_party/qapt/COPYING"
    DESTINATION "${KDE_INSTALL_DATAROOTDIR}/doc/muon" RENAME COPYING.QApt)
install(FILES "${PROJECT_SOURCE_DIR}/third_party/qapt/UPSTREAM.md"
    DESTINATION "${KDE_INSTALL_DATAROOTDIR}/doc/muon")
include(CPack)
