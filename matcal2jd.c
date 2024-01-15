#include"mex.h"
#include"sofam.h"

double returnout(double out)
{
	return out;
}

 void mexFunction(int nlhs, mxArray*plhs[], int nrhs, const mxArray*prhs[])
 {
 	double iy, im, id;
	double djm0, djm,status;
 	double *outdjm0, *outdjm, *outstatus;
 	iy=*(mxGetPr(prhs[0]));
 	im=*(mxGetPr(prhs[1]));
 	id=*(mxGetPr(prhs[2]));
 	
 	status=iauCal2jd(iy, im, id, &djm0, &djm);
 	plhs[0]=mxCreateDoubleMatrix(1,1,mxREAL);
 	plhs[1]=mxCreateDoubleMatrix(1,1,mxREAL);
 	plhs[2]=mxCreateDoubleMatrix(1,1,mxREAL);
 	outdjm0=mxGetPr(plhs[0]);
 	outdjm=mxGetPr(plhs[1]);
 	outstatus=mxGetPr(plhs[2]);
 	*outdjm0=returnout(djm0);
 	*outdjm=returnout(djm);
 	*outstatus=returnout(status);
 	
 }
