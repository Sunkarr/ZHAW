ptplot5.7 - A Java plotting package
Ptplot is a set of two dimensional signal plotters
implemented in Java.
Ptplot is embeddable in applets and applications.
For more information, see ptolemy/plot/doc/index.htm

Installer notes:
If you are using the auto installer, then note that
under Windows, the Ptplot programs will be added to
your start menu under Ptolemy -> Ptplot.  Note further
that directory names with spaces do not work very well
 because of limitations Java 1.4.0

If you are building from a tar or zip file, then note that
the file ptplot5.7.tar.gz or
ptplot5.7.zip, will unpack into a directory
called ptplot5.7, and the configure-make-make install
process will not install any files outside of this 
ptplot5.7 directory.
So, if you unpack the TAR file into /usr/local, after 
installing you will have /usr/local/ptplot5.7,
and you may want to tell users to add 
/usr/local/ptplot5.7/bin to their PATH.
The scripts in the bin directory will run the plotter
as a standalone application, or they can add
/usr/local/ptplot5.7 to their Java CLASSPATH.

To build under Solaris:
Set the PTII variable to this directory: 
PTII=/tmp/cxh/ptII7.0.1.devel/ptolemy/plot 
Then configure and make:
./configure
make install
bin/ptplot

