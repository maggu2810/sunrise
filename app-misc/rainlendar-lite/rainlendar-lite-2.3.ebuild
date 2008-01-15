# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils autotools

MY_PN="Rainlendar-Lite"
MY_P=${MY_PN}-${PV}
DESCRIPTION="A very useful x11 calendar"
HOMEPAGE="http://www.rainlendar.net"
SRC_URI="http://www.rainlendar.net/download/${MY_P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
REPEND=">=x11-libs/gtk+-2
	dev-libs/atk
	x11-libs/libXext
	x11-libs/libXi
	x11-libs/libXinerama
	x11-libs/libXrandr
	x11-libs/libXcursor
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/pango"

S=${WORKDIR}/rainlendar2

RESTRICT="mirror strip"

QA_TEXTRELS="opt/rainlendar2/plugins/iCalendarPlugin.so"

pkg_setup() {
	if ! built_with_use '=x11-libs/gtk+-2*' xinerama ; then
		einfo "Please re-emerge x11-libs/gtk+ with the xinerama USE flag set"
		die "rainlendar needs the xinerama use flag set"
	fi
}

src_install() {
	insinto /opt/rainlendar2
	doins -r locale plugins resources scripts skins rainlendar2.htb
	dobin rainlendar2
	dodoc Changes.txt
}
