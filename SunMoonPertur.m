function aT=SunMoonPertur(rj2000,rs,rm)
%计算日月引力摄动

mus=1.32712e20;
mum=4903e9;

aTs=-mus*((rj2000-rs)/(norm(rj2000-rs))^3+rs/(norm(rs))^3);
aTm=-mum*((rj2000-rm)/(norm(rj2000-rm))^3+rm/(norm(rm))^3);
aT=aTs+aTm;

end