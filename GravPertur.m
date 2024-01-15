function aG=GravPertur(date1,date2,rj2000,C,S)
%求航天器受地球非球型摄动加速度aG
%输入两位儒略历UTC时间date1、date2;J2000系下位置行向量rj2000，单位为米
%输出为3阶行向量，单位m/s^2
%非球型摄动加速度计算到4阶4次，采用JGM3模型
%Re=6378136.3m，mu=3.986004415*10^14m^3/s^2；
%清华大学航天航空学院，朱明轩
%创建日期：2020/11/13，修改记录：2021/1/15针对HPOP程序需求进行修改

Re=6378136.3;
mu=3.986004415*10^14;

rj2000=rj2000';
recf=J2000toECF(date1,date2,rj2000);
x=recf(1);
y=recf(2);
z=recf(3);


%直角坐标转换到球坐标
[lambda,phi,r]=cart2sph(x,y,z);

%求非球形摄动加速度
R=Re/r;
msin=zeros(5);
mcos=zeros(5);
for k=1:5
    msin(k)=sin((k-1)*lambda);
    mcos(k)=cos((k-1)*lambda);
end
    
P=Legendre(sin(phi));
aG=zeros(3,1);
for i=3:5
    for j=1:i
        aG=aG+R^(i-1)*[i*cos(phi)*P(i,j)*(C(i,j)*mcos(j)+S(i,j)*msin(j)); ...,
            ((i-1)*sin(phi)*P(i,j)-sqrt((2*i-1)/(2*i-3)*(i+j-2)*(i-j))*P(i-1,j))*(C(i,j)*mcos(j)+S(i,j)*msin(j)); ...,
            (j-1)*P(i,j)*(C(i,j)*msin(j)-S(i,j)*mcos(j))];
    end
end
aG=-mu/r^2/cos(phi)*aG;

%球坐标转换到直角坐标
er=[x/r;y/r;z/r];
elamb=[-y/sqrt(x^2+y^2);x/sqrt(x^2+y^2);0];
ephi=cross(er,elamb);
aG=[er,ephi,elamb]*aG;

%地固系到J2000系
aG=ECF2J2000(date1,date2,aG);
aG=aG';

end

function P=Legendre(u)

P=zeros(5,5);
P(1,1)=1;
P(2,1)=sqrt(3)*u;
P(2,2)=sqrt(3*(1-u^2));

for i=3:5
    P(i,i)=sqrt((2*i-1)/(2*i-2)*(1-u^2))*P(i-1,i-1);
    for j=1:5
        if j<i
            P(i,j)=sqrt((2*i-1)*(2*i-3)/(i+j-2)/(i-j))*u*P(i-1,j)-sqrt((2*i-1)*(i+j-3)*(i-j-1)/((2*i-5)*(i+j-2)*(i-j)))*P(i-2,j);
        end
    end
end
end
