function [signalir,filt,ti,flexri,extensiri] = RectInt(signal,downfs,fs,fc,flex,ext)
    close all;
    fs = fs*1000;
    t =  length(signal)/fs;
    if downfs > 0
        signal = downsample(signal,downfs);
        flexi = downsample(flex,downfs);
        extensi = downsample(ext,downfs);
    end
    if   rem(length(signal),2) ~= 0
        signal(1,:)=[];
        flexi(:,1)=[]; 
        extensi(:,1)=[]; 
    end
    fs = length(signal)/t;
    fact = FACTS(length(signal));
    signalr = abs(signal);
    flexi =  abs(flexi);
    extensi = abs(extensi);
    signalir = trapz(reshape(signalr,[fact(1,1),fact(1,2)]));    
    flexri = trapz(reshape(flexi,[fact(1,1),fact(1,2)]));    
    extensiri = trapz(reshape(extensi,[fact(1,1),fact(1,2)]));
    fsn = length(signalir)/t;
    op =  0;
    d1 = designfilt('lowpassiir','FilterOrder',8, ...
         'PassbandFrequency',fc,'PassbandRipple',0.2, ...
         'SampleRate',200e3);
    filt=filtfilt(d1, signalir);
    ti = 1/fsn:1/fsn:t;
    tii = 1/fs:1/fs:t;
    
end