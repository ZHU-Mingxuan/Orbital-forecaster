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
	int iy,im,id;
	double dy,dm,dd,fd;
	double *outdy,*outdm,*outdd,*outfd;
 	date1=*(mxGetPr(prhs[0]));
 	date2=*(mxGetPr(prhs[1]));
 	
 	iauJd2cal(date1, date2, &iy, &im, &id, &fd);
 	dy=(double)iy;
 	dm=(double)im;
 	dd=(double)id;
 	plhs[0]=mxCreateDoubleMatrix(1,1,mxREAL);
 	plhs[1]=mxCreateDoubleMatrix(1,1,mxREAL);
 	plhs[2]=mxCreateDoubleMatrix(1,1,mxREAL);
 	plhs[3]=mxCreateDoubleMatrix(1,1,mxREAL);
 	outdy=mxGetPr(plhs[0]);
 	outdm=mxGetPr(plhs[1]);
 	outdd=mxGetPr(plhs[2]);
 	outfd=mxGetPr(plhs[3]);
 	*outdy=returnout(dy);
 	*outdm=returnout(dm);
 	*outdd=returnout(dd);
 	*outfd=returnout(fd);
 }
