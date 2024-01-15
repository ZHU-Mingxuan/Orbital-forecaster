function aA=AtmosPertur(date1,date2,rj2000,vj2000,sm)
%aA:j2000系下大气阻力加速度。
Cd=2.1;

[y,m,d,fd]=matjd2cal(date1,date2);
t=datetime(y,m,d);
dayOfyear=day(t,'dayofyear');
s=86400*fd;

recf=J2000toECF(date1,date2,rj2000');

[longitude,latitude,altitude]=matgc2gd(recf(1),recf(2),recf(3));

if altitude<1000000
[~,rho] = atmosnrlmsise00(altitude, latitude, longitude, y, dayOfyear, s, 180, 180, 15.0);

ve=vj2000-cross([0,0,7.292115e-5],rj2000);
vemod=norm(ve);
aA=-0.5*Cd*sm*rho(6)*vemod*ve;
else
    aA=0;
end

end
