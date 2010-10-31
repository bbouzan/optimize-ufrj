function optimize

clear all;
clc;
format long;

fprintf(1,'\n OPTIMIZE \n\n');

% ------------ Entradas
fun='fun';

method = input('> Escolha o m�todo de otimiza��o: \n > 1 para Fibonacci \n > 2 para Raz�o �urea \n > 3 para Interpola��o Quadr�tica \n > 4 para Interpola��o (Brent) \n > ');

if method == 1
    
    fprintf(1,'\n\n M�todo escolhido: Fibonacci \n');    
    
    I1(1) = input('> Digite o valor inferior do intervalo inicial: ');
    I1(2) = input('> Digite o valor superior do intervalo inicial: ');
    nit = input('> Digite o n�mero de redu��es desejadas: ');
    
    [I,cont_it] = fibonacci(fun,I1,nit);
    
    fprintf(1,strcat('\n Intervalo Final=[',num2str(I(1)),';',num2str(I(2)),']'));
    fprintf(1,strcat('\n N�mero de Itera��es=',num2str(cont_it),'\n\n'));    

end

if method == 2
    
    fprintf(1,'\n\n M�todo escolhido: Raz�o �urea \n');    
    
    I1(1) = input('> Digite o valor inferior do intervalo inicial: ');
    I1(2) = input('> Digite o valor superior do intervalo inicial: ');
    eps = input('> Digite a toler�ncia para o crit�rio de parada: ');
    
    [I,cont_it] = aurea(fun,I1,eps);
    
    fprintf(1,strcat('\n Intervalo Final=[',num2str(I(1)),';',num2str(I(2)),']'));
    fprintf(1,strcat('\n N�mero de Itera��es=',num2str(cont_it),'\n\n'));    
end

if method == 3
    
    fprintf(1,'\n\n M�todo escolhido: Interpola��o Quadr�tica \n');    
    
    I1(1) = input('> Digite o valor inferior do intervalo inicial: ');
    I1(2) = input('> Digite o valor superior do intervalo inicial: ');
    eps = input('> Digite a toler�ncia para o crit�rio de parada: ');
    
    [I,cont_it] = interpolacao(fun,I1,eps);
    
    fprintf(1,strcat('\n Valor M�nimo= ',num2str(I)));
    fprintf(1,strcat('\n N�mero de Itera��es=',num2str(cont_it),'\n\n'));
end
if method == 4
    
    fprintf(1,'\n\n M�todo escolhido: Interpola��o (Brent) \n');    
    
    I1(1) = input('> Digite o valor inferior do intervalo inicial: ');
    I1(2) = input('> Digite o valor superior do intervalo inicial: ');
    eps = input('> Digite a toler�ncia para o crit�rio de parada: ');
    
    [I,cont_it] = brent(fun,I1,eps);
    
    fprintf(1,strcat('\n Valor M�nimo= ',num2str(I)));
    fprintf(1,strcat('\n N�mero de Itera��es=',num2str(cont_it),'\n\n'));    
end
