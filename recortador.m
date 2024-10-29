function new = recortador(old,fs,tc,mu,mu2,tie)
          t = length(old(:,1))/fs;
          m = round(fs* tc);
          mu = round(fs*mu);
          mu2 = round(fs*mu2);
          a = mu-m;
          new(1:m,:) = old(a:a+m-1,:);
          a = m+1;
          b = m*2+1;
          c=mu+m;
          new(a:b,:)=old(mu:c,:);
          a =  (m*2)+2;
          b =  (m*3)+2;
          c = mu2+m;
          i = 1/fs;
          temp = old(mu2:c,:);
          constante = temp(1,tie)-(new(length(new),tie)+i);
          temp(:,tie)= temp(:,tie)-constante;          
          new(a:b,:)=temp;
end
          
    