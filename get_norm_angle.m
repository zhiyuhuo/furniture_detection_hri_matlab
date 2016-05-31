function res = get_norm_dir(nx, ny, nz)

a = atan2(ny, nx);
if a < 0
    a = a + 2 * pi;
end
a = a * 180 / pi;

res = a;

end