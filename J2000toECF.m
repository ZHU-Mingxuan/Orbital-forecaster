function recf=J2000toECF(uta,utb,rj2000)
%将历元J2000平赤道坐标系中坐标转化到地固坐标系中
%输入：uta、utb：计算时刻的utc时间对应的儒略日，这里近似uta=ut1；rj2000：J2000平赤道坐标系中的位置矢量
%输出：recf：地固坐标系中位置矢量
%清华大学航天航空学院，朱明轩
%2020/1/14

thetaGST=matgst94(uta,utb);
Ret=Rz(-thetaGST);

[date1,date2]=utc2tt(uta,utb);
date01=2451545.0;
date02=0;

epsilon=matobl80(date1,date2);
[dpsi,deps]=matnut80(date1,date2);
Rtm=Rx(epsilon+deps)*Rz(dpsi)*Rx(-epsilon);

[zeta,z,theta]=matprec76(date01,date02,date1,date2);
Rmj=Rz(z)*Ry(-theta)*Rz(zeta);

R=Rmj*Rtm*Ret;
recf=R*rj2000;

end

function Rx=Rx(a)
Rx=[1,0,0;0,cos(a),-sin(a);0,sin(a),cos(a)];
end

function Ry=Ry(a)
Ry=[cos(a),0,sin(a);0,1,0;-sin(a),0,cos(a)];
end

function Rz=Rz(a)
Rz=[cos(a),-sin(a),0;sin(a),cos(a),0;0,0,1];
end