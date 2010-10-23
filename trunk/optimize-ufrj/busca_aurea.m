function [passo,cont_it_lin] = busca_aurea(d_descida,x,eps,max_it)

x0 = x;
xa = x;
xd = x + 1 * d_descida;
xc = (((xd)-xa)*((-1+sqrt(5))/2)+xa);
xb = xd-(xc-xa);

fa = avaliafun(xa);
fd = avaliafun(xd);
fc = avaliafun(xc);
fb = avaliafun(xb);

intervalo = norm(xd - xa);

cont_it_lin = 0;

while any(intervalo > eps)
    
    if ( max_it > 0 ) && ( max_it <= cont_it_lin )     
        break;
    end
    
    cont_it_lin = cont_it_lin + 1;
   
    if  fb > fc
        xa = xb;
        fa = fb;
        xb = xc;
        fb = fc;

        xc = xa + xd - xb;
        fc = avaliafun(xc);
    else
        xd = xc;
        fd = fc;
        xc = xb;
        fc = fb;

        xb = xd + xa - xc;
        fb = avaliafun(xb);
    end

    intervalo = norm(xd - xa);    
end

passo = norm(xb - x0)/norm(d_descida);
