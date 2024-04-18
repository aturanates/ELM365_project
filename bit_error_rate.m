%Ahmet Turan Ates
%1901022033
clc;
close all;
clear all;
% The amount of bits to be generated for each SNR value N = 100,000,000
N=10^8; 
% rand("state", N); It sets the random number generator according to the N 
value.
randn("state",100); 
%definition of the calculated variables in the theoretical solution
ip = rand(1,N)>0.6;
ai=(2)*ip-(1);
% N0 dependent writing of the theoretically calculated variance value.
noise=1*[randn(1,N)+1i*randn(1,N)];
Eb_No_dB = [-9:18] ;
for i=1:length(Eb_No_dB) 
 
 %Writing the operation z = ai + n0
 N0 = 1/(10.^(Eb_No_dB(i)/10)); 
 gama = (-0.202*N0) ;
 z=ai+10^(-Eb_No_dB(i)/20)*noise; 
 %Desicion
 ipErr=real(z)>(gama);
 
 %Error calculation
 nErr(i)=size(find ([ip-ipErr]),2) 
end

%Normalising sim results
simErr=nErr/N;
TheoErr=0.6*erfc((1/2)*sqrt(10.^(Eb_No_dB/10))); 
% Plotting results
figure
semilogy(Eb_No_dB,TheoErr, "bo-");
hold on
semilogy(Eb_No_dB,simErr, "rx-");
axis([-9 18 10^-5 0.6]);
grid on
legend("Theoric","Simulation");
xlabel("Eb/ No (dB)");
ylabel(" Bit Error Rate ");
title("P(0)=2/5, P(1)=3/5 Graph");