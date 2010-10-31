function [I,cont_it] = interpolacao(fun,I1,eps)

x(1) = I1(1);
x(3) = I1(2);
x(2) = 0.5*(x(1) + x(3));

[f(1)]=feval(fun,x(1));
[f(3)]=feval(fun,x(3));
[f(2)]=feval(fun,x(2));

cont_it = 0;

xmin = 0.5*((((x(2)^2 - x(3)^2)*f(1)) + ((x(3)^2 - x(1)^2)*f(2)) + ((x(1)^2 - x(2)^2)*f(3)))/(((x(2) - x(3))*f(1)) + ((x(3) - x(1))*f(2)) + ((x(1) - x(2))*f(3))));
[fmin]=feval(fun,xmin);

while ((abs(xmin - x(1)) > eps) &&  (abs(xmin - x(2)) > eps) && (abs(xmin - x(3)) > eps))
    
    cont_it = cont_it + 1;
    
    plot(cont_it,x(1),'r.');
    hold on
    plot(cont_it,x(2),'b.');
    plot(cont_it,x(3),'g.');
      
    if  (x(3) - xmin)*(xmin - x(2)) > 0
        k = 1;
    else
        k = 3;
    end
    
    if (fmin < f(2))
       x(k) = x(2); 
       f(k) = f(2);
       k = 2; 
    end
    
    x(4-k) = xmin;
    f(4-k) = fmin;
    [f(1)]=feval(fun,x(1));
    [f(3)]=feval(fun,x(3));
    [f(2)]=feval(fun,x(2));
xmin = 0.5*((((x(2)^2 - x(3)^2)*f(1)) + ((x(3)^2 - x(1)^2)*f(2)) + ((x(1)^2 - x(2)^2)*f(3)))/(((x(2) - x(3))*f(1)) + ((x(3) - x(1))*f(2)) + ((x(1) - x(2))*f(3))));
    [fmin]=feval(fun,xmin);
   
end

X = [ abs(xmin - x(1)); abs(xmin - x(2)); abs(xmin - x(3))]; 
xminimo = min(X, [], 1) + xmin;

I = xminimo;

legend('A','B','C');
title(strcat('Valor Mínimo = [',num2str(I),']  -  Núm Iterações = ',num2str(cont_it)));
xlabel('Iteração');
ylabel('x');