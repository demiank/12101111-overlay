# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="ucontext implementation featuring glibc-compatible ABI"
HOMEPAGE="https://github.com/kaniini/libucontext"
SRC_URI="https://github.com/kaniini/libucontext/archive/refs/tags/${P}.tar.gz"
S="${WORKDIR}"/${PN}-${P}

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="+man"

BDEPEND="man? ( app-text/scdoc )"

# segfault needs investigation
RESTRICT="test"

PATCHES=(
	"${FILESDIR}"/${PN}-1.1-respect-CFLAGS.patch
)

src_compile() {
	tc-export AR CC

	arch=

	# Override arch detection
	# https://github.com/kaniini/libucontext/blob/master/Makefile#L3
	if use x86 ; then
		arch="x86"
	elif use arm ; then
		arch="arm"
	elif use arm64 ; then
		arch="aarch64"
	elif use ppc64 ; then
		arch="ppc64"
	else
		arch="$(uname -m)"
	fi

	emake \
		ARCH="${arch}" \
		LDFLAGS="${LDFLAGS}" \
		LIBDIR="/usr/$(get_libdir)" \
		all $(usev man 'docs')
}

src_test() {
	emake \
		ARCH="${arch}" \
		LDFLAGS="${LDFLAGS}" \
		LIBDIR="/usr/$(get_libdir)" \
		check
}

src_install() {
	emake \
		ARCH="${arch}" \
		DESTDIR="${ED}" \
		LIBDIR="/usr/$(get_libdir)" \
		install $(usev man 'install_docs')
}
