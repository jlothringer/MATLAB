load('hw3_variables')
covd1 = [2 0 0 0 0 0 0 0 0 ; 0 2 0 0 0 0 0 0 0 ; 0 0 2 0 0 0 0 0 0 ; 0 0 0 2 0 0 0 0 0 ; 0 0 0 0 2 0 0 0 0 ; 0 0 0 0 0 2 0 0 0 ; 0 0 0 0 0 0 2 0 0 ; 0 0 0 0 0 0 0 2 0 ; 0 0 0 0 0 0 0 0 6]
covd2 = [2 0 0 0 0 0 0 0 0 ; 0 2 0 0 0 0 0 0 0 ; 0 0 2 0 0 0 0 0 0 ; 0 0 0 2 0 0 0 0 0 ; 0 0 0 0 2 0 0 0 0 ; 0 0 0 0 0 2 0 0 0 ; 0 0 0 0 0 0 2 0 0 ; 0 0 0 0 0 0 0 2 0 ; 0 0 0 0 0 0 0 0 2]
covd3 = [2 0 0 0 0 0 0 0 0 ; 0 2 0 0 0 0 0 0 0 ; 0 0 2 0 0 0 0 0 0 ; 0 0 0 2 0 0 0 0 0 ; 0 0 0 0 2 0 0 0 0 ; 0 0 0 0 0 2 0 0 0 ; 0 0 0 0 0 0 2 0 0 ; 0 0 0 0 0 0 0 2 0 ; 0 0 0 0 0 0 0 0 0.5]


mwls1 = inv(G' * inv(covd1) * G) * G' * inv(covd1) * d'
mwls2 = inv(G' * inv(covd2) * G) * G' * inv(covd2) * d'
mwls3 = inv(G' * inv(covd3) * G) * G' * inv(covd3) * d'

figure
axis([0 6 -6 14])
plot(z,d,'X')
hold on
axis([0 6 -6 14])
title('Lothringer - Hw4p1')
xlabel('z')
ylabel('d')
grid
zmore = [0,6]
plot(zmore,mwls1(1)+mwls1(2)*zmore,'-k','LineWidth',3)
plot(zmore,mwls2(1)+mwls2(2)*zmore,'--r','LineWidth',3)
plot(zmore,mwls3(1)+mwls3(2)*zmore,':b','LineWidth',3)

plot(zmore,m1_best_l1+m2_best_l1*zmore,'-b')
plot(zmore,m1_best_l2+m2_best_l2*zmore,'--g')
plot(zmore,m1_best_l3+m2_best_l3*zmore,':r')
plot(zmore,m1_best_linf+m2_best_linf*zmore,'-.k')
%plot(zmore,m1_best_linf+m2_best_linf*zmore,'-.k')
% text(5.5,5.9,'L1')
% text(5.65,8,'L2')
% text(0.5,-2,'L3')
% text(1.25,-2.2,'Linf')
legend('Data','Covd(9) = 6','Covd(9) = 2','Covd(9) = 0.5',sprintf('L1 Best Fit: d = %5.3f + %5.3f z',m1_best_l1,m2_best_l1), ...
        sprintf('L2 Best Fit: d = %5.3f + %5.3f z',m1_best_l2,m2_best_l2), ...
        sprintf('L3 Best Fit: d = %5.3f + %5.3f z',m1_best_l3,m2_best_l3), ...
        sprintf('Linf Best Fit: d = %5.3f + %5.3f z',m1_best_linf,m2_best_linf), ...
        'Location','NorthWest')
    
    
    %NEW DATA
    
z = [2.0 3.0 4.0 5.0 6.0]
d = [3.5 2.9 5.7 5.9 7.0]
zmore = [-1 7]
a = zeros(size(z)) ;
G = [a+1;z]' ;

mls = inv(G'*G)*G'*d'

d_pre = mls(1) + mls(2) * z
e = d_pre - d
big_e = e * e'
error = sqrt(big_e / 4)
errors = [error error error error error]

figure
axis([-1 7 -1 9])
hold on
plot(z,d,'rX')
plot(zmore,mls(1)+zmore*mls(2))
errorbar(z,d,errors,'rx')
title('Lothringer HW4p2')
xlabel('z')
ylabel('d')
legend(sprintf(' = data \n'), ...
           sprintf(' d = %4.3f + %4.3f z',mls), ...
           sprintf(' Summed Squared Misfit = %4.3f',big_e),'Location','NorthWest') ;
       
big_h = [1 0]
h = [0]

new_G = [G ; big_h]
new_d = [d 0]

new_d = [d 0]
new_z = [z 0]


new_mls = inv(new_G'*new_G)*new_G'*new_d'
new_d_pre = new_mls(1) + new_mls(2)*new_z
new_e = new_d_pre - new_d
new_big_e = new_e * new_e'

error = sqrt(new_big_e / 4)
errors = [error error error error error error]

new_old_d_pre = new_mls(1) + new_mls(2)*z
new_old_e = new_old_d_pre - d
new_old_big_e = new_old_e * new_old_e'

figure
axis([-1 7 -1 9])
hold on
plot(z,d,'rX')
plot(0,0,'bX')
plot(zmore,new_mls(1)+zmore*new_mls(2))
errorbar(new_z,new_d,errors,'rx')
title('Lothringer HW4p3')
xlabel('z')
ylabel('d')
legend(sprintf(' = data \n'), ...
           sprintf(' d = %4.3f + %4.3f z',new_mls), ...
           sprintf(' Summed Squared Misfit = %4.3f',new_big_e),'Location','NorthWest') ;
       
       %Problem 4
       %I'm just going to redefine covariance...
       
covd1 = [1 0 0 0 0 0 ; 0 1 0 0 0 0 ; 0 0 1 0 0 0 ; 0 0 0 1 0 0 ; 0 0 0 0 1 0 ; 0 0 0 0 0 355] 

mwls = inv(new_G' * inv(covd1) * new_G) * new_G' * inv(covd1) * new_d'

new_d_pre = mwls(1) + mwls(2) * new_z

e = new_d_pre - new_d

big_e = e * e'

error = sqrt(big_e / 4)
errors = [error error error error error error]

original_d_pre = mwls(1) + mwls(2) * z
original_e = original_d_pre - d
original_big_e = original_e*original_e'

figure
axis([-1 7 -1 9])
hold on
plot(new_z,new_d,'rX')
plot(zmore,mwls(1)+zmore*mwls(2))
errorbar(new_z,new_d,errors,'rx')
title('Lothringer HW4p4c')
xlabel('z')
ylabel('d')
legend(sprintf(' = data \n'), ...
           sprintf(' d = %4.3f + %4.3f z',mwls), ...
           sprintf(' Summed Squared Misfit = %4.3f',big_e),'Location','NorthWest') ;

       
covd1 = [1 0 0 0 0 0 ; 0 1 0 0 0 0 ; 0 0 1 0 0 0 ; 0 0 0 1 0 0 ; 0 0 0 0 1 0 ; 0 0 0 0 0 0.094] 

mwls = inv(new_G' * inv(covd1) * new_G) * new_G' * inv(covd1) * new_d'

new_d_pre = mwls(1) + mwls(2) * new_z

new_d_pre(6)

e = new_d_pre - new_d

big_e = e * e'

error = sqrt(big_e / 4)
errors = [error error error error error error]

original_d_pre = mwls(1) + mwls(2) * z
original_e = original_d_pre - d
original_big_e = original_e*original_e'

figure
axis([-1 7 -1 9])
hold on
plot(new_z,new_d,'rX')
plot(zmore,mwls(1)+zmore*mwls(2))
errorbar(new_z,new_d,errors,'rx')
title('Lothringer HW4p5c')
xlabel('z')
ylabel('d')
legend(sprintf(' = data \n'), ...
           sprintf(' d = %4.3f + %4.3f z',mwls), ...
           sprintf(' Summed Squared Misfit = %4.3f',big_e),'Location','NorthWest') ;
       
       %problem 6
       
covd1 = [1 0 0 0 0 0 ; 0 1 0 0 0 0 ; 0 0 1 0 0 0 ; 0 0 0 0.082 0 0 ; 0 0 0 0 1 0 ; 0 0 0 0 0 0.084] 

mwls = inv(new_G' * inv(covd1) * new_G) * new_G' * inv(covd1) * new_d'

new_d_pre = mwls(1) + mwls(2) * new_z

new_d

disc4 = new_d_pre(4)-new_d(4)
disc6 = new_d_pre(6)-new_d(6)

e = new_d_pre - new_d

big_e = e * e'

original_d_pre = mwls(1) + mwls(2) * z
original_e = original_d_pre - d
original_big_e = original_e*original_e'

error = sqrt(big_e / 4)
errors = [error error error error error error]

figure
axis([-1 7 -1 9])
hold on
plot(new_z,new_d,'rX')
plot(zmore,mwls(1)+zmore*mwls(2))
errorbar(new_z,new_d,errors,'rx')
title('Lothringer HW4p6c')
xlabel('z')
ylabel('d')
legend(sprintf(' = data \n'), ...
           sprintf(' d = %4.3f + %4.3f z',mwls), ...
           sprintf(' Summed Squared Misfit = %4.3f',big_e),'Location','NorthWest') ;
       
       %Problem 8
       
lg_G = [5 sum(z) 1 ; sum(z) sum(z.^2)  0 ; 1 0 0]
lg_d = [sum(d) ; sum(z*d') ; 0]

lg = inv(lg_G) * lg_d
       
original_d_pre = lg(1) + lg(2) * z
original_e = original_d_pre - d
original_big_e = original_e*original_e'

new_d_pre = lg(1) + lg(2) * new_z

e = new_d_pre - new_d

big_e = e * e'

error = sqrt(big_e / 4)
errors = [error error error error error 0]

figure
axis([-1 7 -1 9])
hold on
plot(new_z,new_d,'rX')
plot(zmore,mwls(1)+zmore*mwls(2))
errorbar(new_z,new_d,errors,'rx')
title('Lothringer HW4pc')
xlabel('z')
ylabel('d')
legend(sprintf(' = data \n'), ...
           sprintf(' d = %4.3f + %4.3f z',lg(1:2)), ...
           sprintf(' Summed Squared Misfit = %4.3f',big_e),'Location','NorthWest') ;
