clc
clear all


% depth_B = [0.40 0.80 1 1.40 1.80 2.50 3.00 4.00 6.00 7.00 8.00 9.00];
% PAR_B = [ 1 0.376923077  0.415384615 0.284615385 0.346153846 0.207692308 0.215384615 0.153846154 0.107692308 0.073076923 0.101538462 0.073076923];
% [x,y] = createFit(PAR_B,depth_B);
% 
% % plot(x,y,'b','LineWidth',2)
% 
depth_B2 = [1 10];
PAR_B2 = [166.75 141.52];
% [x2,y2] = createFit1(PAR_B2,depth_B2);

x=[6.5 2.45 2.7 1.85 2.25 1.35 1.4 1 0.7 .475 .66 .475];
y=[0.40 0.80 1 1.40 1.80 2.50 3.00 4.00 6.00 7.00 8.00 9.00];
% g = fittype('( log (x) -log(6.5))/a');
% f0 = fit(x,y,g,'StartPoint',(1));
% xx = linspace(1,8,50);
% plot(x,y,'o',xx,f0(xx),'r-');
[fitobject,gof,output] = fit(x(:),y(:),'6.5*exp(-a*x)')
% model = @(b,time) b(1)*(exp(-time./b(2)).*sin(2.*pi.*b(3).*time + b(4)));
% b0 = [0.014 0.1 fres1 phase1];
% mdl = fitnlm(time, data4, model, b0);
% plot(time, data)
% Hold on
% plot(mdl)
figure
plot(fitobject, x, y, 'p')
grid
ax = gca;
ax.YDir = 'reverse' ;
% expfn = @(p,xd) (1/p(log(6.5)-log(xd)));  %define exponential function
% errfn = @(p) sum((expfn(p,x)-y).^2);  %define sum-squared error
% pfit = fminsearch( errfn, 0);     %run the minimizer
% plot(x,y,'bo');  hold on;   %plot your raw data
% plot(x, expfn(pfit, x), 'r-');  %plot the fit data
[x,y] = createFit4(x,y);
[x2,y2] = createFit(PAR_B2,depth_B2);