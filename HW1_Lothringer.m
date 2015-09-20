fid = fopen('HW1_Lothringer.out','wt');
fprintf(fid,'HW1:Geos 567: Lothringer\n'); % Lothringer
bdat = load('nbp0207_bath.dat');
z = bdat(:,1); 
d = bdat(:,2); 
z = -z; 
minz = min(z) ; 
mind1 = min(d); 
d = d - mind1; 
mind = min(d); 
maxd = max(d); 
save hw1p4_LastName z d ;  % Lothringer
figure; 
orient tall; 
subplot(2,1,1) 
plot(d,z,'c.-'); 
grid  
set(gca,'ydir','reverse'); 
set(gca,'xlim',[400 500]); 
xlabel('Distance (km)'); 
ylabel('Depth (m)'); 
title('Seamount Bathymetry'); 
minz_str = sprintf('Minimum Depth (m) = %4.0f',minz); 
text(450,3800,minz_str) ; 
text(410,3800,'Lothringer'); %(Use your own last name for ?LastName?) 
subplot(2,1,2) 
plot(d,z,'k-^','MarkerSize',4,'MarkerFaceColor','m'); 
grid  
set(gca,'ydir','reverse','xlim',[600 700],'ylim',[6000 7000]); 
xlabel('Distance (km)'); 
ylabel('Depth (m)'); 
title('Normal Seafloor Bathymetry'); 
fprintf(fid, '\n The profile runs from %4.0f to %4.0f km \n',mind,maxd); 
fclose(fid); 
print hw1p4_LastName_fig.jpeg -djpeg

x=[0:2:360];
y=sin(x*pi/180.);