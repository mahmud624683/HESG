
close all
clear all
clc

%camel case is used in variable naming
radius=7; %turbine radius is asumed 7m

turbineEfficiency = 0.8; %efficiency of our turbine 80%

%In this project wind velocity will vary between 4 to 9 m/s
maxWS=15;
minWS=5;

%In this project it is assumed that the environment temperature is 293k 
%in 293k air density=1.2041 kg/m^3 source: https://en.wikipedia.org/wiki/Density_of_air 
airDensity=1.2041;


wMin=4;
wMax=18;


maxWS=maxWS-0.5;
minWS=minWS-0.5;
vvp=((maxWS-minWS)/0.5)+1;    %velocity Variation Point for power graph calculation
w=wMin:0.1:wMax;               %omega Variation Point for power graph calculation
w_len=length(w);
lamda=zeros(vvp,w_len);
cp=lamda;                   
power=lamda;                %declared power which will be used in later
%calculate lambda for all combination of velocity and omega variation point
%coefficient of cp(lamda) equation
c0=0.3906;
c1=0.052;
c2=0.118;
c3=0.16;
c4=0.062;
c5=1.026e-2;
c6=5.65e-4;
powerConst=0.5*pi*(radius^2)*turbineEfficiency*airDensity;
i=1;

while(i<=w_len)
    j=1;
    v=minWS;
    while(v<=maxWS)
        
       %function calculation start for lamda, cp and power
       lamda(j,i)= radius*w(i)/v;
       cp(j,i)=(c1-c2*lamda(j,i)+c3*lamda(j,i)^2-c4*lamda(j,i)^3+c5*lamda(j,i)^4-c6*lamda(j,i)^5)*c0;
       if(cp(j,i)<0)
           cp(j,i)=0;
       end
       power(j,i)=powerConst*(v^3)*cp(j,i);
       %calculation end
       j=j+1;
       v=v+0.5;
    end
    i=i+1;
end



%plot turbine power and maximum power on change of rotor speed for
%different value of wind velocity

figure(1);
plot(w(:,1:w_len),power(:,1:w_len));
hold on;
title('Pout vs omega');
xlabel('omega,w (rad/s)');
ylabel('Pout (w)');


powerTops=zeros(1,vvp);
xPos=powerTops;
symbol='v=';
unit=' m/sec';

for i=1:vvp
[powerTops(i),maxIndex]=max(power(i,:));
xPos(i)=w(maxIndex);
text(xPos(i)+0.5,powerTops(i),strcat(symbol,num2str(i*0.5+minWS),unit));
end
plot(xPos,powerTops,'-.b');
hold off;
