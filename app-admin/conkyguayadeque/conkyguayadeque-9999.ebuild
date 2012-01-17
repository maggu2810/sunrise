# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
PYTHON_DEPEND="2"

inherit bzr distutils

DESCRIPTION="conky plugin for guayadeque"
HOMEPAGE="http://bazaar.launchpad.net/~conky-companions/+junk/conkyguayadeque"

EBZR_BRANCH="${PN}"
EBZR_REPO_URI="lp:~conky-companions/+junk/${EBZR_BRANCH}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-admin/conky
	media-sound/guayadeque"

src_prepare() {
	default
	python_convert_shebangs -r 2 .
}