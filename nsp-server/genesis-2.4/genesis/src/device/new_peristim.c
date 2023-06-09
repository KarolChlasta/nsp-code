static char* rcsid = "$Id: new_peristim.c,v 1.2 2005/06/27 19:00:36 svitak Exp $";

/*
** $Log: new_peristim.c,v $
** Revision 1.2  2005/06/27 19:00:36  svitak
** Added explicit types to untyped functions and fixed return values as
** appropriate. Initialized values explicitly when it was unclear if
** they were being used uninitialized (may not apply to all files being
** checked in in this batch).
**
** Revision 1.1.1.1  2005/06/14 04:38:28  svitak
** Import from snapshot of CalTech CVS tree of June 8, 2005
**
** Revision 1.1  1998/03/31 22:10:24  dhb
** Initial revision
**
*/

#include "spike_ext.h"

/* Computes a peristimulus spike distribution.  The timing of the stimulus
**  does not need to be specified, in this case the object loops through
**  the bin table.  If triggered, it should trigger at the start of the
**  distribution, not at the time of the stimulus itself! */
/* E. De Schutter, Caltech 8/91 */
/* added SPIKE msg, EDS 10/91 */

void NewPeriStimulusDistribution(count,action)
register struct new_peristim_type *count;
Action		*action;
{
	MsgIn	*msg;
	float   voltage,inspike,time;
	int     max_steps,trigger;
	int     i,t;

	voltage = count->threshold - 1;
	inspike = count->threshold - 1;

    if(debug > 1){
		ActionHeader("PeriStimulusDistribution",count,action);
    }

    SELECT_ACTION(action){
		case PROCESS:
			max_steps = count->binwidth / Clockrate(count);
			/* get the messages */
			MSGLOOP(count,msg) {
				case 0:				/* INVM */
					voltage = MSGVALUE(msg,0);
					break;
				case 1:				/* TRIGGER */
					trigger = (MSGVALUE(msg,0) == 0);
					if (trigger) {
						count->bin_index = 0;			/* start binning */
						count->bin_steps = 0;
					}
					break;
        case 2:       /* READTIME */
          time = MSGVALUE(msg,0);
          i = time / count->binwidth;
          if (i<count->num_bins) {
            count->table[i] += 1;
          }
          break;
				case 3:				/* INSPIKE */
					inspike = MSGVALUE(msg,0);
					break;
			}
			/* update bin_index if necessary, turn binning on/off */
			if (count->bin_steps >= max_steps) {
				count->bin_index += 1;
				if (count->bin_index >= count->num_bins) {
					if (count->trigger_mode) {	/* wait for next trigger */
						count->bin_index = -1;
					} else {			/* restart binning */
						count->bin_index = 0;
					}
				}
				count->bin_steps = 0;
			}
			/* check for spike if binning is active */
			if (count->bin_index >= 0) {
				if (count->spiking) {	/* check whether this spike is done */
					if (voltage < count->threshold) {
						count->spiking = 0;	/* spike is done */
					}
				} else {		/* check whether spike started */
					if (voltage >= count->threshold) {
						count->spiking = 1;	/* spike started */
						count->table[count->bin_index] += 1;
					}
					if (inspike > count->threshold) {
						count->table[count->bin_index] += 1;
					}
				}
				count->output = count->table[count->bin_index];
			} else {
				count->output = 0;
			}
			count->bin_steps += 1;
			break;
		case RESET:
			if (!count->allocated && (count->num_bins > 0)) {
				/* allocate memory for the bin arrays */
				count->table = (int *)calloc(count->num_bins,sizeof(int));
				for (i=0; i<count->num_bins; i++) {
					count->table[i] = 0.0;
				}
				count->allocated = 1;
			} else if (count->reset_mode == NEW_TABLE) {
				free(count->table);
				count->table = (int *)calloc(count->num_bins,sizeof(int));
			} else if (count->reset_mode == CLEAR_BINS) {
				/* clear the bin arrays */
				for (i=0; i<count->num_bins; i+=1) {
					count->table[i] = 0;
				}
			}
			if (count->trigger_mode == FREE_RUN) {
				count->bin_index = 0;	/* binning is active */
			} else {
				count->bin_index = -1;	/* no binning till triggered */
			}
			count->output = 0;
			count->bin_steps = 0;
			count->spiking = 0;
			break;
		case CHECK:
			i = 0;
			t = 0;
			MSGLOOP(count,msg) {
				case 0:     /* INVM */
				case 3:     /* INSPIKE */
					i = 1;
					break;
				case 1:     /* TRIGGER */
					t = 1;
					break;
			}
			if (i != 1) {
				ErrorMessage("peristim","Wrong number of INPUT msg.",count);
			}
			if ((count->trigger_mode) && (t == 0)) {
				ErrorMessage("peristim","No TRIGGER msg.",count);
			}
			if (count->num_bins < 5) {
				ErrorMessage("peristim","Bad num_bins value.",count);
			}
			if (count->binwidth <=0) {
				ErrorMessage("peristim","Bad binwidth value.",count);
			}
			break;
    }
}
