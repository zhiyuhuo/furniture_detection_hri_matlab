function res = get_xyz_centroid(pc)

xc = (max(pc(:,1)) + min(pc(:,1))) / 2; 
yc = (max(pc(:,2)) + min(pc(:,2))) / 2; 
zc = (max(pc(:,3)) + min(pc(:,3))) / 2; 

res = [xc, yc, zc];

end