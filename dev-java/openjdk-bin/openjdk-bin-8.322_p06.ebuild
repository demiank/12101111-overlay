# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit java-vm-2

MY_ZULU_PV="8.60.0.21-ca-jdk8.0.322"
MY_ZULU_ARCH="linux_musl_x64"
MY_PV=${PV/_p/+}
SLOT=${MY_PV%%[.+]*}

DESCRIPTION="Prebuilt Java JDK binaries for musl provided by Zulu"
HOMEPAGE="https://www.azul.com/downloads/zulu-community/"
SRC_URI="
	amd64? ( https://cdn.azul.com/zulu/bin/zulu${MY_ZULU_PV}-${MY_ZULU_ARCH}.tar.gz )
"

LICENSE="GPL-2-with-classpath-exception"
KEYWORDS="~amd64"

IUSE="alsa cups examples headless-awt selinux source"

RDEPEND="
	media-libs/fontconfig:1.0
	media-libs/freetype:2
	>=sys-apps/baselayout-java-0.1.0-r1
	>=sys-libs/musl-1.1.15
	sys-libs/zlib
	alsa? ( media-libs/alsa-lib )
	cups? ( net-print/cups )
	selinux? ( sec-policy/selinux-java )
	!headless-awt? (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXi
		x11-libs/libXrender
		x11-libs/libXtst
	)"

RESTRICT="preserve-libs strip"
QA_PREBUILT="*"

S="${WORKDIR}/zulu${MY_ZULU_PV}-${MY_ZULU_ARCH}"

src_unpack() {
	default
	# 753575
	if use arm; then
		mv -v "${S}"* "${S}" || die
	elif [[ ${A} == *_mac_* ]] ; then
		mv -v "${S}/Contents/Home/"* "${S}" || die
		rm -Rf "${S}/Contents"  # drop macOS executable
	fi
}

src_install() {
	local dest="/opt/${P}"
	local ddest="${ED}/${dest#/}"

	rm ASSEMBLY_EXCEPTION LICENSE THIRD_PARTY_README || die

	# on macOS if they would exist they would be called .dylib, but most
	# importantly, there are no different providers, so everything
	# that's shipped works.
	if [[ ${A} != *_mac_* ]] ; then
		# this does not exist on arm64 hence -f
		rm -fv jre/lib/*/libfreetype.so* || die

		if ! use alsa ; then
			rm -v jre/lib/*/libjsoundalsa.so* || die
		fi

		if ! use examples ; then
			rm -vr sample || die
		fi

		if use headless-awt ; then
			rm -fvr {,jre/}lib/*/lib*{[jx]awt,splashscreen}* \
				{,jre/}bin/policytool bin/appletviewer || die
		fi
	fi

	if ! use source ; then
		rm -v src.zip || die
	fi

	rm -v jre/lib/security/cacerts || die
	dosym ../../../../../etc/ssl/certs/java/cacerts \
		"${dest}"/jre/lib/security/cacerts

	dodir "${dest}"
	cp -pPR * "${ddest}" || die

	# provide stable symlink
	dosym "${P}" "/opt/${PN}-${SLOT}"

	java-vm_install-env "${FILESDIR}"/${PN}-${SLOT}.env.sh
	java-vm_set-pax-markings "${ddest}"
	java-vm_revdep-mask
	java-vm_sandbox-predict /dev/random /proc/self/coredump_filter
}
