clc;
clear;
%����ϵͳ 4����4�������Kalman-Filter��ʶϵͳ״̬ת�ƾ�����������
%ͨ��ϵͳ�״α�ʶ�õ��������2�׵����뵥���ϵͳ
N=300;
% sim('kalman_data');
% m1 = m1.data;m2 = m2.data;m3 = m3.data;m4 = m4.data;
% x1 = x1.data;x2 = x2.data;y1 = y1.data;y2 = y2.data;
X = zeros(8,N);%״̬�۲�
% X(8,1) = [];%��ʼֵȷ��--�ѵ�
Xkf=zeros(8,N);%״̬��ʶ���
Z=zeros(4,N); %����۲�
P=zeros();%����Э����������ʵ�ʹ۲������ı䣩
Q=0.01;%������������
R=0.25;%������������
W=sqrt(Q)*randn(8,N);%��������
V=sqrt(R)*randn(1,N);%��������
F=eye(8,8);%8x8״̬ת�ƾ���
G=1;%��������״̬ת�ƾ���
% H=eye(8,8);%4x8״̬�������