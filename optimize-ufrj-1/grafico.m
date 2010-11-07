function grafico(eval_fun,I1,I)

figure

plot(min(I1),feval(eval_fun , min(I1)),'k*','MarkerSize',8);

hold on; 
            
plot(max(I1),feval(eval_fun , max(I1)),'k*','MarkerSize',8);
            
plot(min(I),feval(eval_fun , min(I)),'r*','MarkerSize',8);
            
plot(max(I),feval(eval_fun , max(I)),'r*','MarkerSize',8);

scale = axis;

if length(I) == 2
    ezplot(evalin('base','fun'),[min(I) max(I)]);
    h=get(gca,'children');
    set(h(1),'Color','red');
    set(h(1),'LineWidth',3);
end

ezplot(evalin('base','fun'),scale(1:2));

xlabel('x');
ylabel('y');