//genesis
/* ending.g : description file for binary branching passive cable.
** All units are in SI (Meter Kilogram Second Amp)
*/

/********************************************************************
**                                                                 **
**                       Model parameters                          **
**                                                                 **
********************************************************************/

/* Setting up the parameters for the model */
float	end_len		= 4.0e-6	// 4.0 microns
float	end_dia		= 0.25e-6	// 0.25 microns
float	len
float	dia
float	len_factor	= pow(2,{1.0/3.0})	// for electrotonic length
float	power_law	= 1.5		// Rall's power law
int	tree_depth	= 10
float	RM=4.0				// ohms m^2
float	RA=1.0				// ohms m
float	CM=0.01				// Farads/m^2
float	EM=-0.07			// -70 mV
float	inj=1.0e-10			// 0.1 nA injection

float	dt=50e-6			// 0.05 msec
float	runtime=0.25			// 0.25 sec
float	PI=3.1415926535

int		X_flag = 0
int		i

/********************************************************************
**                                                                 **
**                       Model construction                        **
**                                                                 **
********************************************************************/
/* We create an initial compartment */
dia=end_dia
len=end_len
create compartment /compt
set /compt \
		Ra	{RA*len*4.0/(dia*dia*PI)} \
		Rm	{RM/(PI*dia*len)} \
		Cm	{CM*PI*dia*len} \
		Em	{EM}	\
		dia	{dia}

/* For the rest of the tree we make a new, larger parent compartment and
** attach the old compartment plus a duplicate to the parent. */
for(i=1;i<tree_depth;i=i+1)
	move /compt /old_compt
	dia=pow({2.0*pow({dia},{power_law})},{1.0/power_law})
	len=len*len_factor
	
	create compartment /compt
	set /compt \
		Ra	{RA*len*4.0/(dia*dia*PI)} \
		Rm	{RM/(PI*dia*len)} \
		Cm	{CM*PI*dia*len} \
		Em	{EM}	\
		dia	{dia}
	copy /old_compt /compt/branch1
		sendmsg /compt /compt/branch1 AXIAL Vm
		sendmsg /compt/branch1 /compt RAXIAL Ra Vm
		position /compt/branch1 R{len} R{len*i/10} I
	move /old_compt /compt/branch2
		sendmsg /compt /compt/branch2 AXIAL Vm
		sendmsg /compt/branch2 /compt RAXIAL Ra Vm
		position /compt/branch2 R{len} R{-len*i/10} I
end

/********************************************************************
**                                                                 **
**                    graphical and file I/0                       **
**                                                                 **
********************************************************************/

if (X_flag)
	xstartup
	create xform /form [0,0,1000,500]
	create xgraph /form/graph [0%,0%,50%,100%]
	set /form/graph xmax {runtime} ymax 0.1 ymin -0.1  
	sendmsg /compt /form/graph PLOT Vm *root *red
	sendmsg /compt/branch1/branch1/branch1/branch1/branch1/branch1/branch1/branch1/branch1 \
		/form/graph PLOT Vm *terminal *green
	create xdraw /form/draw [50%,0%,50%,100%] -wx 0.0002 -wy 0.0002 -cx 7e-5
	create xcell /form/draw/cell -path /##[TYPE=compartment]
	disable /form/draw
	xshow /form
end

create asc_file /output/out0
create asc_file /output/out1
set /output/out0 filename end.out0 leave_open 1 flush 0  
set /output/out1 filename end.out1 leave_open 1 flush 0  
sendmsg /compt /output/out0 SAVE Vm
sendmsg /compt/branch1/branch1/branch1/branch1/branch1/branch1/branch1/branch1/branch1 /output/out1 SAVE Vm

/********************************************************************
**                                                                 **
**                       Simulation control                        **
**                                                                 **
********************************************************************/

/* Set up the clocks that we are going to use */
setclock 0 {dt}

/* Set the stimulus conditions */
// set /compt inject {inj}
set /compt/branch1/branch1/branch1/branch1/branch1/branch1/branch1/branch1/branch1 inject {inj}

/* Setting up the hines solver element */
create hsolve /solve
set /solve path /##[TYPE=compartment] comptmode 1 chanmode 3
setmethod 11	 /* using the crank-nicolson method */
call /solve SETUP
/* run the simulation */

reset
step -t {runtime}
set /output/out# flush 1 leave_open 0
call /output/out# PROCESS	// flush files
