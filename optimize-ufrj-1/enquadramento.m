function  [I] = enquadramento(fun,po,passo)

exp = 1.618;

continua = 1;

x(1) = po;

f(1) = feval(fun,x(1));

x(2) = x(1) + passo;

f(2) = feval(fun,x(2));

if f(1) < f(2)
        
        a = x(1);        
        fa = f(1);        
        b = x(2);        
        fb = f(2);        
        x(1) = b;        
        f(1) = fb;        
        x(2) = a;        
        f(2) = fa;        
        passo = - passo;
    
end

while continua

    x(3) = x(2) + exp*passo;
    
    f(3) = feval(fun,x(3));
    
    if f(2) >= f(3)
        
        x(1) = x(2);    
        f(1) = f(2);        
        x(2) = x(3);        
        f(2) = f(3);
        
    else
        
        continua = 0;
        
    end
end

if x(1) < x(3)
    a = x(1);
    b = x(3);
else
    a = x(3);
    b = x(1);
end

I = [a b]';