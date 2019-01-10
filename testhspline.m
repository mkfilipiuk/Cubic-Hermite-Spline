# testhspline

N = 2;
old_E = 0;
Ns = [];
Es = [];
for i = 1:25
  x = linspace(-5,5,N);
  test_x = linspace(-5,5,1000000);
  f_test_x = 1./(test_x.^2+1);
  pp = hspline(x,1./(x.^2+1),-2.*x./((x.^2+1).^2));
  v = ppval(pp,test_x);
  new_E = max(abs(v - f_test_x));
  disp(log2(old_E/new_E));
  old_E = new_E;
  Es = [Es; new_E];
  Ns = [Ns ; N];
  N = N*2;
endfor

print("As we see, r equals 1")
loglog(Ns,Es,Ns,1./Ns);
legend("E_N","N^{-1}");