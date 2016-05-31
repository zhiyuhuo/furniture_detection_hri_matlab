function res = get_tanh(x, m)

x = x * 2 - 1;

res = (exp(2*m*x) - 1) ./ (exp(2*m*x) + 1);

res = (res + 1) / 2;

end