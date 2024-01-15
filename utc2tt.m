function [tt1,tt2]=utc2tt(utc1,utc2)

[tai1,tai2]=matutctai(utc1,utc2);
tt1=tai1;
tt2=tai2+32.184/86400;

end