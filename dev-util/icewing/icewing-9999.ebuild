# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit cmake-utils subversion

DESCRIPTION="Integrated Communication Environment Which Is Not Gesten"
HOMEPAGE="http://icewing.sf.net/"
SRC_URI=""

ESVN_REPO_URI="http://icewing.svn.sourceforge.net/svnroot/icewing/iceWing/trunk"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
# need to add xcf, dacs, mvimpact as use-flags (and packages)
IUSE="debug ffmpeg +grabber ieee1394 jpeg png readline"

DEPEND="
	sys-libs/zlib
	x11-libs/gtk+:2
	x11-libs/gdk-pixbuf[jpeg?]
	ffmpeg? ( virtual/ffmpeg )
	ieee1394? ( sys-libs/libraw1394 media-libs/libdc1394:2 )
	jpeg? ( virtual/jpeg )
	png? ( media-libs/libpng )
	readline? ( sys-libs/readline )"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs="
		-DDEBUG:BOOL=$(use debug && echo ON || echo OFF)
		$(cmake-utils_use_with ffmpeg FFMPEG)
		$(cmake-utils_use_with grabber GRABBER)
		$(cmake-utils_use_with ieee1394 FIRE2)
		$(cmake-utils_use_with jpeg JPEG)
		$(cmake-utils_use_with png PNG)
		$(cmake-utils_use_with readline READLINE)
		-DWITH_GTK1=OFF
		-DWITH_DACS=OFF
		-DWITH_MVIMPACT=OFF
		-DWITH_XCF=OFF"
	einfo "configure arguments: $mycmakeargs"
	cmake-utils_src_configure
}

pkg_postinst() {
	elog "Plugins are now compiled into the icewing executable."
	elog "Issue 'icewing --help' for a list of available plugins."
}
