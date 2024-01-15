#include"mex.h"
#include"sofam.h"

double returnout(double out)
{
	return out;
}

 void mexFunction(int nlhs, mxArray*plhs[], int nrhs, const mxArray*prhs[])
 {
 	double ep01, ep02, ep11, ep12;
	double zeta, z, theta;
 	double *outzeta, *outz, *outtheta;
 	ep01=*(mxGetPr(prhs[0]));
 	ep02=*(mxGetPr(prhs[1]));
 	ep11=*(mxGetPr(prhs[2]));
 	ep12=*(mxGetPr(prhs[3]));
 	
 	iauPrec76(ep01, ep02, ep11, ep12, &zeta, &z, &theta);
 	plhs[0]=mxCreateDoubleMatrix(1,1,mxREAL);
 	plhs[1]=mxCreateDoubleMatrix(1,1,mxREAL);
 	plhs[2]=mxCreateDoubleMatrix(1,1,mxREAL);
 	outzeta=mxGetPr(plhs[0]);
 	outz=mxGetPr(plhs[1]);
 	outtheta=mxGetPr(plhs[2]);
 	*outzeta=returnout(zeta);
 	*outz=returnout(z);
 	*outtheta=returnout(theta);
 	
 }
