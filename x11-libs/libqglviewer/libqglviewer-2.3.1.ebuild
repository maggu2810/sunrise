# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit qt4-r2

MY_P="libQGLViewer-${PV}"

DESCRIPTION="Simple 3D viewer class for Qt OpenGL applications"
HOMEPAGE="http://www.libqglviewer.com"
SRC_URI="http://www.libqglviewer.com/src/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="virtual/opengl
	dev-qt/qtgui:4"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}/QGLViewer

src_configure() {
	true
}

src_compile() {
	eqmake4 QGLViewer.pro -o Makefile PREFIX=/usr
	emake || die "emake QGLViewer failed"

	cd ../designerPlugin
	eqmake4 designerPlugin.pro -o Makefile \
		INCLUDE_DIR=.. \
		LIB_DIR=../QGLViewer
	emake || die "emake designerPlugin failed"
}

src_install() {
	INSTALL_ROOT="${D}" emake install_target install_include || die "install QGLViewer failed"

	cd ../designerPlugin
	INSTALL_ROOT="${D}" emake install_target || die "install QGLViewer failed"

	dodoc ../README || die "installing README failed"

	if use doc ; then
		dohtml -r ../doc/* || die "installing html files failed"
		docinto examples
		dodoc ../examples/* || die "installing examples failed"
	fi
}
