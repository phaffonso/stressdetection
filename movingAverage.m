function s2 = movingAverage(s, window)
  
  s2 = zeros(size(s));
  
  for(k = 1:window-1)
    s2(k) = sum(s(1:k)/k);
  end
  
  for(k = window:size(s, 1))
    s2(k) = sum(s((k-window+1):k))/window;
  end
  
end