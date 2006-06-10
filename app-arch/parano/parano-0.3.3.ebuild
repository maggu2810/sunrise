# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit gnome2

DESCRIPTION="GNOME program to create, edit and verify hashfiles"
HOMEPAGE="http://parano.berlios.de"
SRC_URI="http://download.berlios.de/parano/${P}.tar.gz
		http://download2.berlios.de/parano/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=dev-python/pygtk-2.0
		dev-python/gnome-python"
DEPEND="${RDPENED}"

RESTRICT="nomirror"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Removes update-mime-database error
	epatch "${FILESDIR}"/${P}-makefile.patch
}

src_install() {
	emake install DESTDIR="${D}"
	dodoc AUTHORS ChangeLog README NEWS TODO
}
