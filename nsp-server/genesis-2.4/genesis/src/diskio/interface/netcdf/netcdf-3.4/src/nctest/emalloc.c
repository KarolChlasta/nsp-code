/*********************************************************************
 *   Copyright 1993, UCAR/Unidata
 *   See netcdf/COPYRIGHT file for copying and redistribution conditions.
 *   $Header: /cvsroot/genesis-sim/genesis2/genesis/src/diskio/interface/netcdf/netcdf-3.4/src/nctest/emalloc.c,v 1.1.1.1 2005/06/14 04:38:31 svitak Exp $
 *********************************************************************/

/*LINTLIBRARY*/
#include <stdio.h>
#include <stdlib.h>
#include "error.h"
#include "emalloc.h"

void *
emalloc (size)			/* check return from malloc */
     size_t size;
{
    void   *p;

    if (size > (unsigned long)32767) {
        error ("absurd arg to emalloc: %lu", (unsigned long) size);
	return 0;
    }
    if (size == 0)
      return 0;
    p = (void *) malloc (size);
    if (p == 0) {
	error ("out of memory\n");
	exit (1);
    }
    return p;
}

void *
erealloc (ptr, size)		/* check return from realloc */
     void *ptr;
     size_t size;
{
    void *p;

    if (size >  (unsigned long)32767) {
        error ("absurd arg to erealloc %lu", (unsigned long) size);
	return 0;
    }
    p = (void *) realloc (ptr, size);

    if (p == 0) {
 	error ("out of memory");
	exit(1);
    }
    return p;
}
