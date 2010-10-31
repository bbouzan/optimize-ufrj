function [I,cont_it] = aurea(fun,I1,eps)

% ------------ Razao Áurea        A---------B-----C---------D
xa = I1(1);
xd = I1(2);
xc = (((xd)-xa)*((-1+sqrt(5))/2)+xa);
xb = xd-(xc-xa);

[fa]=feval(fun,xa);
[fd]=feval(fun,xd);
[fc]=feval(fun,xc);
[fb]=feval(fun,xb);

intervalo = xd - xa;

cont_it = 0;

while (intervalo > eps)
    
    cont_it = cont_it + 1;
    
    plot(cont_it,xa,'r.');
    hold on
    plot(cont_it,xb,'b.');
    plot(cont_it,xc,'g.');
    plot(cont_it,xd,'k.');
    
    if  fb > fc
        xa = xb;
        fa = fb;
        xb = xc;
        fb = fc;
        % D nao muda
        xc = xa + xd - xb;
        [fc]=feval(fun,xc);
    else
        xd = xc;
        fd = fc;
        xc = xb;
        fc = fb;
        % A nao muda
        xb = xd + xa - xc;
        [fb]=feval(fun,xb);
    end

    intervalo = norm(xd - xa);    
end

I = [xa xd]';

legend('A','B','C','D');
title(strcat('I = [',num2str(I(1)),';',num2str(I(2)),']  -  Núm Iterações = ',num2str(cont_it)));
xlabel('Iteração');
ylabel('x');
