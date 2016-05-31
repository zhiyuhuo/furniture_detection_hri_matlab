function res = get_fpfh_feature(pc, fpfh) % get feature as a 2D mat of (Height(0:0.1m:1m), Distance(0:0.1m:1m))

H = 10;
D = 10;

xyzc = get_xyz_centroid(pc);
pc = [pc(:,1) - xyzc(1), pc(:,2) - xyzc(2), pc(:,3)];

mf = cell(H, D);
for h = 1:H
    for d = 1:D
        mf{h,d} = zeros(1,33);
    end
end
mc = zeros(H, D);
for h = 1:H
    for d = 1:D
        mc(h,d) = 0;
    end
end


for i = 1:size(pc,1)
    x = pc(i,1);
    y = pc(i,2);
    z = pc(i,3);
    
    f = fpfh(i,:);

    d = ceil(norm([x,y]) / 0.1);
    h = ceil(z / 0.1);

    if d > 0 && d <= 10 && h <= 10 && h > 0 
        mf{h,d} = mf{h,d} + f;
        mc(h,d) = mc(h,d) + 1;
    end

end

res = [];
for h = 1:H
    for d = 1:D
        if (mc(h,d) > 0)
            mf{h,d} = mf{h,d} / mc(h,d);
        end
        res = [res, mf{h,d}];
    end
end

end