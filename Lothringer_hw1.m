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

figure

plot(x,gz_arr,'r--','LineWidth',3)
hold on
plot(x,gz_arr,'kx')
axis([-15 15 0 80])
xlabel('Horizontal distance x (km)')
ylabel('Gravity Anomaly (mgal)')
grid
title('Vertical Gravity Anomaly - Lothringer')
