function [jdT0,jdT]=Cal2jd(y,m,d,h,mi,s)
%����������������ת��
%���룺��y����m����d��ʱh����mi����s
%�����MJD���jdT0��MJDʱ��jdT����λ�죻״̬status��ֵΪ0ʱ����

[jdT0,jdT,status]=matcal2jd(y,m,d);
if status~=0%ȱ��ʱ����ļ��
    error('����ʱ���������');
end
jdT=jdT+h/24+mi/1440+s/86400;

end
