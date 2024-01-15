#include"mex.h"
#include"sofa.h"

double returnout(double out)
{
	return out;
}

 void mexFunction(int nlhs, mxArray*plhs[], int nrhs, const mxArray*prhs[])
 {
 	double uta;
	double utb;
	double theta;
	double *outtheta;
 	uta=*(mxGetPr(prhs[0]));
 	utb=*(mxGetPr(prhs[1]));
 	
 	theta=iauGst94(uta, utb);
 	plhs[0]=mxCreateDoubleMatrix(1,1,mxREAL);
 	outtheta=mxGetPr(plhs[0]);
 	*outtheta=returnout(theta);
 }
