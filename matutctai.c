#include"mex.h"
#include"sofam.h"

double returnout(double out)
{
	return out;
}

 void mexFunction(int nlhs, mxArray*plhs[], int nrhs, const mxArray*prhs[])
 {
 	double utc1,utc2;
	double tai1,tai2;
 	double *outtai1,*outtai2;
 	utc1=*(mxGetPr(prhs[0]));
 	utc2=*(mxGetPr(prhs[1]));
 	
 	iauUtctai(utc1, utc2, &tai1, &tai2);
 	plhs[0]=mxCreateDoubleMatrix(1,1,mxREAL);
 	plhs[1]=mxCreateDoubleMatrix(1,1,mxREAL);
 	outtai1=mxGetPr(plhs[0]);
 	outtai2=mxGetPr(plhs[1]);
 	*outtai1=returnout(tai1);
 	*outtai2=returnout(tai2);
 	
 }
