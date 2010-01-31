# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit autotools eutils toolchain-funcs

MY_P="SambaScanner-${PV}"
DESCRIPTION="a tool to search a whole samba network for files"
HOMEPAGE="http://www.johannes-bauer.com/sambascanner/"
SRC_URI="http://www.johannes-bauer.com/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug linguas_de"

RDEPEND=">=net-fs/samba-3"
DEPEND="${RDEPEND}
	sys-libs/glibc[nptl]
	sys-devel/gettext"

S=${WORKDIR}/${MY_P}

src_prepare() {
	if use debug; then
		#prevent configure from completely replacing our CFLAGS
		sed 's:CFLAGS="-O0 -g -pthread":CFLAGS="${CFLAGS} -g -pthread":' -i configure.ac
		eautoreconf
	fi
}

src_configure() {
	econf CFLAGS="${CFLAGS} -pthread" $(use_enable debug)
}

src_compile() {
	emake CC=$(tc-getCC) || die "emake failed"
}

src_install() {
	# sambascanner's make install is broken
	dobin src/sambascanner bin/sambaretrieve src/smblister
	insinto /usr/share/${PN}/
	doins -r db
	use linguas_de && domo i18n/de.mo
	dodoc AUTHORS ChangeLog README sambascannerrc-example db/db.conf.sample
}
