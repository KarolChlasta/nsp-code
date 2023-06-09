/*********************************************************************
 *   Copyright 1993, UCAR/Unidata
 *   See netcdf/COPYRIGHT file for copying and redistribution conditions.
 *   $Header: /cvsroot/genesis-sim/genesis2/genesis/src/diskio/interface/netcdf/netcdf-3.4/src/nctest/testcdf.h,v 1.1.1.1 2005/06/14 04:38:31 svitak Exp $
 *********************************************************************/

/* 
 * In-memory structure holding netcdf structure for comparing with 
 * on-disk netcdf.  Whenever a disk netcdf is updated in the test 
 * package, this structure should be updated at the same time, to keep 
 * them in sync.
 */


#define ___ 0			/* marker for structure place-holder */
#define BAD_TYPE  ((nc_type)0) /* must be distinct from valid types */

struct cdfdim {			/* dimension */
    char *name;
    long size;
};

struct cdfvar {			/* variable */
    char *name;
    nc_type type;
    int ndims;
    int *dims;
    int natts;
};

struct cdfatt {			/* attribute */
    int var;
    char *name;
    nc_type type;
    int len;
    void *val;
};

#define MAX_TEST_DIMS 32
#define MAX_TEST_VARS 32
#define MAX_TEST_ATTS 32

struct netcdf {
    int ndims;			/* number of dimensions declared for netcdf */
    int nvars;			/* number of variables declared for netcdf */
    int natts;			/* number of attributes */
    int ngatts;			/* number of global attributes */
    int xdimid;			/* number of the unlimited dimension, if any */
    struct cdfdim dims[MAX_TEST_DIMS]; /* dimensions */
    struct cdfvar vars[MAX_TEST_VARS]; /* variables */
    struct cdfatt atts[MAX_TEST_ATTS]; /* attributes */
};


extern struct netcdf test;	/*
				 * in-memory netcdf structure, kept in sync
				 * with disk netcdf
				 */
