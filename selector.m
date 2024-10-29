function selector
    close all;
    clc;
    bandera = 0;
    irtemp = 0;
    irftemp = 0;
    n = input('escribe el numero de señales a procesar de la 1 a la n: ');
    ext = input('escribe el canal de la extensión: ');
    flex = input('escribe el canal de la flexión: ');
    fc = input('escribe la frecuencia de corte: ');
    
    fc = fc*1000;
    [filename pathname] = uigetfile('*.abf', 'seleccion archivos abf', 'Multiselect', 'on');
    if length(filename(1,:)) > 1
      filename = filename';
      number = length(filename);
    else
        number = length(filename(:,1));
    end
    contador = 1;  
    while contador <= number
        
        if length(filename(:,1)) > 1
            file = strcat(pathname,filename(contador))
            file = file{1};
        else
            file = strcat(pathname,filename)
        end
        si = abfload(file);
        tiempov = length(si(:,1))/50000
        tiempov = 1/50000:1/50000:tiempov;
        co = 1;
        while co <= n
            [ir(:,co),irf(:,co),ti,flexi,extensi]=RectInt(si(:,co),5,50,fc,si(:,flex),si(:,ext));
            co = co+1;
        end
        if length(filename(:,1)) > 1
            fname = filename(contador);
            fname = fname{1};
        else
            fname = filename;
        end        
        fname = fname(1:length(fname)-4);        
        
        fnameobexir = strcat(fname,'obex_ir.txt');
        fnameobexir = strcat(pathname,fnameobexir);         
 
        fnameobexirf = strcat(fname,'obex_irf.txt');
        fnameobexirf = strcat(pathname,fnameobexirf);
        
        fnameobexint = strcat(fname,'obex_int.mat');
        fnameobexint = strcat(pathname,fnameobexint);
        
        fnamemeir = strcat(fname,'me_ir.txt');
        fnamemeir = strcat(pathname,fnamemeir);  
        
        fnamemeirf = strcat(fname,'me_irf.txt');
        fnamemeirf = strcat(pathname,fnamemeirf); 
        
        fnamemeint = strcat(fname,'me_int.mat');
        fnamemeint = strcat(pathname,fnamemeint);
        
        fnamerascado = strcat(fname,'_rascado.txt');
        fnamerascado = strcat(pathname,fnamerascado);
        
        ir(:,co)=flexi;
        ir(:,co+1)=extensi;
        ir(:,co+2)=ti;  
        irf(:,co)=flexi;
        irf(:,co+1)=extensi;
        irf(:,co+2)=ti;
        figure
        
        fs =  length(irf(:,1))/irf( length(irf(:,1)),length(irf(1,:)))
        op = 0;
        plot(tiempov,si(:,flex));

 
        op = 0;
        bandera = 0;
        pause(0.5);
        si2(:,1)=tiempov;
        si2 = [si2 si];
        close all;
        while op ~= 'N' 
            
            disp('*********recorta la señal**********');
            mu = input('diga en que segundo inicia el rascado: ');
            mu2 = input('diga en que segundo termina el rascado: ');
            tc =  input('cuanto tiempo de los segmentos al cortar: ');
            sitemp = recortador(si2,50000,tc,mu,mu2,1);
            irftemp = recortador(irf,fs,tc,mu,mu2,length(irf(1,:)));
            irtemp = recortador(ir,fs,tc,mu,mu2,length(ir(1,:)));
            obex = input('Cuantos canales tienes del obex: ');
            me = input('Cuantos canales tienes de la medula espinal: ');
            [chobex,chme]=grafica2(obex,me,irftemp,sitemp);%arreglar que la señal original se recorte tambien
            op = 0;
            while op ~= 'N' && op ~='S'
                op = upper(input('¿deseas volver a recortar? S/N: ','s'));
                if op == 'S'
                     clear irftemp;
                     clear irtemp;
                     clear sitemp;
                end                    
            end
        end  
        if bandera == 0
            c= 1;
            if chobex(1,1) >= 1
             while c <= length(chobex)
                chobexir(:,c)=irtemp(:,chobex(c));
                chobexirf(:,c)=irftemp(:,chobex(c));
                chobexint(:,c)=sitemp(:,chobex(c)+1);
                c=c+1;
             end
             chobexir(:,c)=irtemp(:,length(irtemp(1,:)));
             chobexirf(:,c)=irftemp(:,length(irftemp(1,:)));
             chobexint(:,c)=sitemp(:,1);
            end
            c=1;
            if chme(1,1) >= 1
             while c<= length(chme)
                chmeir(:,c)=irtemp(:,chme(c));
                chmeirf(:,c)=irftemp(:,chme(c));
                chmeint(:,c)=sitemp(:,chme(c)+1);               
                c=c+1;
             end
             chmeir(:,c)=irtemp(:,length(irtemp(1,:)));
             chmeirf(:,c)=irftemp(:,length(irftemp(1,:)));
             chmeint(:,c)=sitemp(:,1);
            end
            if chobex(1,1) >= 1    
                save(fnameobexir,'chobexir','-ascii');
                clear chobexir;
                save(fnameobexirf,'chobexirf','-ascii'); 
                clear chobexirf;
                data = chobexint;
                save(fnameobexint,'data');
                clear chobexint;
            end
            if chme(1,1) >= 1 
                save(fnamemeir,'chmeir','-ascii'); 
                save(fnamemeirf,'chmeirf','-ascii');
                data = chmeint;
                save(fnamemeint,'data'); 
            end            
            sitemp2(:,1) = (sitemp(:,ext));
            sitemp2(:,2) = (sitemp(:,flex));
            save(fnamerascado,'sitemp2','-ascii');
            clear sitemp2;
        end
        clear si;
        clear si2;
        clear tiempov;
        clear irftemp;
        clear irtemp;
        clear file;
        clear ir;
        clear irf;
        clear flexi;
        clear extensi;
        clear chmeir
        clear chmeirf
        clear chmeint
        contador=contador+1;
        clc;
        close all;
    end
             
end
    
    
    