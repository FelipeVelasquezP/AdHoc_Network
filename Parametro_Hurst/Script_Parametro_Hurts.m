clear all
clc
close all
C= xlsread('traza.csv');
fila=C(:,3);
vec=0;

h=0;
for i=1:length(fila),
    for j=1:length(fila),
        if fila(i,1)==fila(j,1)
           h=h+1;
        end
    end
    fila(i,2)=h;
    h=0;
end

for i=1:length(fila),
    fila(i,3)=fila(i,2)/length(fila(:,2));
end
%var1=sort(fila(:,3));
s=C(:,5);
N= length(C(:,1));
for i = 1:30;
    m = floor(N/(2*i));
    for j=1:i;
        r = s(1+(j-1)*m:j*m);
        M = mean(r);
        x = (r-M);
        V = cumsum(x);
        R(j) = max(V)-min(V);
        S(j) = std(r);
    end
    tau(i) = m;
    RS(i) = mean(R./S);
end

figure(1)
gTau = log10(tau);
gRS = log10(RS);
H=gTau'\gRS';
rectaH = H*gTau;
scatter(gTau,gRS)
xlabel('log(\tau)','FontSize',12)
ylabel('log(R/S)','FontSize',12)
title('Calculo del parametro R/S')
hold on
q = polyfit(gTau,gRS,1);
t = 1.1:.01:2.8;
y = q(1)*t+(q(2));
plot(t,y,'LineWidth',2)
text(2,0.6,['y =' num2str(q(1)),' x ' num2str(q(2))],'FontSize',12)






ini = 20;
for j=ini:50;
   del = floor(N/j); % el valor del incremento a utilizar
   s1 = s(1:del:(N-del));
   s2 = s(del:del:N-1);
   k = j-ini+1;
   L(k) = sum(sqrt(del^2+(s2-s1).^2))^0.5;
   delta(k) = del;
end
delta(k) = del;

figure(2)
del = (delta - mean(delta))./std(delta);
qd = polyfit(del,L,1);
pd = polyval(qd,del);
plot(delta,pd,'-r',delta,L,'+k')
xlabel('log(\delta)','FontSize',12)
ylabel('log(L)','FontSize',12)
yd = qd(1)*t+qd(2);
text(35,6000,['y =' num2str(qd(1)),' x +' num2str(qd(2))],'FontSize',12)
H1 = 2-qd(1); fraction=(qd(1)-q(1))/q(1);


figure(3)
plot(C(:,3))
grid on
title('Tráfico de 15 min')
xlabel('Duración')
ylabel('Tamaños de paquetes en bytes')


figure(4)
plot(C(:,5))
grid on
title('Tráfico de 15 min')
xlabel('Duración')
ylabel('Ancho de Banda bps')

figure(5)
plot(C(:,1))
title('Tráfico 15 min')
xlabel('Duración')
ylabel('Tiempo de arribo en segundos')

% % figure(6)
% % plot(var1)
% % title('Distribución de tráfico')
% % xlabel('Duración')
% % ylabel('Probabilidad de ocurrencia')