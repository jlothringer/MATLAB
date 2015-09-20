z = [1.0 1.5 2.0 2.5 3.0 3.5 4.0 4.5 5.0];
d = [0.6 1.8 1.9 2.9 3.1 3.2 4.4 4.6 11.0];

figure
axis([0 6 -6 14])
plot(z,d,'X')
title('Lothringer - Problem 1')
xlabel('z')
ylabel('d')
grid
legend('Data')

for i = 1:9;
    l1(i) = 