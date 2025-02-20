# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit java-vm-2 toolchain-funcs

MY_ZULU_PV="11.54.25-ca-jdk11.0.14.1"
MY_ZULU_ARCH="linux_musl_x64"
MY_PV=${PV/_p/+}
SLOT=${MY_PV%%[.+]*}

SRC_URI="
	amd64? ( https://cdn.azul.com/zulu/bin/zulu${MY_ZULU_PV}-${MY_ZULU_ARCH}.tar.gz )
"

DESCRIPTION="Prebuilt Java JDK binaries for musl provided by Zulu"
HOMEPAGE="https://www.azul.com/downloads/zulu-community/"
LICENSE="GPL-2-with-classpath-exception"
KEYWORDS="~amd64"
IUSE="alsa cups headless-awt selinux source"

RDEPEND="
	media-libs/fontconfig:1.0
	media-libs/freetype:2
	media-libs/harfbuzz
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

RESTRICT="preserve-libs splitdebug"
QA_PREBUILT="*"

S="${WORKDIR}/zulu${MY_ZULU_PV}-${MY_ZULU_ARCH}"

src_install() {
	local dest="/opt/${P}"
	local ddest="${ED}/${dest#/}"

	# on macOS if they would exist they would be called .dylib, but most
	# importantly, there are no different providers, so everything
	# that's shipped works.
	if [[ ${A} != *_mac_* ]] ; then
		# Not sure why they bundle this as it's commonly available and they
		# only do so on x86_64. It's needed by libfontmanager.so. IcedTea
		# also has an explicit dependency while Oracle seemingly dlopens it.
		rm -vf lib/libfreetype.so || die

		# prefer system copy # https://bugs.gentoo.org/776676
		rm -vf lib/libharfbuzz.so || die

		# Oracle and IcedTea have libjsoundalsa.so depending on
		# libasound.so.2 but AdoptOpenJDK only has libjsound.so. Weird.
		if ! use alsa ; then
			rm -v lib/libjsound.* || die
		fi

		if use headless-awt ; then
			rm -v lib/lib*{[jx]awt,splashscreen}* || die
		fi
	fi

	if ! use source ; then
		rm -v lib/src.zip || die
	fi

	rm -v lib/security/cacerts || die
	dosym -r /etc/ssl/certs/java/cacerts "${dest}"/lib/security/cacerts

	dodir "${dest}"
	cp -pPR * "${ddest}" || die

	# provide stable symlink
	dosym "${P}" "/opt/${PN}-${SLOT}"

	java-vm_install-env "${FILESDIR}"/${PN}-${SLOT}.env.sh
	java-vm_set-pax-markings "${ddest}"
	java-vm_revdep-mask
	java-vm_sandbox-predict /dev/random /proc/self/coredump_filter
}

pkg_postinst() {
	java-vm-2_pkg_postinst
}
