z = [1.0 1.5 2.0 2.5 3.0 3.5 4.0 4.5 5.0];
d = [0.6 1.8 1.9 2.9 3.1 3.2 4.4 4.6 11.0];

figure
axis([0 6 -6 14])
plot(z,d,'X')
axis([0 6 -6 14])
title('Lothringer - Problem 1')
xlabel('z')
ylabel('d')
grid
legend('Data')

%L1 NORM

m1min = -0.55
m1max = -0.65
m1div = 100

m2min = 1.20
m2max = 1.30
m2div = 100

m1 = [m1min:((m1max-m1min)/m1div):m1max]; % divide x range into xdiv divisions.
m2 = [m2min:((m2max-m2min)/m2div):m2max]; % divide x range into xdiv divisions.

for i = 1:m1div+1
    for j = 1:m2div+1
        l1(i,j) = sum(abs(d - (m1(i)+m2(j)*z)).^(1))^(1.);
%         for k = 1:9;
%             l1(k) = sum(abs(d - (m1(i)+m2(j)*z).^(1))^(1.)
%         end
    end
end

[A,B] = min(l1);
[min_c,mcol] = min(A);
mrow = B(mcol);

m1_best_l1 = m1(mrow)
m2_best_l1 = m2(mcol)

%L2 NORM

% m1min = -1.55
% m1max = -1.45
% m1div = 100
% 
% m2min = 1.45
% m2max = 1.55
% m2div = 100

%new limits for 3b
m1min = -5
m1max = 1
m1div = 1000

m2min = 1
m2max = 3
m2div = 1000

m1 = [m1min:((m1max-m1min)/m1div):m1max]; % divide x range into xdiv divisions.
m2 = [m2min:((m2max-m2min)/m2div):m2max]; % divide x range into xdiv divisions.

for i = 1:m1div+1
    for j = 1:m2div+1
        l2(i,j) = sum(abs(d - (m1(i)+m2(j)*z)).^(2))^(1/2.);
%         for k = 1:9;
%             l1(k) = sum(abs(d - (m1(i)+m2(j)*z).^(1))^(1.)
%         end
    end
end

[A,B] = min(l2);
[min_c,mcol] = min(A);
mrow = B(mcol);

m1_best_l2 = m1(mrow)
m2_best_l2 = m2(mcol)

figure
axis([-5 1 1 3]);
[blah,blah2]=contour(m1,m2,l2',[5 6 8 10 12]);
clabel(blah,blah2,'labelspacing',900);
hold on
plot(m1_best_l2,m2_best_l2,'X')
title('HW3p3b-Josh Lothringer')
xlabel('M1 (intercept)')
ylabel('M2 (slope)')
legend('L2 Norm','Best Fit: m1 = -1.808, m2 = 1.844')

a = zeros(size(z)) ;
G = [a+1;z]' ;
mls = inv(G'*G)*G'*d'

%L3 NORM

m1min = -2.7;
m1max = -2.6;
m1div = 100;

m2min = 2.1;
m2max = 2.2;
m2div = 100;

m1 = [m1min:((m1max-m1min)/m1div):m1max]; % divide x range into xdiv divisions.
m2 = [m2min:((m2max-m2min)/m2div):m2max]; % divide x range into xdiv divisions.

for i = 1:m1div+1
    for j = 1:m2div+1
        l3(i,j) = sum(abs(d - (m1(i)+m2(j)*z)).^(3))^(1/3.);
%         for k = 1:9;
%             l1(k) = sum(abs(d - (m1(i)+m2(j)*z).^(1))^(1.)
%         end
    end
end

[A,B] = min(l3);
[min_c,mcol] = min(A);
mrow = B(mcol);

m1_best_l3 = m1(mrow)
m2_best_l3 = m2(mcol)

%Linf NORM

m1min = -4.6;
m1max = -4.5;
m1div = 100;

m2min = 2.55;
m2max = 2.65;
m2div = 1000;

m1 = [m1min:((m1max-m1min)/m1div):m1max]; % divide x range into xdiv divisions.
m2 = [m2min:((m2max-m2min)/m2div):m2max]; % divide x range into xdiv divisions.

for i = 1:m1div+1
    for j = 1:m2div+1
        linf(i,j) = sum(abs(d - (m1(i)+m2(j)*z)).^(200.))^(1/200.);
%         for k = 1:9;
%             l1(k) = sum(abs(d - (m1(i)+m2(j)*z).^(1))^(1.)
%         end
    end
end

[A,B] = min(linf);
[min_c,mcol] = min(A);
mrow = B(mcol);

m1_best_linf = m1(mrow)
m2_best_linf = m2(mcol)

%Megaplot

figure
axis([0 6 -6 14])
plot(z,d,'X')
hold on
axis([0 6 -6 14])
title('Lothringer - Hw3p6')
xlabel('z')
ylabel('d')
grid
zmore = [0,6]
plot(zmore,m1_best_l1+m2_best_l1*zmore,'-b')
plot(zmore,m1_best_l2+m2_best_l2*zmore,'--g')
plot(zmore,m1_best_l3+m2_best_l3*zmore,':r')
plot(zmore,m1_best_linf+m2_best_linf*zmore,'-.k')
text(5.5,5.9,'L1')
text(5.65,8,'L2')
text(0.5,-2,'L3')
text(1.25,-2.2,'Linf')
legend('Data',sprintf('L1 Best Fit: d = %5.3f + %5.3f z',m1_best_l1,m2_best_l1), ...
        sprintf('L2 Best Fit: d = %5.3f + %5.3f z',m1_best_l2,m2_best_l2), ...
        sprintf('L3 Best Fit: d = %5.3f + %5.3f z',m1_best_l3,m2_best_l3), ...
        sprintf('Linf Best Fit: d = %5.3f + %5.3f z',m1_best_linf,m2_best_linf), ...
        'Location','NorthWest')
save('hw3_variables')
