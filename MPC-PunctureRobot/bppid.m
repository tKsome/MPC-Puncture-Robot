clear all; 
clc 
close all 
xite=0.28; %?????? 
alfa=0.05; %??????? 
IN=4;H=5;Out=3;%???????????????????? 
wi=0.5*rands(H,IN);%????????????????????5??4?? 
wi_1=wi;wi_2=wi;wi_3=wi; 
wo=0.5*rands(Out,H);%????????????????????3??5?? 
wo_1=wo;wo_2=wo;wo_3=wo; 
x=[0 0 0]; 
du_1=0; 
x1=0; 
u_1=0;u_2=0;u_3=0;u_4=0;u_5=0;u_6=0; 
y_1=0;y_2=0;y_3=0;y_4=0;y_5=0;y_6=0; 
Oh=zeros(H,1);%?????????????5??1?? 
I=Oh;%??????????????5??1?? 
error_2=0; 
error_1=0; 
ts=0.001;%???????? 
for k=1:1:3000%???? 
time(k)=k*ts; 
rin(k)=1700;  
a(k)=1.2*(1-0.8*exp(-0.1*k)); %Unlinear model 
yout(k)=a(k)*y_1/(1+y_1^2)+u_1; 
error(k)=rin(k)-yout(k);%????????????????????? 
x(1)=error(k)-error_1; 
x(2)=error(k); 
x(3)=error(k)-2*error_1+error_2; 
xi=[rin(k),yout(k),error(k),1];%BP??????????????1??4?? 
[xi,minxi,maxxi]=premnmx(xi);  %???????????????????? 
epid=[x(1);x(2);x(3)]; 
wi; 
I=xi*wi';%??????????????1??5??; 
for j=1:1:H 
Oh(j)=(exp(I(j))-exp(-I(j)))/(exp(I(j))+exp(-I(j))); %?????????????5??1??  
end 
%Output layer 
K=wo*Oh; %???????????????3??1??  
for l=1:1:Out 
Q(l)=exp(K(l))/(exp(K(l))+exp(-K(l))); %Getting Kp,Ki,Kd ????????????????3??1??  
end 
Kp(k)=Q(1);Ki(k)=Q(2);Kd(k)=Q(3); 
Kpid=[Kp(k) Ki(k) Kd(k)]; 
du(k)=Kpid*epid; %??u(k)???     ????????? 
u(k)=u_1+du(k);%u(k)??? 
if u(k)>=10 % Restricting the output of controller 
u(k)=10; 
end 
if u(k)<=-10 
u(k)=-10; 
end 
dyu(k)=sign((yout(k)-y_1)/(du(k)-du_1+0.0001));%sign()??? 
for j=1:1:Out 
dK(j)=Q(j)*(1-Q(j)); 
 
end 
for l=1:1:Out 
delta3(l)=error(k)*dyu(k)*epid(l)*dK(l);%???????????(3)?????1??3?? 
end 
for l=1:1:Out 
for i=1:1:H 
d_wo=xite*delta3(l)*Oh(i)+alfa*(wo_1-wo_2);%??wo,????????????????��??????3??5?? 
end 
end 
wo=wo_1+d_wo;%wo,?????????????????????????3??5?? 
 
%Hidden layer 
for i=1:1:H 
dO(i)=(1-Oh(i)^2)/2; 
 
end 
segma=delta3*wo;%????(3)*wo???????1??5?? 
for i=1:1:H 
delta2(i)=dO(i)*segma(i);%??(2)???????1??5?? 
end 
d_wi=xite*delta2'*xi+alfa*(wi_1-wi_2);%??wi,????????????????��??????5??4?? 
wi=wi_1+d_wi;%wi,?????????????????????????5??4?? 
 
%Parameters Update 
du_1=du(k); 
u_6=u_5; u_5=u_4; u_4=u_3; u_3=u_2; u_2=u_1; u_1=u(k); 
y_6=y_5; y_5=y_4; y_4=y_3; y_3=y_2; y_2=y_1; y_1=yout(k); 
wo_3=wo_2;wo_2=wo_1;wo_1=wo; 
wi_3=wi_2;wi_2=wi_1;wi_1=wi; 
error_2=error_1; 
error_1=error(k); 
end 
 
figure(1); 
plot(time,rin,'r',time,yout,'b'); 
xlabel('time(s)'); ylabel('rin,yout'); 
figure(2); 
plot(time,error,'r'); 
xlabel('time(s)'); ylabel('error'); 
figure(3); 
plot(time,u,'r'); 
xlabel('time(s)'); ylabel('u'); 
figure(4); 
subplot(311); 
plot(time,Kp,'r'); 
xlabel('time(s)'); ylabel('Kp'); 
subplot(312); 
plot(time,Ki,'g'); 
xlabel('time(s)'); ylabel('Ki'); 
subplot(313); 
plot(time,Kd,'b'); 
xlabel('time(s)'); ylabel('Kd'); 