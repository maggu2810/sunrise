# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit multilib

DESCRIPTION="A small perl script for the creation of mathematic images in PostScript."
HOMEPAGE="http://syracuse.eu.org/syracuse/bbgraf/"

SRC_URI="http://syracuse.eu.org/syracuse/bbgraf/archives/${P/./-}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/perl
	app-text/ghostscript-gpl"

src_install() {
	insinto /usr/$(get_libdir)/syracuse/app

	doins -r "${WORKDIR}"/jps2ps || die

	# Fix permissions
	fperms guo=rx /usr/$(get_libdir)/syracuse/app/jps2ps/{jps2ps,filtre-file,jpshash,exp2rpn,lit_appels,lit_cles}.pl

	# Fix the variable JPS2PS_DIR defined inside the perl script
	# so it points to the right directory.
	# Based on the dev-lang/R ebuild regexp.
	sed \
		-e "/^\$JPS2PS_DIR = .*/s::\$JPS2PS_DIR = \"/usr/$(get_libdir)/syracuse/app/jps2ps/\";:" \
		-i "${D}"/usr/$(get_libdir)/syracuse/app/jps2ps/jps2ps.pl \
		|| die "sed failed."

	dosym /usr/$(get_libdir)/syracuse/app/jps2ps/jps2ps.pl /usr/bin/jps2ps
}
