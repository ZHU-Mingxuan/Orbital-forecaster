function [r,v]=HPOP(r0,v0,y0,m0,d0,h0,mi0,sec0,y1,m1,d1,h1,mi1,sec1,sm)
%主程序，给定初始时刻位置速度，积分计算t时刻位置速度
%输入：初始位置速度矢量r0、v0,行向量形式；初始时刻t0，从前往后包括年，月，日，时，分，秒，用逗号隔开；待求时刻t1，格式同t0；航天器面质比s/m
%输出：t时刻位置速度矢量r、v
%清华大学航天航空学院，朱明轩
%2020/1/13

[jdT01,jdT11]=matcal2jd(y0,m0,d0);
[jdT02,jdT12]=matcal2jd(y1,m1,d1);
jdT11=jdT11*86400+h0*3600+mi0*60+sec0;
jdT12=jdT12*86400+h1*3600+mi1*60+sec1;

jdT0=jdT01+jdT11/86400;
jdT12=jdT12-jdT11;


%载入球谐系数
%C(x,y)=Cn+1,m+1,即n=x-1，m=y-1
load('JGM3.txt');
C=zeros(5,5);
S=zeros(5,5);
k=1;
for i=3:5
    for j=1:i
        C(i,j)=JGM3(k,3);
        S(i,j)=JGM3(k,4);
        k=k+1;
    end
end

%载入日月位置
[tai11,tai12]=matutctai(jdT0,0);
[tai21,tai22]=matutctai(jdT0,jdT12/86400);
rs= planetEphemeris([tai11+tai12:1/8640:tai21+tai22]','earth','sun');
rm=planetEphemeris([tai11+tai12:1/8640:tai21+tai22]','earth','moon');
rs=1000*rs;
rm=1000*rm;

s0=[r0,v0];
opt=odeset('RelTol', 1e-8, 'AbsTol', [1e-8, 1e-8, 1e-8, 1e-8, 1e-8, 1e-8]);
[~,x]=ode45(@(t,s)HPOPFun(t,s,sm,jdT0,C,S,rs,rm,jdT12),[0,jdT12],s0,opt);
s=x(end,:);
r=s(1:3);
v=s(4:6);
end
function ds=HPOPFun(t,s,sm,date1,C,S,rs,rm,jdT12)
mu=3.986004415*10^14;
rst=zeros(1,3);
rsm=zeros(1,3);
rst=interp1((0:10:jdT12),rs,t,'linear');
rmt=interp1((0:10:jdT12),rm,t,'linear');
ds=zeros(6,1);
date2=t/86400;
rj2000=[s(1),s(2),s(3)];
vj2000=[s(4),s(5),s(6)];
rmod=norm(rj2000);
ar=-mu/rmod^3*rj2000;
aG=GravPertur(date1,date2,rj2000,C,S);
aL=LightPressurePertur(rj2000,sm,rst);
aT=SunMoonPertur(rj2000,rst,rmt);
aA=AtmosPertur(date1,date2,rj2000,vj2000,sm);
a=ar+aG+aL+aT+aA;
ds(1:3)=s(4:6);
ds(4:6)=a;
end