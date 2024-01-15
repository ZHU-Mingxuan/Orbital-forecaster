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
	double eps;
	double *outeps;
 	date1=*(mxGetPr(prhs[0]));
 	date2=*(mxGetPr(prhs[1]));
 	
 	eps=iauObl80(date1, date2);
 	plhs[0]=mxCreateDoubleMatrix(1,1,mxREAL);
 	outeps=mxGetPr(plhs[0]);
 	*outeps=returnout(eps);
 }
