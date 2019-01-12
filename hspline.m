function pp = hspline(x,y,z)
% HSPLINE Calculate Cubic Hermite spline on intervals x, values v, derivatives z 
%   Cubic Hermite spline aproximates some function f using:
%    - intervals x - sequence of unique points in ascending order where f values and derivatives are defined in v and z
%    - values v - values of function f defined on points x 
%    - derivatives z - values of first derivatives of function f defined on points x 
  
  # Checking if numer of arguments is correct
  if nargin != 3
    error("Wrong number of arguments")
  endif
  
  # Turning arguments into column vectors
  x = x(:);
  y = y(:);
  z = z(:);
  
  # Getting vector lengths
  x_l = length(x);
  y_l = length(y);
  z_l = length(z);
  
  # Checking if they are of the same length
  if x_l != y_l || y_l != z_l 
    error("Wrong lengths of vectors!");
  endif
  
  # Checking if we have unique values in x
  if length(unique(x)) != x_l
    error("x values are not unique!");
  endif
  
  # Checking if x is sorted and sorting if necessary
  if !issorted(x)
    warning("x is not sorted!");
    s = sortrows([x,y,z]);
    x = s(:,1);
    y = s(:,2);
    z = s(:,3);
  endif
  
  # Separating beginnings and endings of intervals
  xi = x(1:end-1);
  xi_1 = x(2:end);
  yi = y(1:end-1);
  yi_1 = y(2:end);
  zi = z(1:end-1);
  zi_1 = z(2:end);
  
  # Calculating intervals lengths and their powers
  d1 = (xi_1 - xi);
  d2 = d1.*(xi_1 - xi);
  d3 = d2.*(xi_1 - xi);
  
  # each piece of the cubic Hermite spline can be defined with polynomial a*x^3 + b*x^2 + c*x + d
  # Those calculations below are defining these coefficients. They are the solutions of equations:
  # a*(xi - xi)^3 + b*(xi - xi)^2 + c*(xi - xi) + d = yi
  # a*(xi_1 - xi)^3 + b*(xi_1 - xi)^2 + c*(xi_1 - xi) + d = yi_1
  # 3*a*(xi - xi)^2 + 2*b*(xi - xi) + c = zi
  # 3*a*(xi_1 - xi)^2 + 2*b*(xi_1 - xi) + c = zi_1
  d = yi;
  c = zi;
  a = (zi_1.*d1 + 2*d - 2*yi_1 + c.*d1)./d3;
  b = (yi_1-d-c.*d1-a.*d3)./d2;
  
  # Creating cubic Hermite spline as piecewise polynomial
  pp = mkpp(x, [a,b,c,d]);
endfunction
