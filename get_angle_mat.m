function res = get_angle_mat(pc, nm)

H = 10;
D = 10;

mf = zeros(H,D,2);
cf = zeros(H,D);
feature = -ones(H,D,2);

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

        if d > 0 && d <= 10 && h <= 10 && h > 0 && get_norm_tilt(nx, ny, nz) < 0.5
            anglev = get_norm_angle(nx, ny, nz);
            ianglev = anglev + 180;
            if (ianglev > 360)
                ianglev = ianglev - 360;
            end
            cf(h,d) = cf(h,d) + 1;
            mf(h,d,1) = mf(h,d,1) + anglev;
            mf(h,d,2) = mf(h,d,2) + ianglev;
        end
    end
end

for h = 1:H
    for d = 1:D
        if cf(h,d) > 0
            feature(h,d,1) = mf(h,d,1) / cf(h,d);
            feature(h,d,2) = mf(h,d,2) / cf(h,d);
        end
    end
end


res = feature;
end