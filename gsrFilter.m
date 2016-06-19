function s2 = gsrFilter(s, dt, fc)
  tau = 2*pi*fc*dt;
  alpha = tau / (tau + 1);
  s2 = zeros(size(s));
  k = 1;
  while s(k) <= 0
    k = k+1;
  end
  s2(1) = s(k);
  
  for k  = 2:size(s, 1)
    if(s(k) <= 0)
      s2(k) = s2(k-1);
    else
      s2(k) = alpha * s(k) + (1 - alpha) * s2(k - 1);
    end
  end
end