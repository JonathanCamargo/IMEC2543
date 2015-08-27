clc
clear all
close all
%Sistema de 4 barras
 

r1=4.1;
r2=2.2;
r3=8.5;
r4x=0.7;
r4y=5.5;
theta1=deg2rad(165);
theta2=deg2rad(17);
x0=deg2rad([180;120]);
for theta=theta1:-0.1:theta2

  
syms x1 x2
%ecuacion a resolver
f1(x1,x2)=r1*cos(theta)+r2*cos(x1)-r3*cos(x2)+r4x;
f2(x1,x2)=r1*sin(theta)+r2*sin(x1)-r3*sin(x2)+r4y;

a=diff(f1,x1);
b=diff(f1,x2);
c=diff(f2,x1);
d=diff(f2,x2);
%jacobiano
J=[a b;c d];
%inversa del jacobiano sin ser evaluada 
invJ=J^-1;
%initial guess

MAXITER=10;
tol=1E-5;
iter=0;

while iter<MAXITER
    

    B1=subs(f1,x1,x0(1,1));
%primer numero del vector B evaluandolo en la funcion
    B2=double(subs(B1,x2,x0(2,1)));
    C1=subs(f2,x1,x0(1,1));
%segundo numero del vector B evaluandolo en la funcion
    C2=double(subs(C1,x2,x0(2,1)));
%vector representa evaluar el initial guess en f1 y f2, los valores en
%columnas B=[f1(x0);f2(x0)]
    B=[B2;C2];
    
%invA es la matriz jacobiana evaluada en el initial guess
    invA=double(invJ(x0(1,1),x0(2,1)));
%representa la ecuacion de Newton para 2-D
    xi=x0-invA*B;
    
    if((xi-x0)<tol)
        break
    end
    x0=xi;
    MAXITER=MAXITER-1;
    iter=iter+1;
    
end
%velocidad angular de entrada en radianes/segundo
we=-0.5;
% ecuacion matricial para hallar velocidades angulares. Vv es vector de
% velocidad angular
Vv=[r1*we*sin(theta);-r1*we*cos(theta)];
a1=-r2*sin(xi(1));
a2=r3*sin(xi(2));
a3=r2*cos(xi(1));
a4=-r3*cos(xi(2));
A=[a1 a2;a3 a4];
%velocidad angular de las barras 2 y 3
w=(A^-1)*Vv;
%vector posicion
r=r3*[cos(xi(2));sin(xi(2))];
%vector multiplicado por la direccion de la velocidad angular k (wxr)
rp=r3*[-sin(xi(2));cos(xi(2))];

%vector velocidad
vel=w(2)*rp;

%aceleracion angular de entrada
alfa=0;
% ecuacion matricial para hallar aceleraciones angulares. Wa es el vector de
% aceleracion angular
va1=r1*alfa*sin(theta)+r1*(we^2)*cos(theta)+r2*(w(1)^2)*cos(xi(1))-r3*(w(2)^2)*cos(xi(2));
va2=-r1*alfa*cos(theta)+r1*(we^2)*sin(theta)+r2*(w(1)^2)*sin(xi(1))-r3*(w(2)^2)*sin(xi(2));
 Wa=[va1;va2];

%matriz
b1=-r2*sin(xi(1));
b2=r3*sin(xi(2));
b3=r2*cos(xi(1));
b4=-r3*cos(xi(2));
Ac=[b1 b2;b3 b4];
%ac es el vector de aceleracion angular
ac=(Ac^-1)*Wa;
%la aceleracion angular
Va=ac(2)*rp;
%la aceleracion normal 
Wn=[w(1)^2*r2;w(2)^2*r3];
Vn=-Wn(2)*r;
%vector de aceleracion en cm/s^2
acel=Va+Vn;

P1=[0;0];
P2=[r1*cos(theta);r1*sin(theta)];

P3=P2+[r2*cos(xi(1));r2*sin(xi(1))];
 P4=[-r4x;-r4y];
plotbarra(P1,P2,P3,P4);
quiver(P3(1),P3(2),vel(1),vel(2))
hold on
quiver(P3(1),P3(2),acel(1),acel(2));
hold on
%aceleracion en naranja y velocidad en azul
hold off
axis([-9 9 -9 9]);

drawnow 

end










