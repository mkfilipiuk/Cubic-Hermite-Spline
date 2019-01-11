# testhspline

N = 2;
old_E = 0;
Ns = [];
Es = [];
for i = 1:20
  x = linspace(-5,5,N);
  test_x = linspace(-5,5,100000);
  f_test_x = 1./(test_x.^2+1);
  pp = hspline(x,1./(x.^2+1),-2.*x./((x.^2+1).^2));
  v = ppval(pp,test_x);
  new_E = max(abs(v - f_test_x));
  disp(log2(old_E/new_E));
  old_E = new_E;
  Es = [Es; new_E];
  Ns = [Ns ; N];
  N = N*2;
  plot(test_x,1./(test_x.^2+1),test_x,ppval(pp,test_x));
  legend("a","b");
  pause(1)
endfor

# As we see, r equals 4
loglog(Ns,Es,Ns,1./(Ns.^4));
legend("E_N","N^{-4}");