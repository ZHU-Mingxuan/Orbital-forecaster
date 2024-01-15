function aL=LightPressurePertur(rj2000,sm,rs)
%̫����ѹ���㶯
%aL:j2000����ϵ���㶯���ٶ�

c=2.99792458*10^8;
Ls=3.823e26;
Cr=1;

if abs(cross(rj2000,rs))<6378136.3 & dot(rj2000,rs)<0
    K=0;
else
    K=1;
end

rmod=norm(rj2000-rs);
aL=K*Cr*sm*Ls/(4*pi*c)*(rj2000-rs)/rmod^3;

end