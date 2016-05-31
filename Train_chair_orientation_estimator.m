%
clc;
clear;
close all;
%

C = 'chair';
fname = ['anglefeaturelib_' num2str(C), '.mat'];
anglefeaturelib = load(fname);
anglefeaturelib = anglefeaturelib.anglefeaturelib;
w = zeros(10, 10);

for n = 1:length(anglefeaturelib);
    
    chunk = anglefeaturelib{n};
    m = chunk{1};
    m1 = m(:,:,1);
    m2 = m(:,:,2);
    th = chunk{2};
    
    %get diff angle;
    anglediff = min(abs(get_diff_angle(m1, th)), abs(get_diff_angle(m2, th)));
    anglediffOrig = anglediff;
    anglediff = (30 - anglediff) / 30;
    anglediff = 1 - get_tanh(anglediff, 10);
    anglediff(find(anglediffOrig == Inf)) = Inf;
    simi = exp(-anglediff);
    
    w = w + simi;

end

w = w ./ max(max(w));
anglew = reshape(w', [size(w,1)*size(w,2),1]);
bar(anglew)

savedir = ['models/orientation_' C '.mat'];
save(savedir, 'anglew');







