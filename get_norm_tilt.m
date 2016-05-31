function res = get_norm_tilt(nx, ny, nz)

res = abs(nz) / norm([nx,ny,nz]);

end