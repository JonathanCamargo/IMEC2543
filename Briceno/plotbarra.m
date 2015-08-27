function [ output_args ] = plotbarra( P1,P2,P3,P4)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

%dibujar barras

plot([P1(1);P2(1)],[P1(2);P2(2)])

hold on;
plot([P2(1);P3(1)],[P2(2);P3(2)])
plot([P3(1);P4(1)],[P3(2);P4(2)])

hold on



%dibujar puntos
plot(P1(1),P1(2),'o')
plot(P2(1),P2(2),'o')
plot(P3(1),P3(2),'o')
plot(P4(1),P4(2),'o')


end
