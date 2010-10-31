function [I,cont_it] = fibonacci(fun,I1,nit)

% ------------ Fibonacci        A---------B-----C---------D
k = nit+1;
p = (1-sqrt(5))/(1+sqrt(5));
alpha = (2/(1+sqrt(5)))*(1-p^k)/(1-p^(k+1));

a = I1(1);
b = I1(2);

for cont_it = 1 : nit
    
    x1 = a;
    x4 = b;
    Lini = a - b;
    x2 = alpha*x1 + (1-alpha)*x4;
    x3 = alpha*x4 + (1-alpha)*x1;

    [f1]=feval(fun,x1);
    [f4]=feval(fun,x4);
    [f2]=feval(fun,x2);
    [f3]=feval(fun,x3);
      
    plot(cont_it,x1,'r.');
    hold on
    plot(cont_it,x2,'b.');
    plot(cont_it,x3,'g.');
    plot(cont_it,x4,'k.');
    
    if  f2 < f3
        
        a = x1;   
        b = x3;
        Lfin = a - b;
        
        alpha = (Lini - Lfin)/(Lfin);
 
    else
        a = x2;   
        b = x4;
        Lfin = a - b;
    end

end

I = [x1 x4]';

legend('x1','x2','x3','x4');
title(strcat('I = [',num2str(I(1)),';',num2str(I(2)),']  -  Núm Iterações = ',num2str(cont_it)));
xlabel('Iteração');
ylabel('x');
