                function  AddActionPotentials
                %Inputs:
                %Signal es la señal original de donde se extrageron las neuronas
                %fs es la frecuencia de muestreo en kh
                %El programa abrira el explorador de windows y usted debe cargar
                %el archivo con extensión .mat que genero wave_clus
                %Outputs:

                %El programa regresará hasta 4 señales
                % y cada una incluye  a su respectiva neurona que haya segregado waveclus

                clc;
                fs = input('diga la frecuecia de muestreo en KZ: ');
                [file,path] = uigetfile('times*.mat', 'seleccion de los archivos: "times"', 'Multiselect', 'on');
                filename = cellstr(file);
                number = length(filename);
                contador = 1;
                fc = input('Ingrese la frecuencia de corte en Khz: ');
                fc = fc*1000;
                while contador <= number
                   
                    load(strcat(path,char(filename(contador))));
                    arc =  char(filename(contador));
                    signal = load(strcat(path,arc(7:length(arc))));        
                    ceros(1:length(signal.data)) = 0;
                    val = max(cluster_class(:,1));
                    cont = 1;
                    co = 1;
                    Spikes1=0;
                    Spikes2=0;
                    Spikes3=0;
                    Spikes4=0;
                    while cont <= val
                        conta = 1;
                        co =  1;
                        while conta <= length(cluster_class(:,1))
                            if cont == 1
                                if cluster_class(conta,1) == 1
                                    Spikes1(co,1)=cluster_class(conta,2);
                                    Spikes1(co,2)=conta;
                                    co = co+1;
                                end

                            end

                            if cont == 2
                                if cluster_class(conta,1) == 2
                                    Spikes2(co,1)=cluster_class(conta,2);
                                    Spikes2(co,2)=conta;
                                    co = co+1;
                                end

                            end
                            if cont == 3
                                if cluster_class(conta,1) == 3
                                    Spikes3(co,1)=cluster_class(conta,2);
                                    Spikes3(co,2)=conta;
                                    co = co+1;
                                end

                            end
                            if cont == 4
                                if cluster_class(conta,1) == 4
                                    Spikes4(co,1)=cluster_class(conta,2);
                                    Spikes4(co,2)=conta;
                                    co = co+1;
                                end
                            end
                            conta = conta+1;
                        end
                        cont = cont+1;
                    end
                    %%%%%%%%%%%%%%%%%%%%%%%
                    opc = 0;
                   % while opc ~= 'N'
                    clc;
                    arreglo = 'Analizando el archivo: %s.';
                    arreglo = sprintf(arreglo,char(filename(contador))) ;
                    disp(arreglo);
                    %input('escriba la frecuencia de corte en KHz: ');
                    
                    d1 = designfilt('lowpassiir','FilterOrder',2, ...
                        'PassbandFrequency',fc,'PassbandRipple',0.2, ...
                        'SampleRate',200e3);
                    if Spikes1(1,1) > 0          
                        neuronas.s1 = pegaSpikes(Spikes1,ceros,fs,spikes');
                            neuronas.s1(1) = [];
                            neuronas.s1(1) = [];
                            if rem(length(neuronas.s1),2) ~= 0
                                neuronas.s1(1) = [];
                            end
                            neuronas.s1 = awgn(neuronas.s1,30);
                            f= FACTS(length(neuronas.s1));
                            s1r = abs(neuronas.s1);
                            s1ri= trapz(reshape(s1r,[f(1,1) f(1,2)]));
                            filt1=filtfilt(d1, s1ri);
                            t = length(neuronas.s1)/50000;
                            fsn = length(filt1)/t;
                            ti= 1/50000:1/50000:t;       
                            tii = 1/fsn:1/fsn:t;
                            neuronas.integrada1 = s1ri;
                            neuronas.filtrada_integrada1 =filt1;
                            neuronas.tiempo = ti;
                            neuronas.tiemporf =tii;
                            subplot(10,1,1);
                            plot(ti,neuronas.s1);
                            subplot(10,1,2);
                            plot(tii,filt1);
                    else
                        s1 = 0;
                    end
                    if Spikes2(1,1) > 0
                        neuronas.s2 = pegaSpikes(Spikes2,ceros,fs,spikes');
                        neuronas.s2(1) = [];
                        neuronas.s2(1) = [];
                        if rem(length(neuronas.s2),2) ~= 0
                                neuronas.s2(1) = [];
                        end
                        neuronas.s2 = awgn(neuronas.s2,30);
                        f= FACTS(length(neuronas.s2));
                        s2r = abs(neuronas.s2);
                        s2ri= trapz(reshape(s2r,[f(1,1) f(1,2)]));   
                        filt2=filtfilt(d1, s2ri);
                        neuronas.integrada2 = s2ri;
                        neuronas.filtrada_integrada2 =filt2;
                        subplot(10,1,3);
                        plot(ti,neuronas.s2);
                        subplot(10,1,4);
                        plot(tii,filt2);

                    else
                        s2 = 0;
                    end
                    if Spikes3(1,1) > 0
                        neuronas.s3 = pegaSpikes(Spikes3,ceros,fs,spikes');
                        neuronas.s3(1) = [];
                        neuronas.s3(1) = [];                        
                        if rem(length(neuronas.s3),2) ~= 0
                                neuronas.s3(1) = [];
                        end
                        neuronas.s3 = awgn(neuronas.s3,30);
                        f= FACTS(length(neuronas.s3));
                        s3r = abs(neuronas.s3);
                        s3ri= trapz(reshape(s3r,[f(1,1) f(1,2)]));
                        filt3=filtfilt(d1, s3ri);
                        neuronas.integrada3 = s3ri;
                        neuronas.filtrada_integrada3 =filt3;                    
                        subplot(10,1,5);
                        plot(ti,neuronas.s3);
                        subplot(10,1,6);
                        plot(tii,filt3);                    

                    else
                        s3 = 0;
                    end
                    if Spikes4(1,1) > 0
                        neuronas.s4 = pegaSpikes(Spikes4,ceros,fs,spikes');
                        neuronas.s4(1) = [];
                        neuronas.s4(1) = [];                          
                        if rem(length(neuronas.s4),2) ~= 0
                                neuronas.s4(1) = [];
                        end     
                        neuronas.s4 = awgn(neuronas.s4,30);
                        f= FACTS(length(neuronas.s4));
                        s4r = abs(neuronas.s4);
                        s4ri= trapz(reshape(s4r,[f(1,1) f(1,2)]));    
                        filt4=filtfilt(d1, s4ri);
                        neuronas.integrada4 = s4ri;
                        neuronas.filtrada_integrada4 =filt4;                    
                        subplot(10,1,7);
                        plot(ti,neuronas.s4);
                        subplot(10,1,8);
                        plot(tii,filt4); 
                    else
                        s4 = 0;
                    end
                   
                    rascado = arc(7:14);
                    rascado = strcat(rascado,'_rascado.txt');
                    path = strcat(path,'\');
                    
                    rascado = strcat(path,rascado);
                    %if opc ~= 'S' 
                    flexext = load(rascado);
                    %end
                    subplot(10,1,9);
                    plot(ti,flexext(1:length(neuronas.s1),1));
                    neuronas.extension = flexext(1:length(neuronas.s1),1);
                    subplot(10,1,10);
                    plot(ti,flexext(1:length(neuronas.s1),2)) ;   
                    neuronas.flexion = flexext(1:length(neuronas.s1),2);
                    %opc = 0;
                    %while opc ~= 'N' && opc ~= 'S'
                    %    opc = upper(input('Desea cambiar la frecuencia de corte S/N: ','s'));
                    %end
                    pause(5);
                    close all;
                    %end
                    %%%%%%%%
                    neuronas.extension = downsample(neuronas.extension,50);
                    neuronas.flexion = downsample(neuronas.flexion,50);
                    neuronas.td = downsample(ti,50);
                    fnamemetemp = strcat(arc(7:length(arc)-4),'_neuronas.mat');                    
                    fnamemetemp = strcat(path,fnamemetemp);                                                        
                    save(fnamemetemp,'neuronas');
                    clear neuronas;
                    clear ti;
                    clear tii;
                    clear ceros;
                    clear signal;
                    contador =contador+1;
                    clear arc;
                end

                end


