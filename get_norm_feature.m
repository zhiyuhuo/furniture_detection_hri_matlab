function res = get_norm_feature(pc, nm) % get feature as a 2D mat of (Height(0:0.1m:1m), Distance(0:0.1m:1m))

H = 10;
D = 10;

mf = zeros(H,D);
cf = zeros(H,D);
feature = -ones(H, D);

xyzc = get_xyz_centroid(pc);
pc = [pc(:,1) - xyzc(1), pc(:,2) - xyzc(2), pc(:,3)];

for i = 1:size(pc,1)
    x = pc(i,1);
    y = pc(i,2);
    z = pc(i,3);
    
    nx = nm(i,1);
    ny = nm(i,2);
    nz = nm(i,3);
    
    if ~isnan(nx) && ~isnan(ny) && ~isnan(nz)     
        d = ceil(norm([x,y]) / 0.1);
        h = ceil(z / 0.1);

        if d > 0 && d <= 10 && h <= 10 && h > 0 
            cf(h,d) = cf(h,d) + 1;
            mf(h,d) = mf(h,d)+ get_norm_tilt(nx, ny, nz);
        end
    end
end

for h = 1:H
    for d = 1:D
        if cf(h,d) > 0
            feature(h,d) = mf(h,d) / cf(h,d);
        end
    end
end


res = feature;
end