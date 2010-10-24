function [passo,cont_it_lin] = busca_brent(d_descida,x,eps,max_it)

% ------------ Brent
a = x;
b = x + 1 * d_descida;
c = 0.5*(3.0 - sqrt(5.0));

x = a + c*(b - a);
v = x;
w = x;
d = zeros(length(x),1);
e = d;

[fa]=avaliafun(a);
[fb]=avaliafun(b);
[fx]=avaliafun(x);
[fv]=avaliafun(v);
[fw]=avaliafun(w);

intervalo = norm(b - a);

cont_it_lin = 0;

while any(intervalo > eps)

    if ( max_it > 0 ) && ( max_it <= cont_it_lin )
        break;
    end

    cont_it_lin = cont_it_lin + 1;

    m = 0.5*(a + b);

    tol = sqrt(eps)*norm(x) + eps;
    t2 = 2.0*tol;

    p = 0;
    q = 0;
    r = 0;

    if (norm(e) > tol)
        r = (x - w)*(fx - fv);
        q = (x - v)*(fx - fw);
        p = (x - v)'*q - (x - w)'*r;
        q = 2.0*(q - r);
        if (q > 0.0)
            p = -p;
        else
            q = -q;
        end
        r = e;
        e = d;
    end

    if (norm(p) < norm(0.5*q'*r) && norm(p) < norm(q'*(a - x)) && norm(p) < norm(q'*(b - x)))
        d = p/norm(q)*ones(length(x),1);
        u = x + d;
        if (norm(u - a) < t2 || norm(b - u) < t2)
            if (norm(x) < norm(m))
                d = tol;
            else
                d = -tol;
            end
        end
    else
        if (norm(x) < norm(m))
            e = b;
        else
            e = a;
        end
        e = e - x;
        d = c*e;
    end

    if (norm(d) >= tol)
        u = x + d;
    else
        if (norm(d) > 0.0)
            u = x + tol;
        else
            u = x - tol;
        end
    end
    [fu]=avaliafun(u);
    if (fu <= fx)
        if (norm(u) < norm(x))
            b = x;
        else
            a = x;
        end
        v = w;
        fv = fw;
        w = x;
        fw = fx;
        x = u;
        fx = fu;
    else
        if (norm(u) < norm(x))
            a = u;
        else
            b = u;
        end
        if (fu <= fw || norm(w) == norm(x))
            v = w;
            fv = fw;
            w = u;
            fw = fu;
        else if (fu <= fv || norm(v) == norm(x) || norm(v) == norm(w))
                v = u;
                fv = fu;
            end
        end
    end

    intervalo = norm(b - a);
end

passo = norm(x)/norm(d_descida);