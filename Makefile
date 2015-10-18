all: install

clean:
	rm -rf \
		debian/files \
		debian/zfsu \
		debian/zfsu.* \
		../zfsu_*.build \
		../zfsu_*.changes \
		../zfsu_*.tar.gz \
		../zfsu_*.deb \
		../zfsu_*.dsc

install: clean
	dpkg-buildpackage

