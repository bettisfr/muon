<img src="src/icons/256-apps-muon.png" alt="Muon icon" width="96" height="96">

# Muon — Qt6 / KDE Frameworks 6 port

A community port of the classic **Muon Package Manager** to **Qt6 and KDE
Frameworks 6**, intended for use with Plasma 6 on APT based Linux distributions.
This is an independent fork, not an official KDE release.

Muon provides a detailed view of Debian packages, including dependencies,
available versions, installed files, package history, and pending changes.

## What changed in this fork

- Migrated the application from Qt5 / KDE Frameworks 5 to Qt6 / KDE Frameworks 6.
- Included a Qt6 port of QApt 3.0.5, the backend used to interact with APT.
- Updated obsolete Qt and KDE APIs and the loading indicators.
- Added a build script that creates a `.deb` with runtime dependencies.

The bundled QApt is built into Muon and its worker. Its system service uses a
separate D-Bus identity, allowing it to coexist with the distribution's Qt5 QApt.

## Status and compatibility

**Experimental, with initial checks on Ubuntu 26.04 amd64.** Compilation
from a fresh clone (with the documented build dependencies installed), `.deb`
generation, and application startup have been checked. Initial user testing
also confirms installation of the Muon package and installation, updates, and
removal of packages through Muon.

Debconf prompts and recovery from interrupted transactions still need testing. Authentication and package operations need
broader coverage across systems.

The build requires Qt 6.4 or newer, KDE Frameworks 6.11 or newer, and DebconfKDE
1.2 or newer built against Qt6. Other APT based distributions may work, but have
not been verified. The generated package depends on the libraries available on
the build system; a `.deb` built on Ubuntu 26.04 is not a generic package for all
Debian and Ubuntu releases.

Known limitations:

- The bundled QApt currently uses its English source strings.
- The inherited distribution release upgrade integration expects an external
  `releasechecker` script that this repository does not supply.

## Build and install

Clone the fork:

```sh
git clone https://github.com/bettisfr/muon.git
cd muon
```

Install the build dependencies listed in [BUILDING.md](BUILDING.md), then run:

```sh
./scripts/build-deb.sh
sudo apt install ./build-qt6/muon_5.8.0+qt6.2_amd64.deb
```

The filename above is for amd64; use the generated filename on other architectures.
APT resolves the declared runtime dependencies. The package installs in the
standard system paths under `/usr`, including `/usr/bin/muon` and the KDE menu
entry. It is installed as `muon` and replaces an existing package of that name.

Start it from the application menu or run:

```sh
muon
```

To uninstall:

```sh
sudo apt remove muon
```

See [BUILDING.md](BUILDING.md) for backend details and packaging instructions.

## Contributing

Reports from other systems are welcome. When opening an issue, include your
distribution and version, architecture, Qt / KDE Frameworks versions, steps to
reproduce the problem, and relevant build or terminal output. Contributions to
the Qt6 port and testing of package transactions are welcome.

## Credits and license

**Francesco Betti Sorbelli** — Qt6 / KDE Frameworks 6 port:
[bettisfr on GitHub](https://github.com/bettisfr).

This fork builds on the work of the original Muon and QApt authors and KDE
contributors. Existing copyright and license notices are preserved in the
sources; see [AUTHORS](AUTHORS), [COPYING](COPYING) and
[QApt's license](third_party/qapt/COPYING).

Moo.ogg was taken from wikipedia, and is licensed under the GFDL 1.2 license. It is copyright 2007 by Wikipedia user "Secretlondon" (Hint: it is part of an epic easter egg)
