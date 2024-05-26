SUMMARY = "Hello World recipe"
SECTION = "examples"
LICENSE = "CLOSED"

SRC_URI = "file://main.cpp"

S = "${WORKDIR}"

do_compile() {
	     ${CXX} ${CXXFLAGS} ${LDFLAGS} main.cpp -o helloworld 
}

do_install() {
	     install -d ${D}${bindir}
	     install -m 0755 helloworld ${D}${bindir}
}

FILES_${PN} += "${bindir}/helloworld_0.1"