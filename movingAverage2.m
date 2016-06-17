function s2 = movingAverage2(s, window)
  if window > size(s, 1)
    window = size(s, 1);
  end
  
  s2 = zeros(size(s));
  
  for(k = 1:window-1)
    s2(k) = sum(s(1:k)/k);
  end
  
  for(k = window:size(s, 1))
    s2(k) = sum(s((k-window+1):k))/window;
  end
  
end