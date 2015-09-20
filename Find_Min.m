% Matlab script to find the minimum of a function.
% Note: this must be run iteratively, with narrower limits for xmin, xmax,
% to get location of minimum to desired degree of accuracy.

clear;  % make sure there are no variables already defined.
close all;  % close all figures to make sure you get the plot you make.

xmin = 0.0;  % limits for min, max, which must contain best x; can be
xmax = 5.0;  % narrowed until best x is found to some desired number of 
xdiv = 100;  % places. xdiv could be increased, but doesn't need to be as
             % you narrow the range between xmin and xmax.  Note that
             % current xmin, xmax limits find pi to 3.15, or 1 place past
             % the decimal point.

x = [xmin:((xmax-xmin)/xdiv):xmax]; % divide x range into xdiv divisions.

y = 1. + (x-pi).*(x-pi); % y is quadratic in x, with ymin = 1 & xbest = pi

ymin = 1000000.;    % initial guess for minimum must be large.
for i = 1:xdiv+1   % sweep across all values of function ...
    if (y(i) < ymin)  % if current value is less than estimate of minimum
            ymin = y(i) ; % revise estimate of minimum 
            xbest = x(i) ; % revise location of minimum
            ibest = i ; % revise location in xarray of minimum
    end
end

% If y is a function of two variables, then you need 2 'for' loops over
% two ranges (one for each variable).

ymin   % estimate of minimum of function; note true min is 1.
xbest  % estimate of x location of minimum; note true location is pi.
ibest  % location within x array where xbest (and hence ybest) occur.

% The commands below plot the function to help you visualize it.  You
% don't need to keep them in the modified code for HW#2 Problem 2b.
figure ;
plot(x,y)
set(gca,'xlim',[xmin xmax], 'ylim',[0 12]);
xlabel('x');
ylabel('y');
title('Plot of: y = 1 + (x-pi)^2');
grid

