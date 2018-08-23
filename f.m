

function Y = f(params,x_ev)

a = params(1);  %gamma_qd
b = params(2);  %gamma_sp
c = params(3);  %w_qd
d = params(4);  %w_sp
e = params(5);  %rabi frequency
f = params(6);  %intensity
g = params(7);  %offset

%     A = 1i.*sqrt(e^2 -((d-c)/2)^2 + ((b-a)/2)^2);
%     B = (a+b)/2+1i.*(c-d)/2-1i.*(x_ev-d);
%  
%     Y = f*b/pi.*abs((-A)./(B.^2+e.^2)).^2 + g;

% haixu's model:

A = 1i.*(x_ev-c + (c-d));
B = (a+b)/4-1i.*(c-d)/2-1i.*(x_ev-c);
G = sqrt((e/2)^2 + ((c-d)/2)^2 - ((a-b)/4)^2);

Y = f*a/pi.*abs((b/2-A)./(B.^2+G.^2)).^2 + g;

% A = 1i.*(x_ev+c-2.*d);
% B = (a+b)/2-1i.*(c-d)/2-1i.*(x_ev-d);
% 
% Y = f*a/pi.*abs((b-A)./(B.^2+e.^2)).^2 + g;

end

