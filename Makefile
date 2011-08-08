#	$NetBSD: $

.include <bsd.own.mk>
.include "${NETBSDSRCDIR}/distrib/common/Makefile.distrib"

IMAGE=		ramdisk.fs
IMAGESIZE=	2048k
MAKEFS_FLAGS=	-f 15

WARNS=		1
DBG=		-Os -march=armv4t -mtune=arm920t

SMALLPROG= 	0
SMALLPROG_INET6=1

CRUNCHBIN=	ramdiskbin
LISTS=		${.CURDIR}/list
MTREECONF=	${.CURDIR}/mtree.gta02
IMAGEENDIAN=	le
MAKEDEVTARGETS=	ramdisk sysmon wscons usbs bthub ttyS0 ttyS1 ttyS2
IMAGEDEPENDS=	${CRUNCHBIN} \
		dot.profile \
		${NETBSDSRCDIR}/etc/group ${NETBSDSRCDIR}/etc/master.passwd \
		${NETBSDSRCDIR}/etc/netconfig ${DISTRIBDIR}/common/protocols \
		${DISTRIBDIR}/common/services

# Use stubs to eliminate some large stuff from libc
HACKSRC=	${DISTRIBDIR}/utils/libhack
.include	"${HACKSRC}/Makefile.inc"
${CRUNCHBIN}:	libhack.o

.include "${DISTRIBDIR}/common/Makefile.crunch"
.include "${DISTRIBDIR}/common/Makefile.makedev"
.include "${DISTRIBDIR}/common/Makefile.image"

release:

.include <bsd.prog.mk>
