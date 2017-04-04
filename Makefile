.PHONY: clean squid clamav cicap

clean:
	rm -rf $$HOME/opt/clamav
	rm -rf $$HOME/opt/squid
	rm -rf $$HOME/opt/cicap
	cd sources/clamav; make clean; git clean -xdf
	cd sources/squid; make clean; git clean -xdf
	cd sources/c-icap; make clean; git clean -xdf; git checkout .

squid: clamav
	cd sources/squid
	./configure --prefix=$$HOME/opt/squid 
	make
	make install

clamav: cicap
	cd sources/clamav
	./configure \
	    --prefix=$$HOME/opt/clamav \
	    --disable-clamav \
	    --with-systemdsystemunitdir=$$HOME/opt/clamav/systemd
	make
	make install
	install -c -m 644 config/freshclam.conf config/clamd.conf $$HOME/opt/clamav/etc
	mkdir $$HOME/opt/clamav/share/clamav

cicap:
	cd sources/c-icap
	./configure --prefix=$$HOME/opt/cicap 
	make
	sudo make install
	sudo chown -R $$USER:$$USER ~/opt/cicap
	sudo chown -R $$USER:$$USER /var/run/c-icap

