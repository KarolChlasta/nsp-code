/*********************************************************************
 *   Copyright 1993, UCAR/Unidata
 *   See netcdf/COPYRIGHT file for copying and redistribution conditions.
 *   $Header: /cvsroot/genesis-sim/genesis2/genesis/src/diskio/interface/netcdf/netcdf-3.4/src/nctest/misctest.c,v 1.1.1.1 2005/06/14 04:38:31 svitak Exp $
 *********************************************************************/

#include <stdio.h>
#include <string.h>
#include "netcdf.h"
#include "testcdf.h"		/* defines in-memory test cdf structure */
#include "add.h"		/* functions to update in-memory netcdf */
#include "error.h"


/*
 * Test nctypelen
 *    try with bad datatype, check error
 *    check returned values for each proper datatype
 */
void
test_nctypelen()
{
    int nerrs = 0;
    static char pname[] = "test_nctypelen";

    (void) fprintf(stderr, "*** Testing %s ...\t", &pname[5]);

    if (nctypelen(NC_BYTE) != sizeof(char)) {
	error("%s: nctypelen failed for NC_BYTE", pname);
	nerrs++;
    }
    if (nctypelen(NC_CHAR) != sizeof(char)) {
	error("%s: nctypelen failed for NC_CHAR", pname);
	nerrs++;
    }
    if (nctypelen(NC_SHORT) != sizeof(short)) {
	error("%s: nctypelen failed for NC_SHORT", pname);
	nerrs++;
    }
    if (nctypelen(NC_LONG) != sizeof(nclong)) {
	error("%s: nctypelen failed for NC_LONG", pname);
	nerrs++;
    }
    if (nctypelen(NC_FLOAT) != sizeof(float)) {
	error("%s: nctypelen failed for NC_FLOAT", pname);
	nerrs++;
    }
    if (nctypelen(NC_DOUBLE) != sizeof(double)) {
	error("%s: nctypelen failed for NC_DOUBLE", pname);
	nerrs++;
    }
    if (nerrs > 0)
      (void) fprintf(stderr,"FAILED! ***\n");
    else
      (void) fprintf(stderr,"ok ***\n");
}
