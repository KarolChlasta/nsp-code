divert(-1)

changequote(<<,>>)

define(<<CODE>>, <<\fB$1\fR>>)

define(<<ARG>>, <<\fI$1\fP>>)

define(<<HEADER_FILE>>, 
    <<ifelse(API,C,
	$1.h,
	$1.inc)>>)

define(<<INCLUDE>>, 
    <<ifelse(API,C,
	<<#include>> "HEADER_FILE($1)",
	<<<<include>>>> HEADER_FILE($1))>>)

define(<<COMPILER>>,
    <<ifelse(API,C,
	cc,
	f77)>>)

define(<<LANGUAGE>>,
    <<ifelse(API,C,
	C,
	FORTRAN)>>)

define(<<RETSTR>>,
    <<ifelse(API,C,
	const char*,
	character*80)>>)

define(<<FNAME>>,
    <<ifelse(API,C,
	nc_$1,
	nf_$1)>>)

define(<<VOID_ARG>>,
    <<ifelse(API,C,,void)>>)

define(<<MACRO>>,
    <<CODE(ifelse(API,C,
	NC_$1,
	NF_$1))>>)

dnl AQUAL(io, rank)
define(<<AQUAL>>, <<ifelse(API,C,
    <<ifelse($1, output, , <<ifelse($2, 0, , const )>>)>>)>>)

dnl CTYPE(type)
define(<<CTYPE>>,
    <<ifelse($1,text,char,
    <<ifelse($1,uchar,unsigned char,
    <<ifelse($1,schar,signed char,
    <<ifelse($1,short,short,
    <<ifelse($1,int,int,
    <<ifelse($1,nc_type,nc_type,
    <<ifelse($1,size_t,size_t,
    <<ifelse($1,ptrdiff_t,ptrdiff_t,
    <<ifelse($1,long,long,
    <<ifelse($1,float,float,
    <<ifelse($1,double,double)>>)>>)>>)>>)>>)>>)>>)>>)>>)>>)>>)

dnl CSTAR(io, rank)
define(<<CSTAR>>, <<ifelse($1,input,,<<ifelse($2,0,*)>>)>>)

dnl FTYPE(type, rank)
define(<<FTYPE>>, 
    <<ifelse($1,text,<<character*ifelse($2,0,1,(*))>>,
    <<ifelse($1,schar,integer*1,
    <<ifelse($1,short,integer*2,
    <<ifelse($1,int,integer,
    <<ifelse($1,nc_type,integer,
    <<ifelse($1,size_t,integer,
    <<ifelse($1,ptrdiff_t,integer,
    <<ifelse($1,long,integer,
    <<ifelse($1,float,real,
    <<ifelse($1,double,doubleprecision)>>)>>)>>)>>)>>)>>)>>)>>)>>)>>)

dnl ATYPE(io,rank,type)
define(<<ATYPE>>, <<ifelse(API,C,
    <<CTYPE($3)<<>>CSTAR($1,$2)>>, 
    <<FTYPE($3,$2)>>)>>)

dnl AID(name, rank, type)
define(<<AID>>, <<ARG($1)<<>>ifelse(API,C,
    <<ifelse($2,0,,[])>>, 
    <<ifelse($3,text,,<<ifelse($2,0,,(1))>>)>>)>>)

dnl ADECL(io, rank, type, name)
define(<<ADECL>>, <<AQUAL($1,$2)ATYPE($1,$2,$3) AID($4,$2,$3)>>)

define(<<ITEXT>>,	<<ADECL(input,0,text,$1)>>)
define(<<ITEXTV>>,	<<ADECL(input,1,text,$1)>>)
define(<<OTEXT>>,	<<ADECL(output,0,text,$1)>>)
define(<<OTEXTV>>,	<<ADECL(output,1,text,$1)>>)

define(<<IUCHAR>>,	<<ADECL(input,0,uchar,$1)>>)
define(<<IUCHARV>>,	<<ADECL(input,1,uchar,$1)>>)
define(<<OUCHAR>>,	<<ADECL(output,0,uchar,$1)>>)
define(<<OUCHARV>>,	<<ADECL(output,1,uchar,$1)>>)

define(<<ISCHAR>>,	<<ADECL(input,0,schar,$1)>>)
define(<<ISCHARV>>,	<<ADECL(input,1,schar,$1)>>)
define(<<OSCHAR>>,	<<ADECL(output,0,schar,$1)>>)
define(<<OSCHARV>>,	<<ADECL(output,1,schar,$1)>>)

define(<<ISHORT>>,	<<ADECL(input,0,short,$1)>>)
define(<<ISHORTV>>,	<<ADECL(input,1,short,$1)>>)
define(<<OSHORT>>,	<<ADECL(output,0,short,$1)>>)
define(<<OSHORTV>>,	<<ADECL(output,1,short,$1)>>)

define(<<IINT>>,	<<ADECL(input,0,int,$1)>>)
define(<<IINTV>>,	<<ADECL(input,1,int,$1)>>)
define(<<OINT>>,	<<ADECL(output,0,int,$1)>>)
define(<<OINTV>>,	<<ADECL(output,1,int,$1)>>)

define(<<INCTYPE>>,	<<ADECL(input,0,nc_type,$1)>>)
define(<<INCTYPEV>>,	<<ADECL(input,1,nc_type,$1)>>)
define(<<ONCTYPE>>,	<<ADECL(output,0,nc_type,$1)>>)
define(<<ONCTYPEV>>,	<<ADECL(output,1,nc_type,$1)>>)

define(<<ISIZET>>,	<<ADECL(input,0,size_t,$1)>>)
define(<<ISIZETV>>,	<<ADECL(input,1,size_t,$1)>>)
define(<<OSIZET>>,	<<ADECL(output,0,size_t,$1)>>)
define(<<OSIZETV>>,	<<ADECL(output,1,size_t,$1)>>)

define(<<IPTRDIFFT>>,	<<ADECL(input,0,ptrdiff_t,$1)>>)
define(<<IPTRDIFFTV>>,	<<ADECL(input,1,ptrdiff_t,$1)>>)
define(<<OPTRDIFFT>>,	<<ADECL(output,0,ptrdiff_t,$1)>>)
define(<<OPTRDIFFTV>>,	<<ADECL(output,1,ptrdiff_t,$1)>>)

define(<<ILONG>>,	<<ADECL(input,0,long,$1)>>)
define(<<ILONGV>>,	<<ADECL(input,1,long,$1)>>)
define(<<OLONG>>,	<<ADECL(output,0,long,$1)>>)
define(<<OLONGV>>,	<<ADECL(output,1,long,$1)>>)

define(<<IFLOAT>>,	<<ADECL(input,0,float,$1)>>)
define(<<IFLOATV>>,	<<ADECL(input,1,float,$1)>>)
define(<<OFLOAT>>,	<<ADECL(output,0,float,$1)>>)
define(<<OFLOATV>>,	<<ADECL(output,1,float,$1)>>)

define(<<IDOUBLE>>,	<<ADECL(input,0,double,$1)>>)
define(<<IDOUBLEV>>,	<<ADECL(input,1,double,$1)>>)
define(<<ODOUBLE>>,	<<ADECL(output,0,double,$1)>>)
define(<<ODOUBLEV>>,	<<ADECL(output,1,double,$1)>>)

dnl CCOMP(type)
define(<<CCOMP>>, 
    <<ifelse($1,text,text,
    <<ifelse($1,uchar,uchar,
    <<ifelse($1,schar,schar,
    <<ifelse($1,short,short,
    <<ifelse($1,int,int,
    <<ifelse($1,long,long,
    <<ifelse($1,float,float,
    <<ifelse($1,double,double)>>)>>)>>)>>)>>)>>)>>)>>)

dnl FCOMP(type)
define(<<FCOMP>>, 
    <<ifelse($1,text,text,
    <<ifelse($1,schar,int1,
    <<ifelse($1,short,int2,
    <<ifelse($1,int,int,
    <<ifelse($1,float,real,
    <<ifelse($1,double,double)>>)>>)>>)>>)>>)>>)

dnl COMP(type)
define(<<COMP>>, <<ifelse(API,C,<<CCOMP($1)>>,<<FCOMP($1)>>)>>)

define(<<FDECL_TYPE>>,
    <<ifelse(API,C, 
	int,
	integer function)>>)

dnl DECL(return-type, name, argument-list)
define(<<DECL>>, <<CODE($1 FNAME($2)$3)>>)

dnl FDECL(name, argument-list)
define(<<FDECL>>, <<DECL(FDECL_TYPE, $1, $2)>>)

dnl IODECL(name, type, argument-list)
define(<<IODECL>>, <<FDECL($1_<<>>COMP($2), $3)>>)

dnl FREF(name)
define(<<FREF>>, <<CODE(FNAME($1)(\|))>>)

dnl FOLD(cname, fname)
define(<<FOLD>>, <<CODE(ifelse(API,C, nc$1, nc$2)(\|))>>)

dnl Function Input Arguments:
define(<<IATTNUM>>, <<IINT(attnum)>>)
define(<<ICMODE>>, <<IINT(cmode)>>)
define(<<ICOUNT>>, <<ISIZETV(count)>>)
define(<<IDIMID>>, <<IINT(dimid)>>)
define(<<IDIMIDS>>, <<IINTV(dimids)>>)
define(<<IFILLMODE>>, <<IINT(fillmode)>>)
define(<<IINDEX>>, <<ISIZETV(index)>>)
define(<<ILEN>>, <<ISIZET(<<len>>)>>)
define(<<IMAP>>, <<IPTRDIFFTV(imap)>>)
define(<<IMODE>>, <<IINT(mode)>>)
define(<<INAME>>, <<ITEXTV(name)>>)
define(<<INCID>>, <<IINT(ncid)>>)
define(<<INCIDIN>>, <<IINT(ncid_in)>>)
define(<<INCIDOUT>>, <<IINT(ncid_out)>>)
define(<<INDIMS>>, <<IINT(ndims)>>)
define(<<INEWNAME>>, <<ITEXTV(newname)>>)
define(<<IPATH>>, ITEXTV(path))
define(<<ISTART>>, <<ISIZETV(start)>>)
define(<<ISTATUS>>, <<IINT(status)>>)
define(<<ISTRIDE>>, <<ISIZETV(stride)>>)
define(<<IVARID>>, <<IINT(varid)>>)
define(<<IVARIDIN>>, <<IINT(varid_in)>>)
define(<<IVARIDOUT>>, <<IINT(varid_out)>>)
define(<<IXTYPE>>, <<INCTYPE(xtype)>>)

dnl Function Output Arguments:
define(<<OATTNUM>>, <<OINT(attnum)>>)
define(<<ODIMID>>, <<OINT(dimid)>>)
define(<<ODIMIDS>>, <<OINTV(dimids)>>)
define(<<OLEN>>, <<OSIZET(<<len>>)>>)
define(<<ONAME>>, <<OTEXTV(name)>>)
define(<<ONATTS>>, <<OINT(natts)>>)
define(<<ONCID>>, <<OINT(ncid)>>)
define(<<ONDIMS>>, <<OINT(ndims)>>)
define(<<ONVARS>>, <<OINT(nvars)>>)
define(<<OOLDFILLMODE>>, <<OINT(old_fillemode)>>)
define(<<OVARID>>, <<OINT(varid)>>)
define(<<OUNLIMDIMID>>, <<OINT(unlimdimid)>>)
define(<<OXTYPE>>, <<ONCTYPE(xtype)>>)

dnl Argument References:
define(<<ATTNUM>>, <<ARG(attnum)>>)
define(<<COUNT>>, <<ARG(count)>>)
define(<<DIMID>>, <<ARG(dimid)>>)
define(<<DIMIDS>>, <<ARG(dimids)>>)
define(<<FILLMODE>>, <<ARG(fillmode)>>)
define(<<IN>>, <<ARG(in)>>)
define(<<INDEX>>, <<ARG(index)>>)
define(<<LEN>>, <<ARG(<<len>>)>>)
define(<<IMAP>>, <<ARG(imap)>>)
define(<<NAME>>, <<ARG(name)>>)
define(<<NATTS>>, <<ARG(natts)>>)
define(<<NCID>>, <<ARG(ncid)>>)
define(<<NCIDIN>>, <<ARG(ncid_in)>>)
define(<<NCIDOUT>>, <<ARG(ncid_out)>>)
define(<<NDIMS>>, <<ARG(ndims)>>)
define(<<NEWNAME>>, <<ARG(newname)>>)
define(<<NULL>>, <<CODE(<<<<NULL>>>>)>>)
define(<<NVARS>>, <<ARG(nvars)>>)
define(<<NVATTS>>, <<ARG(nvatts)>>)
define(<<OLDFILLMODE>>, <<ARG(old_fillmode)>>)
define(<<OUT>>, <<ARG(out)>>)
define(<<START>>, <<ARG(start)>>)
define(<<STRIDE>>, <<ARG(stride)>>)
define(<<UNLIMDIMID>>, <<ARG(unlimdimid)>>)
define(<<VARID>>, <<ARG(varid)>>)
define(<<VARIDIN>>, <<ARG(varid_in)>>)
define(<<VARIDOUT>>, <<ARG(varid_out)>>)
define(<<XTYPE>>, <<ARG(xtype)>>)

define(<<UPCASE>>, 
<<translit($1,abcdefghijklmnopqrstuvwxyz,ABCDEFGHIJKLMNOPQRSTUVWXYZ)>>)

dnl Variable "Put" Functions:
define(<<VOUT>>, <<I<<>>UPCASE($1)<<>>ifelse($2,1,,V)(ifelse($2,1,*)out)>>)
define(<<VPUT>>, <<IODECL(put_var$1, $2, (INCID(), IVARID()$3, VOUT($2,$1)))>>)
define(<<PUT_VAR>>, <<VPUT(,$1)>>)
define(<<PUT_VAR1>>,<<VPUT(1,$1,<<, IINDEX()>>)>>)
define(<<PUT_VARA>>,<<VPUT(a,$1,<<, ISTART(), ICOUNT()>>)>>)
define(<<PUT_VARS>>,<<VPUT(s,$1,<<, ISTART(), ICOUNT(), ISTRIDE()>>)>>)
define(<<PUT_VARM>>,<<VPUT(m,$1,<<, ISTART(), ICOUNT(), ISTRIDE(), IMAP()>>)>>)

dnl Variable "Get" Functions:
define(<<VIN>>, <<O<<>>UPCASE($1)<<>>ifelse($2,1,,V)(in)>>)
define(<<VGET>>, <<IODECL(get_var$1, $2, (INCID(), IVARID()$3, VIN($2,$1)))>>)
define(<<GET_VAR>>, <<VGET(,$1)>>)
define(<<GET_VAR1>>,<<VGET(1,$1,<<, IINDEX()>>)>>)
define(<<GET_VARA>>,<<VGET(a,$1,<<, ISTART(), ICOUNT()>>)>>)
define(<<GET_VARS>>,<<VGET(s,$1,<<, ISTART(), ICOUNT(), ISTRIDE()>>)>>)
define(<<GET_VARM>>,<<VGET(m,$1,<<, ISTART(), ICOUNT(), ISTRIDE(), IMAP()>>)>>)

dnl Attribute "Put" Functions:
define(<<AOUT>>, <<I<<>>UPCASE($1)<<>>V(out)>>)
define(<<APUT>>,<<IODECL(put_att,$1,(INCID(), IVARID(), INAME(), IXTYPE(), ILEN(), AOUT($1)))>>)

dnl Attribute "Get" Functions:
define(<<AIN>>, <<O<<>>UPCASE($1)<<>>V(in)>>)
define(<<AGET>>,<<IODECL(get_att,$1,(INCID(), IVARID(), INAME(), AIN($1)))>>)

dnl Function Family Listing:
define(<<FUNC_FAMILY>>,
<<.HP
$1(text)
ifelse(API,C,
<<.HP
$1(uchar)>>)
.HP
$1(schar)
.HP
$1(short)
.HP
$1(int)
ifelse(API,C,
<<.HP
$1(long)>>)
.HP
$1(float)
.HP
$1(double)>>)

divert(0)dnl
.TH NETCDF 3 "18 April 1997" "Printed: \n(yr.\n(mo.\n(dy" "UNIDATA LIBRARY FUNCTIONS"
.SH N<<>>AME
netcdf \- Unidata Network Common Data Form (netCDF) library, version 3 interface
.SH SYNOPSIS
.ft B
.na
.nh
INCLUDE(netcdf)
.sp
ifelse(API,C,,
.SS Most Systems:)
COMPILER() ... -lnetcdf
ifelse(API,C,,
.sp
.SS CRAY PVP Systems:
f90 -dp -i64 ... -lnetcdf
)
.ad
.hy
.SH "LIBRARY VERSION"
.LP
This document describes version 3 of Unidata netCDF data-access interface
for the LANGUAGE() programming language.
.HP
DECL(RETSTR(), inq_libvers, (VOID_ARG))
.sp
Returns a string identifying the version of the netCDF library, and
when it was built, like: "3.1a of Aug 22 1996 12:57:47 $".
.LP
The RCS \fBident(1)\fP command will find a string like
"$\|Id: @\|(#) netcdf library version 3.1a of Sep  6 1996 15:56:26 $"
in the library. The SCCS \fBwhat(1)\fP command will find a string like
"netcdf library version 3.1a of Aug 23 1996 16:07:40 $".
.SH "RETURN VALUES"
.LP
All netCDF functions (except
FREF(inq_libvers) and FREF(strerror)) return an integer status.
This behavior replaces the
ifelse(API,C, <<CODE(ncerr()) function>>, <<CODE(rcode)>> argument)
used in previous versions of the library.
If this returned status value is not equal to
MACRO(NOERR) (zero), it
indicates that an error occurred. The possible status values are defined in 
ifelse(API,C, system <<<<include>>>> file <errno.h> and in )<<>>dnl
ifelse(API,C,")HEADER_FILE(netcdf)<<>>ifelse(API,C,").
.HP
DECL(RETSTR(), strerror, (ISTATUS()))
.sp
Returns a string textual translation of the \fIstatus\fP
value, like "Attribute or variable name contains illegal characters"
or "No such file or directory".
.SH "FUNCTION DESCRIPTIONS"
.HP
FDECL(create, (IPATH(), ICMODE(), 
ONCID()))
.sp
(Corresponds to FOLD(create, cre) in version 2)
.sp
Creates a new netCDF dataset at ARG(path),
returning a netCDF ID in ARG(ncid).
The argument ARG(cmode) may <<include>> the bitwise-or
of the following flags:
MACRO(NOCLOBBER)
to protect existing datasets (default
silently blows them away),
MACRO(SHARE)
for synchronous dataset updates
(default is to buffer accesses), and
MACRO(LOCK)
(not yet implemented).
When a netCDF dataset is created, is is opened
MACRO(WRITE).
The new netCDF dataset is in <<define>> mode.
.HP
FDECL(open, (IPATH(), IMODE(), ONCID()))
.sp
(Corresponds to FOLD(open, opn) in version 2)
.sp
Opens a existing netCDF dataset at ARG(path)
returning a netCDF ID
in ARG(ncid).
The type of access is described by the ARG(mode) parameter,
which may <<include>> the bitwise-or
of the following flags:
MACRO(WRITE)
for read-write access (default
read-only),
MACRO(SHARE)
for synchronous dataset updates (default is
to buffer accesses), and
MACRO(LOCK)
(not yet implemented).
.HP
FDECL(redef, (INCID()))
.sp
(Corresponds to FOLD(redef, redf) in version 2)
.sp
Puts an open netCDF dataset into <<define>> mode, 
so dimensions, variables, and attributes can be added or renamed and 
attributes can be deleted.
.HP
FDECL(endef, (INCID()))
.sp
(Corresponds to FOLD(endef, endf) in version 2)
.sp
Takes an open netCDF dataset out of <<define>> mode.
The changes made to the netCDF dataset
while it was in <<define>> mode are checked and committed to disk if no
problems occurred.  Some data values may be written as well,
see "VARIABLE PREFILLING" below.
After a successful call, variable data can be read or written to the dataset.
.HP
FDECL(sync, (INCID()))
.sp
(Corresponds to FOLD(sync, snc) in version 2)
.sp
Unless the
MACRO(SHARE)
bit is set in
FREF(open) or FREF(create),
accesses to the underlying netCDF dataset are
buffered by the library. This function synchronizes the state of
the underlying dataset and the library.
This is done automatically by
FREF(close) and FREF(endef).
.HP
FDECL(abort, (INCID()))
.sp
(Corresponds to FOLD(abort, abor) in version 2)
.sp
You don't need to call this function.
This function is called automatically by
FREF(close)
if the netCDF was in <<define>> mode and something goes wrong with the commit.
If the netCDF dataset isn't in <<define>> mode, then this function is equivalent to
FREF(close).
If it is called after
FREF(redef),
but before
FREF(enddef),
the new definitions are not committed and the dataset is closed.
If it is called after
FREF(create)
but before
FREF(enddef),
the dataset disappears.
.HP
FDECL(close, (INCID()))
.sp
(Corresponds to
FOLD(close, clos) in version 2)
.sp
Closes an open netCDF dataset.
If the dataset is in <<define>> mode,
FREF(endef)
will be called before closing.
After a dataset is closed, its ID may be reassigned to another dataset.
.HP
FDECL(inq, (INCID(), ONDIMS(), ONVARS(),
ONATTS(), OUNLIMDIMID()))
.HP
FDECL(inq_ndims, (INCID(), ONDIMS()))
.HP
FDECL(inq_nvars, (INCID(), ONVARS()))
.HP
FDECL(inq_natts, (INCID(), ONATTS()))
.HP
FDECL(inq_unlimdim, (INCID(), OUNLIMDIMID()))
.sp
(Replace FOLD(inquire, inq) in version 2)
.sp
Use these functions to find out what is in a netCDF dataset.
Upon successful return,
NDIMS() will contain  the
number of dimensions defined for this netCDF dataset,
NVARS() will contain the number of variables,
NATTS() will contain the number of attributes, and
UNLIMDIMID() will contain the
dimension ID of the unlimited dimension if one exists, or
ifelse(API,C, <<-1>>, <<0>>) otherwise.
ifelse(API,C,
<<If any of the
return parameters is a NULL() pointer, then the corresponding information
will not be returned; hence, no space need be allocated for it.>>)
.HP
FDECL(def_dim, (INCID(), INAME(), ILEN(), ODIMID()))
.sp
(Corresponds to FOLD(dimdef, ddef) in version 2)
.sp
Adds a new dimension to an open netCDF dataset, which must be 
in <<define>> mode.
NAME() is the dimension name.
ifelse(API,C,dnl
<<If DIMID() is not a NULL() pointer then upon successful completion >>)<<>>dnl
DIMID() will contain the dimension ID of the newly created dimension.
.HP
FDECL(inq_dimid, (INCID(), INAME(), ODIMID()))
.sp
(Corresponds to FOLD(dimid, did) in version 2)
.sp
Given a dimension name, returns the ID of a netCDF dimension in DIMID().
.HP
FDECL(inq_dim, (INCID(), IDIMID(), ONAME(), OLEN()))
.HP
FDECL(inq_dimname, (INCID(), IDIMID(), ONAME()))
.HP
FDECL(inq_dimlen, (INCID(), IDIMID(), OLEN()))
.sp
(Replace FOLD(diminq, dinq) in version 2)
.sp
Use these functions to find out about a dimension.
ifelse(API,C,
<<If either the NAME()
argument or LEN() argument is a NULL() pointer, then
the associated information will not be returned.  Otherwise,>>)
NAME() should be  big enough (MACRO(MAX_NAME))
to hold the dimension name as the name will be copied into your storage.
The length return parameter, LEN()
will contain the size of the dimension.
For the unlimited dimension, the returned length is the current
maximum value used for writing into any of the variables which use
the dimension.
.HP
FDECL(rename_dim, (INCID(), IDIMID(), INAME()))
.sp
(Corresponds to FOLD(dimrename, dren) in version 2)
.sp
Renames an existing dimension in an open netCDF dataset.
If the new name is longer than the old name, the netCDF dataset must be in 
<<define>> mode.
You cannot rename a dimension to have the same name as another dimension.
.HP
FDECL(def_var, (INCID(), INAME(), IXTYPE(), INDIMS(), IDIMIDS(), OVARID()))
.sp
(Corresponds to FOLD(vardef, vdef) in version 2)
.sp
Adds a new variable to a netCDF dataset. The netCDF must be in <<define>> mode.
ifelse(API,C, <<If not NULL(), then >>)dnl
VARID() will be set to the netCDF variable ID.
.HP
FDECL(inq_varid, (INCID(), INAME(), OVARID()))
.sp
(Corresponds to FOLD(varid, vid) in version 2)
.sp
Returns the ID of a netCDF variable in VARID() given its name.
.HP
FDECL(inq_var, (INCID(), IVARID(), ONAME(), OXTYPE(), ONDIMS(), ODIMIDS(),
ONATTS()))
.HP
FDECL(inq_varname, (INCID(), IVARID(), ONAME()))
.HP
FDECL(inq_vartype, (INCID(), IVARID(), OXTYPE()))
.HP
FDECL(inq_varndims, (INCID(), IVARID(), ONDIMS()))
.HP
FDECL(inq_vardimid, (INCID(), IVARID(), ODIMIDS()))
.HP
FDECL(inq_varnatts, (INCID(), IVARID(), ONATTS()))
.sp
(Replace FOLD(varinq, vinq) in version 2)
.sp
Returns information about a netCDF variable, given its ID.
ifelse(API,C,
<<If any of the
return parameters (NAME(), XTYPE(), NDIMS(), DIMIDS(), or
NATTS()) is a NULL() pointer, then the corresponding information
will not be returned; hence, no space need be allocated for it.>>)
.HP
FDECL(rename_var, (INCID(), IVARID(), INAME()))
.sp
(Corresponds to FOLD(varrename, vren) in version 2)
.sp
Changes the name of a netCDF variable.
If the new name is longer than the old name, the netCDF must be in <<define>> mode.
You cannot rename a variable to have the name of any existing variable.
FUNC_FAMILY(<<PUT_VAR>>)
.sp
(Replace FOLD(varput, vpt) in version 2)
.sp
Writes an entire netCDF variable (i.e. all the values).
The netCDF dataset must be open and in data mode.  The type of the data is
specified in the function name, and it is converted to the external type
of the specified variable, if possible, otherwise an
MACRO(ERANGE) error is returned.
FUNC_FAMILY(<<GET_VAR>>)
.sp
(Replace FOLD(varget, vgt) in version 2)
.sp
Reads an entire netCDF variable (i.e. all the values).
The netCDF dataset must be open and in data mode.  
The data is converted from the external type of the specified variable,
if necessary, to the type specified in the function name.  If conversion is
not possible, an MACRO(ERANGE) error is returned.
FUNC_FAMILY(<<PUT_VAR1>>)
.sp
(Replace FOLD(varput1, vpt1) in version 2)
.sp
Puts a single data value into a variable at the position INDEX() of an
open netCDF dataset that is in data mode.  The type of the data is
specified in the function name, and it is converted to the external type
of the specified variable, if possible, otherwise an MACRO(ERANGE)
error is returned.
FUNC_FAMILY(<<GET_VAR1>>)
.sp
(Replace FOLD(varget1, vgt1) in version 2)
.sp
Gets a single data value from a variable at the position INDEX()
of an open netCDF dataset that is in data mode.  
The data is converted from the external type of the specified variable,
if necessary, to the type specified in the function name.  If conversion is
not possible, an MACRO(ERANGE) error is returned.
FUNC_FAMILY(<<PUT_VARA>>)
.sp
(Replace FOLD(varput, vpt) in version 2)
.sp
Writes an array section of values into a netCDF variable of an open
netCDF dataset, which must be in data mode.  The array section is specified
by the START() and COUNT() vectors, which give the starting <<index>>
and count of values along each dimension of the specified variable.
The type of the data is
specified in the function name and is converted to the external type
of the specified variable, if possible, otherwise an MACRO(ERANGE)
error is returned.
FUNC_FAMILY(<<GET_VARA>>)
.sp
(Corresponds to FOLD(varget, vgt) in version 2)
.sp
Reads an array section of values from a netCDF variable of an open
netCDF dataset, which must be in data mode.  The array section is specified
by the START() and COUNT() vectors, which give the starting <<index>>
and count of values along each dimension of the specified variable.
The data is converted from the external type of the specified variable,
if necessary, to the type specified in the function name.  If conversion is
not possible, an MACRO(ERANGE) error is returned.
FUNC_FAMILY(<<PUT_VARS>>)
.sp
(Corresponds to FOLD(varputg, vptg) in version 2)
.sp
These functions are used for \fIstrided output\fP, which is like the
array section output described above, except that
the sampling stride (the interval between accessed values) is
specified for each dimension.
For an explanation of the sampling stride
vector, see COMMON ARGUMENTS DESCRIPTIONS below.
FUNC_FAMILY(<<GET_VARS>>)
.sp
(Corresponds to FOLD(vargetg, vgtg) in version 2)
.sp
These functions are used for \fIstrided input\fP, which is like the
array section input described above, except that 
the sampling stride (the interval between accessed values) is
specified for each dimension.
For an explanation of the sampling stride
vector, see COMMON ARGUMENTS DESCRIPTIONS below.
FUNC_FAMILY(<<PUT_VARM>>)
.sp
(Corresponds to FOLD(varputg, vptg) in version 2)
.sp
These functions are used for \fImapped output\fP, which is like
strided output described above, except that an additional <<index>> mapping
vector is provided to specify the in-memory arrangement of the data
values.
For an explanation of the <<index>>
mapping vector, see COMMON ARGUMENTS DESCRIPTIONS below.
FUNC_FAMILY(<<GET_VARM>>)
.sp
(Corresponds to FOLD(vargetg, vgtg) in version 2)
.sp
These functions are used for \fImapped input\fP, which is like
strided input described above, except that an additional <<index>> mapping
vector is provided to specify the in-memory arrangement of the data
values.
For an explanation of the <<index>>
mapping vector, see COMMON ARGUMENTS DESCRIPTIONS below.
FUNC_FAMILY(<<APUT>>)
.sp
(Replace FOLD(attput, apt) in version 2)
.sp
Unlike variables, attributes do not have 
separate functions for defining and writing values.
This family of functions defines a new attribute with a value or changes
the value of an existing attribute.
If the attribute is new, or if the space required to
store the attribute value is greater than before,
the netCDF dataset must be in <<define>> mode.
The parameter LEN() is the number of values from OUT() to transfer.
It is often one, except that for
FREF(put_att_text) it will usually be
ifelse(API,C, <<CODE(strlen(OUT())).>>, <<CODE(len_trim(OUT())).>>)
.sp
For these functions, the type component of the function name refers to
the in-memory type of the value, whereas the XTYPE() argument refers to the
external type for storing the value.  An MACRO(ERANGE)
error results if
a conversion between these types is not possible.  In this case the value
is represented with the appropriate fill-value for the associated 
external type.
.HP
FDECL(inq_attname, (INCID(), IVARID(), IATTNUM(), ONAME()))
.sp
(Corresponds to FOLD(attname, anam) in version 2)
.sp
Gets the
name of an attribute, given its variable ID and attribute number.
This function is useful in generic applications that
need to get the names of all the attributes associated with a variable,
since attributes are accessed by name rather than number in all other
attribute functions.  The number of an attribute is more volatile than
the name, since it can change when other attributes of the same variable
are deleted.  The attributes for each variable are numbered
from ifelse(API,C,0,1) (the first attribute) to
NVATTS()<<>>ifelse(API,C,-1),
where NVATTS() is
the number of attributes for the variable, as returned from a call to
FREF(inq_varnatts).
ifelse(API,C,
<<If the NAME() parameter is a NULL() pointer, no name will be
returned and no space need be allocated.>>)
.HP
FDECL(inq_att, (INCID(), IVARID(), INAME(), OXTYPE(), OLEN()))
.HP
FDECL(inq_attid, (INCID(), IVARID(), INAME(), OATTNUM()))
.HP
FDECL(inq_atttype, (INCID(), IVARID(), INAME(), OXTYPE()))
.HP
FDECL(inq_attlen, (INCID(), IVARID(), INAME(), OLEN()))
.sp
(Corresponds to FOLD(attinq, ainq) in version 2)
.sp
These functions return information about a netCDF attribute,
given its variable ID and name.  The information returned is the
external type in XTYPE()
and the number of elements in the attribute as LEN().
ifelse(API,C,
<<If any of the return arguments is a NULL() pointer,
the specified information will not be returned.>>)
.HP
FDECL(copy_att, (INCID(), IVARIDIN(), INAME(), INCIDOUT(), IVARIDOUT()))
.sp
(Corresponds to FOLD(attcopy, acpy) in version 2)
.sp
Copies an
attribute from one netCDF dataset to another.  It can also be used to
copy an attribute from one variable to another within the same netCDF.
NCIDIN() is the netCDF ID of an input netCDF dataset from which the
attribute will be copied.
VARIDIN()
is the ID of the variable in the input netCDF dataset from which the
attribute will be copied, or MACRO(GLOBAL)
for a global attribute.
NAME()
is the name of the attribute in the input netCDF dataset to be copied.
NCIDOUT()
is the netCDF ID of the output netCDF dataset to which the attribute will be 
copied.
It is permissible for the input and output netCDF ID's to be the same.  The
output netCDF dataset should be in <<define>> mode if the attribute to be
copied does not already exist for the target variable, or if it would
cause an existing target attribute to grow.
VARIDOUT()
is the ID of the variable in the output netCDF dataset to which the attribute will
be copied, or MACRO(GLOBAL) to copy to a global attribute.
.HP
FDECL(rename_att, (INCID(), IVARID(), INAME(), INEWNAME()))
.sp
(Corresponds to FOLD(attrename, aren)
.sp
Changes the
name of an attribute.  If the new name is longer than the original name,
the netCDF must be in <<define>> mode.  You cannot rename an attribute to
have the same name as another attribute of the same variable.
NAME() is the original attribute name.
NEWNAME()
is the new name to be assigned to the specified attribute.  If the new name
is longer than the old name, the netCDF dataset must be in <<define>> mode.
.HP
FDECL(del_att, (INCID(), IVARID(), INAME()))
.sp
(Corresponds to FOLD(attdel, adel) in version 2)
.sp
Deletes an attribute from a netCDF dataset.  The dataset must be in
<<define>> mode.
FUNC_FAMILY(<<AGET>>)
.sp
(Replace FOLD(attget, agt) in version 2)
.sp
Gets the value(s) of a netCDF attribute, given its
variable ID and name.  Converts from the external type to the type
specified in
the function name, if possible, otherwise returns an MACRO(ERANGE)
error.
All elements of the vector of attribute
values are returned, so you must allocate enough space to hold
them.  If you don't know how much space to reserve, call
FREF(inq_attlen)
first to find out the length of the attribute.
.SH "COMMON ARGUMENT DESCRIPTIONS"
.LP
In this section we <<define>> some common arguments which are used in the 
"FUNCTION DESCRIPTIONS" section.
.TP
INCID()
is the netCDF ID returned from a previous, successful call to
FREF(open) or FREF(create)
.TP
ONAME()
is the name of a dimension, variable, or attribute.
It shall begin with an alphabetic character, followed by
zero or more alphanumeric characters including the underscore
(`_') or hyphen (`-').  Case is significant.
ifelse(API,C,<<As an input argument, 
it shall be a pointer to a 0-terminated string; as an output argument, it 
shall be the address of a buffer in which to hold such a string.>>)
The maximum allowable number of characters 
ifelse(API,C,(excluding the terminating 0)) is MACRO(MAX_NAME).
Names that begin with an underscore (`_') are reserved for use
by the netCDF interface.
.TP
IXTYPE()
specifies the external data type of a netCDF variable or attribute and
is one of the following:
MACRO(BYTE), MACRO(CHAR), MACRO(SHORT), MACRO(INT), 
MACRO(FLOAT), or MACRO(DOUBLE).
These are used to specify 8-bit integers,
characters, 16-bit integers, 32-bit integers, 32-bit IEEE floating point
numbers, and 64-bit IEEE floating-point numbers, respectively.
ifelse(API,C,
<<(MACRO(INT) corresponds to MACRO(LONG) in version 2, to specify a
32-bit integer).>>)
.TP
ODIMIDS()
is a vector of dimension ID's and defines the shape of a netCDF variable.
The size of the vector shall be greater than or equal to the
rank (i.e. the number of dimensions) of the variable (NDIMS()).
The vector shall be ordered by the speed with which a dimension varies:
DIMIDS()<<>>ifelse(API,C,<<[NDIMS()-1]>>,<<(1)>>)
shall be the dimension ID of the most rapidly
varying dimension and
DIMIDS()<<>>ifelse(API,C,<<[0]>>,<<(NDIMS())>>)
shall be the dimension ID of the most slowly
varying dimension.
The maximum possible number of
dimensions for a variable is given by the symbolic constant
MACRO(MAX_VAR_DIMS).
.TP
IDIMID()
is the ID of a netCDF dimension.
netCDF dimension ID's are allocated sequentially from the 
ifelse(API,C,non-negative, positive)
integers beginning with ifelse(API,C,0,1).
.TP
INDIMS()
is either the total number of dimensions in a netCDF dataset or the rank
(i.e. the number of dimensions) of a netCDF variable.
The value shall not be negative or greater than the symbolic constant 
MACRO(MAX_VAR_DIMS).
.TP
IVARID()
is the ID of a netCDF variable or (for the attribute-access functions) 
the symbolic constant
MACRO(GLOBAL),
which is used to reference global attributes.
netCDF variable ID's are allocated sequentially from the 
ifelse(API,C,non-negative,positive)
integers beginning with ifelse(API,C,0,1).
.TP
ONATTS()
is the number of global attributes in a netCDF dataset  for the
FREF(inquire)
function or the number
of attributes associated with a netCDF variable for the
FREF(varinq)
function.
.TP
IINDEX()
specifies the indicial coordinates of the netCDF data value to be accessed.
The indices start at ifelse(API,C,0,1);
thus, for example, the first data value of a
two-dimensional variable is ifelse(API,C,(0,0),(1,1)).
The size of the vector shall be at least the rank of the associated
netCDF variable and its elements shall correspond, in order, to the
variable's dimensions.
.TP
ISTART()
specifies the starting point
for accessing a netCDF variable's data values
in terms of the indicial coordinates of 
the corner of the array section.
The indices start at ifelse(API,C,0,1);
thus, the first data
value of a variable is ifelse(API,C,(0, 0, ..., 0),(1, 1, ..., 1)).
The size of the vector shall be at least the rank of the associated
netCDF variable and its elements shall correspond, in order, to the
variable's dimensions.
.TP
ICOUNT()
specifies the number of indices selected along each dimension of the
array section.
Thus, to access a single value, for example, specify COUNT() as
(1, 1, ..., 1).
Note that, for strided I/O, this argument must be adjusted
to be compatible with the STRIDE() and START() arguments so that 
the interaction of the
three does not attempt to access an invalid data co-ordinate.
The elements of the
COUNT() vector correspond, in order, to the variable's dimensions.
.TP
ISTRIDE()
specifies the sampling interval along each dimension of the netCDF
variable.   The elements of the stride vector correspond, in order,
to the netCDF variable's dimensions (ARG(stride)<<>>ifelse(API,C,[0],<<(1)>>))
gives the sampling interval along the most ifelse(API,C,slowly,rapidly) 
varying dimension of the netCDF variable).  Sampling intervals are
specified in type-independent units of elements (a value of 1 selects
consecutive elements of the netCDF variable along the corresponding
dimension, a value of 2 selects every other element, etc.).
ifelse(API,C,<<A NULL() stride argument is treated as (1, 1, ... , 1).>>)
.TP
IMAP()
specifies the mapping between the dimensions of a netCDF variable and
the in-memory structure of the internal data array.  The elements of
the <<index>> mapping vector correspond, in order, to the netCDF variable's
dimensions (ARG(imap)<<>>ifelse(API,C,[0],<<(1)>>) gives the distance
between elements of the internal array corresponding to the most
ifelse(API,C,slowly,rapidly) varying dimension of the netCDF variable).
Distances between elements are specified in type-independent units of
elements (the distance between internal elements that occupy adjacent
memory locations is 1 and not the element's byte-length as in netCDF 2).
ifelse(API,C,<<A NULL() pointer means the memory-resident values have
the same structure as the associated netCDF variable.>>)
.SH "VARIABLE PREFILLING"
.LP
By default, the netCDF interface sets the values of
all newly-defined variables of finite length (i.e. those that do not have
an unlimited, dimension) to the type-dependent fill-value associated with each 
variable.  This is done when FREF(endef)
is called.  The
fill-value for a variable may be changed from the default value by
defining the attribute `CODE(_FillValue)' for the variable.  This
attribute must have the same type as the variable and be of length one.
.LP
Variables with an unlimited dimension are also prefilled, but on
an `as needed' basis.  For example, if the first write of such a
variable is to position 5, then
positions
ifelse(API,C,0 through 4, 1 through 4)
(and no others)
would be set to the fill-value at the same time.
.LP
This default prefilling of data values may be disabled by
or'ing the
MACRO(NOFILL)
flag into the mode parameter of FREF(open) or FREF(create),
or, by calling the function FREF(set_fill)
with the argument MACRO(NOFILL).
For variables that do not use the unlimited dimension,
this call must
be made before
FREF(endef).
For variables that
use the unlimited dimension, this call
may be made at any time.
.LP
One can obtain increased performance of the netCDF interface by using 
this feature, but only at the expense of requiring the application to set
every single data value.  The performance
enhancing behavior of this function is dependent on the particulars of
the implementation and dataset <<format>>.
The flag value controlled by FREF(set_fill)
is per netCDF ID,
not per variable or per write. 
Allowing this to change affects the degree to which
a program can be effectively parallelized.
Given all of this, we state that the use
of this feature may not be available (or even needed) in future
releases. Programmers are cautioned against heavy reliance upon this
feature.
.HP
FDECL(setfill, (INCID(), IFILLMODE(), OOLDFILLMODE()))
ifelse(API,C,
<<.sp
(Corresponds to FOLD(setfill) in version 2)>>)
.sp
Determines whether or not variable prefilling will be done (see 
above).
The netCDF dataset shall be writable.
FILLMODE() is either MACRO(FILL)
to enable prefilling (the
default) or MACRO(NOFILL)
to disable prefilling.
This function returns the previous setting in OLDFILLMODE().
.SH "ENVIRONMENT VARIABLES"
.TP 4
.B NETCDF_FFIOSPEC
Specifies the Flexible File I/O buffers for netCDF I/O when executing
under the UNICOS operating system (the variable is ignored on other
operating systems).
An appropriate specification can greatly increase the efficiency of 
netCDF I/O -- to the extent that it can actually surpass FORTRAN binary 
I/O.
The default specification is \fBbufa:336:2\fP.
See UNICOS Flexible File I/O for more information.
.SH "MAILING-LISTS"
.LP
Both a mailing list and a digest are available for
discussion of the netCDF interface and announcements about netCDF bugs,
fixes, and enhancements.
To begin or change your subscription to either the mailing-list or the
digest, send one of the following in the body (not
the subject line) of an email message to "majordomo@unidata.ucar.edu".
Use your email address in place of \fIjdoe@host.inst.domain\fP.
.sp
To subscribe to the netCDF mailing list:
.RS
\fBsubscribe netcdfgroup \fIjdoe@host.inst.domain\fR
.RE
To unsubscribe from the netCDF mailing list:
.RS
\fBunsubscribe netcdfgroup \fIjdoe@host.inst.domain\fR
.RE
To subscribe to the netCDF digest:
.RS
\fBsubscribe netcdfdigest \fIjdoe@host.inst.domain\fR
.RE
To unsubscribe from the netCDF digest:
.RS
\fBunsubscribe netcdfdigest \fIjdoe@host.inst.domain\fR
.RE
To retrieve the general introductory information for the mailing list:
.RS
\fBinfo netcdfgroup\fR
.RE
To get a synopsis of other majordomo commands:
.RS
\fBhelp\fR
.RE
.SH "SEE ALSO"
.LP
.BR ncdump (1),
.BR ncgen (1),
.BR netcdf (3<<>>ifelse(API,C,,f)).
.LP
\fInetCDF User's Guide\fP, published
by the Unidata Program Center, University Corporation for Atmospheric
Research, located in Boulder, Colorado.
