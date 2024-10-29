function  fac = FACTS(x)
    N=x;
    K=1:N;
    facs = K(rem (N,K)==0);
    facs1 = facs(1:length(facs)/2)';
    facs1=sort(facs1,'descend');
    facs2 = facs((length(facs)/2)+1:length(facs))';
    fac(:,1) = facs1;
    fac(:,2) = facs2;
    
end
