function [s] = pegaSpikes(spikesG,si,fs,neuronas)
        %Inputs:
        %SpikesG: es el vector que contiene el tiempo de ocurrencia de la
        %espiga y la localización de la espiga en el vector "neuronas"
        
        %si: es una señal baseline 0 que tiene la misma cantidad de
        %muestras que la señal original
        
        %fs: frecuncia de muestreo en Kh
        
        %Neuronas: Es el vector que contiene las formas de onda de las
        %espigas
        
        %Outputs:
        %s: es un vector con las espigas
        
        c=1;
        co = 1;
        
        while c <= length(spikesG(:,1))
            co = 1;
            mu = spikesG(c,1)*fs;
            n = mu-round(length(neuronas(:,1))/2);
            nA = round(n);
            nB = nA+length(neuronas(:,1));
            nB = nB-1;
            si(nA:nB)=neuronas(:,spikesG(c,2));
            c = c+1;         
        end
        s = si;
       
end
              
            
        