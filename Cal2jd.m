function [jdT0,jdT]=Cal2jd(y,m,d,h,mi,s)
%格里历到儒略历的转换
%输入：年y，月m，日d，时h，分mi，秒s
%输出：MJD零点jdT0，MJD时刻jdT，单位天；状态status，值为0时正常

[jdT0,jdT,status]=matcal2jd(y,m,d);
if status~=0%缺：时分秒的检查
    error('输入时间错误，请检查');
end
jdT=jdT+h/24+mi/1440+s/86400;

end
