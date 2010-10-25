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

zmin = 0.5*((((z(2)^2 - z(3)^2)*f(1)) + ((z(3)^2 - z(1)^2)*f(2)) + ((z(1)^2 - z(2)^2)*f(3)))/(((z(2) - z(3))*f(1)) + ((z(3) - z(1))*f(2)) + ((z(1) - z(2))*f(3))));

[fmin] = avaliafun(x0 + zmin * d_descida);

erro = [abs(z(1)-zmin); abs(z(2)-zmin); abs(z(3)-zmin)];

[intervalo, indice] = min(erro, [], 1);

xcont_it_lin = 0;

while any(intervalo > eps)

    if ( max_it > 0 ) && ( max_it <= xcont_it_lin )
        break;
    end

    xcont_it_lin = xcont_it_lin + 1;

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
    xb = x0 + z(2) * d_descida;
    xc = x0 + z(3) * d_descida;
    
    [f(1)]= avaliafun(xa);
    [f(2)]= avaliafun(xb);
    [f(3)]= avaliafun(xc);    
    
    zmin = 0.5*((((z(2)^2 - z(3)^2)*f(1)) + ((z(3)^2 - z(1)^2)*f(2)) + ((z(1)^2 - z(2)^2)*f(3)))/(((z(2) - z(3))*f(1)) + ((z(3) - z(1))*f(2)) + ((z(1) - z(2))*f(3))));
   
    [fmin] = avaliafun(x0 + zmin * d_descida);
   
    erro = [abs(z(1)-zmin); abs(z(2)-zmin); abs(z(3)-zmin)];
    [intervalo, indice] = min(erro, [], 1);

end
passo = z(indice); 