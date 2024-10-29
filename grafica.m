function grafica(obex,me,irf,original)
      
      c = 1;
      fin1 = length(irf(1,:));   
      fin2 = length(original(1,:));
      disp('ingrese los canales del obex');
      while c <= obex
           obme(c) = input('canal no. : ');
           c=c+1;
      end
      disp('ingrese los canales de la ME');
      co =  c;
      c=1;
      while c <= me
           obme(co) = input('canal no. : ');
           c=c+1;
           co=co+1;
      end
      n = length(obme)+2;
      n2= (length(obme)*2)+2;
      c=1;
      c2=1;
      figure;
      while c <= n
          subplot(n2,1,c2);
          if c <= (n-2)
              plot(irf(:,fin1),irf(:,obme(c)));
              subplot(n2,1,c2+1);
              plot(original(:,1),original(:,obme(c)+1));
              c2=c2+2;
          end
          
          if c > (n-2) && c < n
              plot(original(:,1),original(:,fin2-1));
              c2=c2+1;
          end
          if c == n
               plot(original(:,1),original(:,fin2));
          end
          c=c+1;

      end
end
              
          
      