# $Id: Makefile,v 1.3 2005/10/14 17:20:27 svitak Exp $
# 
# Libmake: A Makefile template for creating a new user library.
#
# SYNOPSIS: It is recommended that each library have its own makefile
# and its own subdirectory for clarity of organization.  That makefile
# should be based on this template makefile.  The subdirectory should
# contain all of the object files needed to compile the library as well
# as all header files, support files, and the script file for loading
# the library (e.g. userlib.g).  The parent directory (the level above
# each library subdirectory) should contain a makefile based on the file
# "Usermake".
#
# PROCEDURE:
# 0) Copy this makefile to the subdirectory containing the particular
#    library you wish to build.
#
# 1) Edit the makefile to define values for the variables below:
#
#    LIBRARY_NAME
#	Set this to the desired name of the library.  In the example
#       library provided in Scripts/newlib, the name of the library is
#       "example".
#
#    FUNCTIONS
#	Set this to the name of the file containing the list of public
#	function names in the library.
#
#	Note: The FUNCTIONS file is not necessary in GENESIS 2.x, 
#             because public function names are added automatically when
#             referenced in the library startup script.  Functions not
#             referenced by an addfunc or object startup command may be
#             declared as public functions with the hashfunc startup
#             command.
#
#             If you are converting a 1.4 library to 2.0 you may use
#             the FUNCTIONS file by following the instructions below.
#
#    STRUCTURES
#	Set this to the name of the file containing the structure
#	definitions for objects in the library.
#
#    EXT_HEADER
#	Set this to the name of the header file containing the
#	appropriate include references needed to compile the library
#	files.
#
#    TARGET_OBJ
#	Set this to the name of the library object which will be
#	compiled This is normally just the LIBRARY_NAME with 'lib.o'
#	appended to it.
#
#    OBJECTS
#	List the user object files (with the .o extension) which will be
#	a part of the library.
#

# ----------------------------------------------------------------------
# BEGINNING OF USER-CONFIGURABLE SECTION
# ----------------------------------------------------------------------

# Provide values for the variables below.  Here is an example of what
# the values might be like:
#   LIBRARY_NAME = example
#   STARTUP	 = examplelib.g
#   STRUCTURES 	 = example_struct.h
#   EXT_HEADER	 = example_ext.h
#   TARGET_OBJ	 = examplelib.o

LIBRARY_NAME = example
STARTUP	 = examplelib.g
STRUCTURES 	 = example_struct.h
EXT_HEADER	 = example_ext.h
TARGET_OBJ	 = examplelib.o

OBJECTS		=  command.o example.o

# If really you want to use a FUNCTIONS file you can by setting it here
# and uncommenting the FSYMBOLTAB and FSYMBOLTAB_C lines.  In all
# likelyhood you will not need the FUNCTIONS file at all.

# FUNCTIONS 	= examplefuncs
# FSYMBOLTAB	= $(LIBRARY_NAME)_f@.o
# FSYMBOLTAB_C  = $(LIBRARY_NAME)_f@.c

# ----------------------------------------------------------------------
# BEGINNING OF COMMON SECTION
#
# NOTHING BEYOND THIS POINT SHOULD HAVE TO BE MODIFIED BY THE USER
# ----------------------------------------------------------------------

SHELL		= /bin/sh

# INSTALLDIR is passed in from the Usermake makefile.  If you're not using
# Usermake, either edit your top level makefile to pass it in or hard
# code the GENESIS 2.0 installation directory here.

GENESIS_LIB	= $(INSTALLDIR)/lib
GENESIS_INCLUDE	= -I. -I$(INSTALLDIR)/include
HEADERS 	= $(STRUCTURES)

default : $(TARGET_OBJ)

$(OBJECTS) : $(HEADERS) 

.c.o:
	$(CC) $(CFLAGS) $(GENESIS_INCLUDE) $< -c 

$(LIBRARY_NAME)_g@.c $(LIBRARY_NAME)_g@.h: $(STARTUP)
	- $(GENESIS_LIB)/code_g $(STARTUP) $(EXT_HEADER) $(LIBRARY_NAME)

# make the data structure section of the symbol table

$(LIBRARY_NAME)_d@.c : $(STRUCTURES) $(GENESIS_LIB)/code_sym
	- $(CPP) $(GENESIS_INCLUDE) $(STRUCTURES) > $(TMPDIR)/$(STRUCTURES)
	- $(GENESIS_LIB)/code_sym $(TMPDIR)/$(STRUCTURES) $(LIBRARY_NAME) \
	  -I $(EXT_HEADER) -NI -o $(LIBRARY_NAME)_d@.c
	- rm $(TMPDIR)/$(STRUCTURES)

# make the function list section of the symbol table

$(LIBRARY_NAME)_f@.c : $(FUNCTIONS) $(GENESIS_LIB)/code_func
	- $(GENESIS_LIB)/code_func $(FUNCTIONS) $(LIBRARY_NAME) \
	  > $(LIBRARY_NAME)_f@.c

# make the library header function

$(LIBRARY_NAME)_l@.c: $(LIBRARY_NAME)_g@.c $(LIBRARY_NAME)_d@.c $(FSYMBOLTAB_C) $(GENESIS_LIB)/code_lib $(OBJECTS)
	- $(GENESIS_LIB)/code_lib $(LIBRARY_NAME) -o $(LIBRARY_NAME)_l@.c

SYMBOLTAB = $(LIBRARY_NAME)_d@.o $(LIBRARY_NAME)_g@.o $(FSYMBOLTAB) $(LIBRARY_NAME)_l@.o

$(TARGET_OBJ): $(SYMBOLTAB) $(OBJECTS)
	ld -r -o $(TARGET_OBJ) $(OBJECTS) $(SYMBOLTAB)

clean:
	-(rm -rf *.o; rm -rf *@.[ch])

# End of Libmake.
