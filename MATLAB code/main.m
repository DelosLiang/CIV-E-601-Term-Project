clc
clear all
%% Parameters configuration
ID=[];% project ID
for i=1:20
    ID=[ID i];
end
ID_mapped=[];% scheduled project 
% ID_mapped=[9 10 13 6 7 15 16 18 20 3 17 11 19 4 8 12 2];
% ID_mapped=[9 10 13 6 7 15 16 18 20 3 17 11 19 4 8];
t=1;% date currently being scheduled
p=[4 5 2 3 4 2 2 3 2 2 3 4 2 3 2 3 2 2 3 2];% duration
p_bar=mean(p);% average duration
w=[1000	1050 750 1000 900 800 800 950 900 900 950 1100 900 900 900 1000	850	950	1000 950];% the penalty costs incurred for each time unit of delay
CP=[10000 15000	9000 10000 12000 10000 10000 11000 10000 10000 11000 12500 10000 10000 8500	9500 8500 9000 10000 9000];% Contract Price
LD=[12500 18750	11250 12500	15000 12500	12500 13750	12500 12500	13750 15625	12500 12500	10625 11875	10625 11250	12500 11250];% Liquidated Damage
F=LD-CP;% difference between CP and LD
due_date=[10 11	8 9	10 8 8 10 8	8 10 11	8 10 10	11 10 8	10 9];
deadline=[14 15	11 11 12 11	11 14 11 11	13 15 12 12	12 15 13 11	15 11];
l=due_date-p;% the latest starting date for a project before delay costs are incurred
m=deadline-p;% the latest starting date for a project before liquidated damage are incurred
k=12;% empirically determined planning parameter
P=zeros(1,20);% Priority
%% Calculation of P_ij
for i=1:20
    P(i)=w(i)/p(i)*exp(-(l(i)-t)/(k*p_bar))+F(i)/p(i)*exp(-(m(i)-t)/(k*p_bar));
end
%% Priority-based sorting
[sortedMatrix, originalColumnIndices] = sort(P, 2, 'descend');
isNotIn = ~ismember(originalColumnIndices, ID_mapped);
result=originalColumnIndices(isNotIn)
% result=sortedMatrix(isNotIn)
%% Numerical results
sum_CP=sum(CP);% Total Contract Price
Earn=sum(CP)-(10-8)*w(7)-(12-10)*w(15)-(15-11)*w(16)-(12-11)*w(11)-(14-10)*w(19)-(15-11)*w(2)-LD(14)-LD(5)-LD(1);% Total Contract Price substract delay costs and liquidated damage

