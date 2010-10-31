function [I,cont_it] = brent(fun,I1,eps)

% ------------ Brent
a = I1(1);
b = I1(2);
c = 0.5*(3.0 - sqrt(5.0));

x = a + c*(b - a);
v = x;
w = x;
d = 0;
e = d;
 
[fa]=feval(fun,a);
[fb]=feval(fun,b);
[fx]=feval(fun,x);
[fv]=feval(fun,v);
[fw]=feval(fun,w);

cont_it = 0;

while (true)

    cont_it = cont_it + 1;    
        
    plot(cont_it,a,'r.');
    hold on
    plot(cont_it,b,'b.');
    plot(cont_it,x,'g.');
    
    m = 0.5*(a + b);

    tol = sqrt(eps)*abs(x) + eps;
    t2 = 2.0*tol;
    if (abs(x - m) <= t2 - 0.5*(b - a))
        break;
    else
        p = 0;
        q = 0;
        r = 0;

        if (abs(e) > tol)
            r = (x - w)*(fx - fv);
            q = (x - v)*(fx - fw);
            p = (x - v)*q - (x - w)*r;
            q = 2.0*(q - r);
            if (q > 0.0)
                p = -p;
            else
                q = -q;
            end
            r = e;
            e = d;
        end

        if (abs(p) < abs(0.5*q*r) && p < q*(a - x) && p < q*(b - x))
            d = p/q;
            u = x + d;
            if (u - a < t2 || b - u < t2)
                if (x < m)
                    d = tol;
                else
                    d = -tol;
                end
            end
        else
            if (x < m)
                e = b;
            else
                e = a;
            end
            e = e - x;
            d = c*e;
        end

        if (abs(d) >= tol)
            u = x + d;
        else
            if (d > 0.0)
                u = x + tol;
            else
                u = x - tol;
            end
        end
        [fu]=feval(fun,u);
        if (fu <= fx)
            if (u < x)
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
            if (u < x)
                a = u;
            else
                b = u;
            end
            if (fu <= fw || w == x)
                v = w;
                fv = fw;
                w = u;
                fw = fu;
            else if (fu <= fv || v == x || v == w)
                    v = u;
                    fv = fu;
                end
            end
        end
    end
end

I = [x]';

legend('A','B','X');
title(strcat('I = [',num2str(I),']  -  Núm Iterações = ',num2str(cont_it)));
xlabel('Iteração');
ylabel('x');
