function Y = lorFit(params,xAxis)

a = params(1);  %gamma_qd
b = params(2);  %gamma_sp
c = params(3);  %w_qd
d = params(4);  %w_sp
e = params(5);  %intensity qd
f = params(6);  %intensity sp
g = params(7);  %offset


Y = params(5)*params(1)./((xAxis - params(3)).^2 + params(1).^2) + params(6)*params(2)./((xAxis - params(4)).^2 + params(2).^2) + params(7);

end