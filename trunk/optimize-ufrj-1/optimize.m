function optimize

%clear all;
clc;
format long;

fprintf(1,'\n OPTIMIZE\n\n');

% ------------ Entradas
eval_fun='fun';

method = input(' Escolha o método desejado: \n > 1 para Fibonacci \n > 2 para Razão Áurea \n > 3 para Interpolação Quadrática \n > 4 para Interpolação (Brent) \n > 5 para Enquadramento \n > ');

fun = input('\n\n Digite a função: \n f(x) = ','s');
assignin('base','fun',fun);

if method == 1
    
    fprintf(1,'\n\nMétodo escolhido: Fibonacci \n');    
    
    I1(1) = input(' > Digite o valor inferior do intervalo inicial: ');
    I1(2) = input(' > Digite o valor superior do intervalo inicial: ');
    nit = input(' > Digite o número de reduções desejadas: ');
    
    [I,cont_it] = fibonacci(eval_fun,I1,nit);
    
    fprintf(1,strcat('\n Intervalo Final=[',num2str(I(1)),';',num2str(I(2)),']'));
    fprintf(1,strcat('\n Número de Iterações=',num2str(cont_it),'\n\n'));    
    
    grafico(eval_fun,I1,I);
end

if method == 2
    
    fprintf(1,'\n\n Método escolhido: Razão Áurea \n');    
    
    I1(1) = input(' > Digite o valor inferior do intervalo inicial: ');
    I1(2) = input(' > Digite o valor superior do intervalo inicial: ');
    eps = input(' > Digite a tolerância para o critério de parada: ');
    
    [I,cont_it] = aurea(eval_fun,I1,eps);
    
    fprintf(1,strcat('\n Intervalo Final=[',num2str(I(1)),';',num2str(I(2)),']'));
    fprintf(1,strcat('\n Número de Iterações=',num2str(cont_it),'\n\n'));    
    
    grafico(eval_fun,I1,I);
end

if method == 3
    
    fprintf(1,'\n\n Método escolhido: Interpolação Quadrática \n');    
    
    I1(1) = input(' > Digite o valor inferior do intervalo inicial: ');
    I1(2) = input(' > Digite o valor superior do intervalo inicial: ');
    eps = input(' > Digite a tolerância para o critério de parada: ');
    
    [I,cont_it] = interpolacao(eval_fun,I1,eps);
    
    fprintf(1,strcat('\n Valor Mínimo= ',num2str(I)));
    fprintf(1,strcat('\n Número de Iterações=',num2str(cont_it),'\n\n'));
    
    grafico(eval_fun,I1,I);
end

if method == 4
    
    fprintf(1,'\n\n Método escolhido: Interpolação (Brent) \n');    
    
    I1(1) = input(' > Digite o valor inferior do intervalo inicial: ');
    I1(2) = input(' > Digite o valor superior do intervalo inicial: ');
    eps = input(' > Digite a tolerância para o critério de parada: ');
    
    [I,cont_it] = brent(eval_fun,I1,eps);
    
    fprintf(1,strcat('\n Valor Mínimo= ',num2str(I)));
    fprintf(1,strcat('\n Número de Iterações=',num2str(cont_it),'\n\n'));    
    
    grafico(eval_fun,I1,I);
end

if method == 5
    
    fprintf(1,'\n\n Método escolhido: Enquadramento \n');    
    
    %I1(1) = input(' > Digite o valor inferior do intervalo inicial: ');
    %I1(2) = input(' > Digite o valor superior do intervalo inicial: ');
    %eps = input(' > Digite a tolerância para o critério de parada: ');
    
    %[I,cont_it] = enquadramento(eval_fun,I1,eps);
    
    %fprintf(1,strcat('\n Valor Mínimo= ',num2str(I)));
    %fprintf(1,strcat('\n Número de Iterações=',num2str(cont_it),'\n\n'));    
end
