function res = get_diff_angle(a, b)

res = a - b;
res(find(a < 0)) = Inf;
res(find(res > 180)) = res(find(res > 180)) - 360;
res(find(res < -180)) = res(find(res < -180)) + 360;
end