function [res r] = furniture_rbf_classify(sample, model)

sv = model.SupportVectors;
a = model.Alpha;
b = model.Bias;

scalefactor = model.ScaleData.scaleFactor;
shift = model.ScaleData.shift;

x = (sample + shift).*scalefactor;
lb = model.GroupNames(model.SupportVectorIndices);

r = 0;

kvelist = [];
for i = 1:size(sv, 1)
    kvel = kernel_rbf(x, sv(i,:), 3);
    disp([lb(i) kvel]);
    r = r + a(i) * (-1) * kvel;
    kvelist(end+1) = kvel;
end

r = r + b;

res = sign(r);

end