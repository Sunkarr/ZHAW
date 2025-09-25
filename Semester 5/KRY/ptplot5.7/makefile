all makefiles sources install docs depend checkjunk sccsinfo sccsclean test extraclean clean: mk/ptII.mk
	cd com/microstar/xml/; make $@
	cd ptolemy/gui; make $@
	cd ptolemy/util; make $@
	cd ptolemy/plot; make $@
	cd bin; make $@
# Generate ptII.mk by running configure
mk/ptII.mk: configure mk/ptII.mk.in
	./configure
realclean itcldocs tests idocs weblint dists:
	echo "Nothing need be done for  in ptolemy/plot)"
