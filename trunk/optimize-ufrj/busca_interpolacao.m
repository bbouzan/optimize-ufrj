function [passo,xcont_it_lin] = busca_interpolacao(d_descida,x,eps,max_it)

% ------------ Interpolacao Quadratica
x0 = x;

z(1) = 0;
xa = x0 + z(1)*d_descida;

z(3) = 1;
xc = x0 + z(3) * d_descida;

z(2) = (z(1) + z(3))/2;
xb = x0 + z(2) * d_descida;

[f(1)]= avaliafun(xa);
    
[f(2)]= avaliafun(xb);
    
[f(3)]= avaliafun(xc);

intervalo = norm(xc - xa);

xcont_it_lin = 0;

while any(intervalo > eps)

    if ( max_it > 0 ) && ( max_it <= xcont_it_lin )
        break;
    end

    xcont_it_lin = xcont_it_lin + 1;

    zmin = 0.5*((((z(2)^2 - z(3)^2)*f(1)) + ((z(3)^2 - z(1)^2)*f(2)) + ((z(1)^2 - z(2)^2)*f(3)))/(((z(2) - z(3))*f(1)) + ((z(3) - z(1))*f(2)) + ((z(1) - z(2))*f(3))));
    
    [fmin] = avaliafun(x0 + zmin * d_descida);

    if  (z(3) - zmin)*(zmin - z(2)) > 0
        k = 1;
    else
        k = 3;
    end
    
    if (fmin < f(2))
       z(k) = z(2); 
       f(k) = f(2);
       k = 2; 
    end
    
    z(4-k) = zmin;
    f(4-k) = fmin;
    
    xa = x0 + z(1) * d_descida;
    xc = x0 + z(3) * d_descida;
    xb = x0 + z(2) * d_descida;
    
    [f(1)]= avaliafun(xa);
    [f(3)]= avaliafun(xc);
    [f(2)]= avaliafun(xb);

    intervalo = norm(xc - xa);
end

passo = norm(z(2));%norm(xb - x0)/norm(d_descida);