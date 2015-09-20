G = 6.67*10^(-11)
x=[-15:0.25:15]
z=4
R=3
rho = 1200

gz_arr = []
sx = size(x)

for i = 1:sx(2)
    gz = 0.02974*(R^(3.))*rho*(z/(((x(i)^2)+(z^2))^(3/2)))
    gz_arr = [gz_arr gz]
end

gz_arr = gz_arr'
gz_safe = gz_arr

figure

plot(x,gz_arr,'r--','LineWidth',3)
hold on
plot(x,gz_arr,'kx')
axis([-15 15 0 80])
xlabel('Horizontal distance x (km)')
ylabel('Gravity Anomaly (mgal)')
grid
title('Vertical Gravity Anomaly - Lothringer')
% 
% c_itr_arr=[]
% for i = 1:100;
%     cj = []
%     for j = 1:100;
%         z = (3.5*i/100)+2.5;
%         rho = 1600.*j/100+400;
%         gz_arr_itr = [];
%         for k = 1:sx(2)
%             gz_itr = 0.02974*(R^(3.))*rho*(z/(((x(i)^2)+(z^2))^(3/2)));
%             gz_arr_itr = [gz_arr_itr gz_itr];
%         end
%         c_itr = sum((gz_arr_itr - gz_arr(k)).^(2)) / 121.;
%         
%         cj = [cj c_itr];
%     end
%     c_itr_arr = [c_itr_arr; cj];
% end


% Matlab script to find the minimum of a function.
% Note: this must be run iteratively, with narrower limits for xmin, xmax,
% to get location of minimum to desired degree of accuracy.

%clear;  % make sure there are no variables already defined.
close all;  % close all figures to make sure you get the plot you make.

zmin = 2.5;  % limits for min, max, which must contain best x; can be
zmax = 5.5;  % narrowed until best x is found to some desired number of 
zdiv = 100;  % places. xdiv could be increased, but doesn't need to be as
             % you narrow the range between xmin and xmax.  Note that
             % current xmin, xmax limits find pi to 3.15, or 1 place past
             % the decimal point.
             
rhomin = 400
rhomax = 2000
rhodiv = 100

z = [zmin:((zmax-zmin)/zdiv):zmax]; % divide x range into xdiv divisions.
rho = [rhomin:((rhomax-rhomin)/rhodiv):rhomax];

%y = 1. + (x-pi).*(x-pi); % y is quadratic in x, with ymin = 1 & xbest = pi
%gz_itr_arr = []
%gz_c = []

for i =1:zdiv+1
    for j=1:rhodiv+1
        for k=1:121
            gz_itr(k) = ((0.02974*(R^(3.))*rho(j)*(z(i)/(((x(k)^2)+(z(i)^2))^(3/2)))));
        end
        gz_c(i,j) = sum(((gz_itr'-gz_safe).^2))/121;
    end
end

gz_min = 1000000.;    % initial guess for minimum must be large.
for i = 1:zdiv+1   % sweep across all values of function ...
    for j = 1:rhodiv+1
        if (gz_c(i,j) < gz_min)  % if current value is less than estimate of minimum
            gz_min = gz_c(i,j) ; % revise estimate of minimum
            zbest = z(i) ; % revise location of minimum
            rhobest = rho(j);
            ibest = i ; % revise location in xarray of minimum
            jbest = j;
        end
    end
end

% If y is a function of two variables, then you need 2 'for' loops over
% two ranges (one for each variable).

% ymin   % estimate of minimum of function; note true min is 1.
% xbest  % estimate of x location of minimum; note true location is pi.
% ibest  % location within x array where xbest (and hence ybest) occur.

% The commands below plot the function to help you visualize it.  You
% don't need to keep them in the modified code for HW#2 Problem 2b.
% figure ;
% plot(x,y)
% set(gca,'xlim',[xmin xmax], 'ylim',[0 12]);
% xlabel('x');
% ylabel('y');
% title('Plot of: y = 1 + (x-pi)^2');
% grid

figure
axis([2.5 5.5 400 2000]);
[blah,blah2]=contour(z,rho,gz_c',[1 4 9 24 48 96 144 256]);
clabel(blah,blah2,'labelspacing',900);
hold on
plot(4.0,1200,'X')
title('HW2p2b-Josh Lothringer')
xlabel('Z (depth) (km)')
ylabel('Density Anomaly (kg/m3)')
legend('Cost Function','Best Fit: z = 4.0 km & density = 1200 kg/m2')

%Calculate C for four models
for k = 1:121
    c1_itr(k) = (((0.02974*(3^(3.))*1710.0*(5.0/(((x(k)^2)+(5.0^2))^(3/2))))));
    c2_itr(k) = ((0.02974*(3^(3.))*831.0*(3.2/(((x(k)^2)+(3.2^2))^(3/2)))));
    c3_itr(k) = ((0.02974*(3^(3.))*1089.0*(4.1/(((x(k)^2)+(4.1^2))^(3/2)))));
    c4_itr(k) = ((0.02974*(3^(3.))*1300.0*(3.9/(((x(k)^2)+(3.9^2))^(3/2)))));
end

c1 = sum((c1_itr'-gz_safe).^(2))/121
c2 = sum((c2_itr'-gz_safe).^(2))/121
c3 = sum((c3_itr'-gz_safe).^(2))/121
c4 = sum((c4_itr'-gz_safe).^(2))/121

hold on 
plot(5.0,1710.0,'x')
plot(3.2,831.0,'x')
plot(4.1,1089.0,'x')
plot(3.9,1300.0,'x')
title('HW2p3-Josh Lothringer')
legend('Cost Function','Best Fit: z = 4.0 km & density = 1200 kg/m2','Model1','Model2','Model3','Model4','Location','northwest')

figure

plot(x,gz_arr,'k-','LineWidth',3)
hold on
%plot(x,gz_arr,'kx')
plot(x,c1_itr,'g--','LineWidth',3)
plot(x,c2_itr,'b:','LineWidth',3)
plot(x,c3_itr,'r-.','LineWidth',3)
plot(x,c4_itr,'y--','LineWidth',3)
axis([-15 15 0 80])
xlabel('Horizontal distance x (km)')
ylabel('Gravity Anomaly (mgal)')
grid
title('Vertical Gravity Anomaly - HW2p4 Lothringer')
legend('Data','Model1','Model2','Model3','Model4')

rng(24) ;
rn = 3.0*randn(121,1);

gz_noise = gz_safe + rn ; 

figure
plot(x,gz_noise,'k-','LineWidth',3)
hold on
%plot(x,gz_arr,'kx')
plot(x,c1_itr,'g--','LineWidth',3)
plot(x,c2_itr,'b:','LineWidth',3)
plot(x,c3_itr,'r-.','LineWidth',3)
plot(x,c4_itr,'y--','LineWidth',3)
axis([-15 15 0 80])
xlabel('Horizontal distance x (km)')
ylabel('Gravity Anomaly (mgal)')
grid
title('Vertical Gravity Anomaly - HW2p5b Lothringer')
legend('Noisey Data','Model1','Model2','Model3','Model4')

%Problem 6

% Matlab script to find the minimum of a function.
% Note: this must be run iteratively, with narrower limits for xmin, xmax,
% to get location of minimum to desired degree of accuracy.

%clear;  % make sure there are no variables already defined.
close all;  % close all figures to make sure you get the plot you make.

zmin = 2.5;  % limits for min, max, which must contain best x; can be
zmax = 5.5;  % narrowed until best x is found to some desired number of 
zdiv = 100;  % places. xdiv could be increased, but doesn't need to be as
             % you narrow the range between xmin and xmax.  Note that
             % current xmin, xmax limits find pi to 3.15, or 1 place past
             % the decimal point.
             
rhomin = 400
rhomax = 2000
rhodiv = 100

z = [zmin:((zmax-zmin)/zdiv):zmax]; % divide x range into xdiv divisions.
rho = [rhomin:((rhomax-rhomin)/rhodiv):rhomax];

%y = 1. + (x-pi).*(x-pi); % y is quadratic in x, with ymin = 1 & xbest = pi
%gz_itr_arr = []
%gz_c = []

for i =1:zdiv+1
    for j=1:rhodiv+1
        for k=1:121
            gz_itr(k) = ((0.02974*(R^(3.))*rho(j)*(z(i)/(((x(k)^2)+(z(i)^2))^(3/2)))));
        end
        gz_c(i,j) = sum(((gz_itr'-gz_noise).^2))/121;
    end
end

gz_min = 1000000.;    % initial guess for minimum must be large.
for i = 1:zdiv+1   % sweep across all values of function ...
    for j = 1:rhodiv+1
        if (gz_c(i,j) < gz_min)  % if current value is less than estimate of minimum
            gz_min = gz_c(i,j) ; % revise estimate of minimum
            zbest = z(i) ; % revise location of minimum
            rhobest = rho(j);
            ibest = i ; % revise location in xarray of minimum
            jbest = j;
        end
    end
end

% If y is a function of two variables, then you need 2 'for' loops over
% two ranges (one for each variable).

% ymin   % estimate of minimum of function; note true min is 1.
% xbest  % estimate of x location of minimum; note true location is pi.
% ibest  % location within x array where xbest (and hence ybest) occur.

% The commands below plot the function to help you visualize it.  You
% don't need to keep them in the modified code for HW#2 Problem 2b.
% figure ;
% plot(x,y)
% set(gca,'xlim',[xmin xmax], 'ylim',[0 12]);
% xlabel('x');
% ylabel('y');
% title('Plot of: y = 1 + (x-pi)^2');
% grid

figure
axis([2.5 5.5 400 2000]);
[blah,blah2]=contour(z,rho,gz_c',[1 4 9 24 48 96 144 256]);
clabel(blah,blah2,'labelspacing',900);
hold on
plot(4.0,1200,'X')
title('HW2p6-Josh Lothringer')
xlabel('Z (depth) (km)')
ylabel('Density Anomaly (kg/m3)')
legend('Cost Function','Best Fit: z = 4.0 km & density = 1200 kg/m2')