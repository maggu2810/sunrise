# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit git-2 linux-mod

DESCRIPTION="LTTng Kernel Tracer Modules"
HOMEPAGE="http://lttng.org"
EGIT_REPO_URI="git://git.lttng.org/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

CONFIG_CHECK="MODULES KALLSYMS HIGH_RES_TIMERS TRACEPOINTS
	~HAVE_SYSCALL_TRACEPOINTS ~PERF_EVENTS ~EVENT_TRACING ~KPROBES KRETPROBES"

pkg_pretend() {
	if kernel_is lt 2 6 27; then
		eerror "${PN} require Linux kernel >= 2.6.27"
		die "Please update your kernel!"
	fi
}

src_compile() {
	emake default
}

src_install() {
	emake DESTDIR="${D}" INSTALL_MOD_PATH="${D}" modules_install
}
