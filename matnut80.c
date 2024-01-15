#include"mex.h"
#include"sofam.h"

double returnout(double out)
{
	return out;
}

 void mexFunction(int nlhs, mxArray*plhs[], int nrhs, const mxArray*prhs[])
 {
 	double date1;
	double date2;
	double dpsi;
	double deps;
 	double *outdpsi;
	double *outdeps;
 	date1=*(mxGetPr(prhs[0]));
 	date2=*(mxGetPr(prhs[1]));
 	
 	iauNut80(date1, date2, &dpsi, &deps);
 	plhs[0]=mxCreateDoubleMatrix(1,1,mxREAL);
 	plhs[1]=mxCreateDoubleMatrix(1,1,mxREAL);
 	outdpsi=mxGetPr(plhs[0]);
 	outdeps=mxGetPr(plhs[1]);
 	*outdpsi=returnout(dpsi);
 	*outdeps=returnout(deps);
 	
 }
