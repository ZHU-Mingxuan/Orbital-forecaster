function recf=J2000toECF(uta,utb,rj2000)
%����ԪJ2000ƽ�������ϵ������ת�����ع�����ϵ��
%���룺uta��utb������ʱ�̵�utcʱ���Ӧ�������գ��������uta=ut1��rj2000��J2000ƽ�������ϵ�е�λ��ʸ��
%�����recf���ع�����ϵ��λ��ʸ��
%�廪��ѧ���캽��ѧԺ��������
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