function [passo,cont_it_lin] = busca_fibonacci(d_descida,x,nit,max_it)

% ------------ Fibonacci      A---------B-----C---------D

x0 = x;

k = nit+1;
p = (1-sqrt(5))/(1+sqrt(5));
alpha = (2/(1+sqrt(5)))*(1-p^k)/(1-p^(k+1));

a = x;
b = x + 1 * d_descida;

for cont_it = 1 : nit
    
    if ( max_it > 0 ) && ( max_it <= cont_it )     
        break;
    end
    
    x1 = a;
    x4 = b;
    Lini = norm(a - b);
    x2 = alpha*x1 + (1-alpha)*x4;
    x3 = alpha*x4 + (1-alpha)*x1;
    
    [f1]=avaliafun(x1);
    [f4]=avaliafun(x4);
    [f2]=avaliafun(x2);
    [f3]=avaliafun(x3);
        
    if  f2 < f3
        
        a = x1;   
        b = x3;
        Lfin = norm(a - b);
        
        alpha = (Lini - Lfin)/(Lfin);
 
    else
        a = x2;   
        b = x4;
        Lfin = norm(a - b);
    end

end

cont_it_lin = cont_it;

passo = norm(x2 - x0)/norm(d_descida);