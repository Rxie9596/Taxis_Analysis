p1 =   1.015e-14;
p2 =  -1.752e-11;
p3 =  -1.988e-09;
p4 =   9.397e-07;
p5 =   5.144e-05;
p6 =     0.03515;
f1=@(x) p1.*x.^5 + p2.*x.^4 + p3.*x.^3 + p4.*x.^2 + p5.*x + p6;

a =      0.5015;
b =    -0.02509;
f2=@(x) a*exp(b*x);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TraNum=10000;
TraLength=30;

N=TraLength*TraNum;
Angle_Sample=zeros(1,TraNum*TraLength);
FTime_Sample=zeros(1,TraNum*TraLength);

n=0;
while n<N
    t_Angle=rand(1)*360-180;

    f_Angle=f1(t_Angle);

    r=rand(1);
    if r<=f_Angle
        n=n+1;
        Angle_Sample(n)=t_Angle;
    end
end

n=0;
while n<N
    t_FTime=rand(1)*300;

    f_FTime=f2(t_FTime);

    r=rand(1);
    if r<=f_FTime
        n=n+1;
        FTime_Sample(n)=t_FTime;
    end
end

save('simulation_data.mat','Angle_Sample','FTime_Sample');