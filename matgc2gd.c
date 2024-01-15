#include"mex.h"
#include"sofam.h"

double returnout(double out)
{
	return out;
}

 void mexFunction(int nlhs, mxArray*plhs[], int nrhs, const mxArray*prhs[])
 {
 	double n, xyz[3];
	double elong, phi, height;
 	double *outelong, *outphi, *outheight;
 	xyz[0]=*(mxGetPr(prhs[0]));
 	xyz[1]=*(mxGetPr(prhs[1]));
 	xyz[2]=*(mxGetPr(prhs[2]));
 	n=1;
 	
 	iauGc2gd ( n, xyz, &elong, &phi, &height );
 	plhs[0]=mxCreateDoubleMatrix(1,1,mxREAL);
 	plhs[1]=mxCreateDoubleMatrix(1,1,mxREAL);
 	plhs[2]=mxCreateDoubleMatrix(1,1,mxREAL);
 	outelong=mxGetPr(plhs[0]);
 	outphi=mxGetPr(plhs[1]);
 	outheight=mxGetPr(plhs[2]);
 	*outelong=returnout(elong);
 	*outphi=returnout(phi);
 	*outheight=returnout(height);
 	
 }
