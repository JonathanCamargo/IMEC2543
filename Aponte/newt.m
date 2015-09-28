clear all
clc

r1=25;
r2=200;
r3=100;
r4=200;
tetha=0;

x=sym('x');
y=sym('y');

fx = symfun(r1*cos(tetha)+r2*cos(x)+r3*cos(y)-r4,[x,y]);
fy = symfun (r1*sin(tetha)+r2*sin(x)+r3*sin(y),[x,y]);

e=0.01;
t=1;
x0=[0.123123;pi*5/3];
x1=[pi;pi];

j1(x,y)=(jacobian([fx,fy],[x,y]));
vf(x,y)=[fx(x,y);fy(x,y)];

a(x,y)=inv(j1(x,y))*vf(x,y);

%% estas podrian ser las lineas que permiten modificar colores y tipo de marcador

%i=0;
marcadores = {'k+-','bo-','g*-','yx-','rs-','k^-','bv-','g>-','y<-','r.-','ks-','bd-','g^-','y>-','r<-','kp-'};


for tetha = 1.5
    
    while t>e
    
        temp=subs(a,{x,y},{x0(1),x0(2)});
        c=double(subs(a,{x,y},{x0(1),x0(2)}));
        
        j=transpose(c);
        x1=x0-j;
        t=abs(norm(x1-x0)/norm(x1));
        x0
        x1
        x0=x1; 
    end
    
   x0
    
   x1=0;
   x2=r1*cos(tetha);
   x3=x2+r2*cos(x0(1));
   x4=x3+r3*cos(x0(2));
   %x4
   
   y1=0;
   y2=r1*sin(tetha);
   y3=r1*sin(tetha)+r2*sin(x0(1));
   y4=y3+r3*sin(x0(2));
   %y4=0;
    
   r1=norm([(x2-x1),(y2-y1)])

   r2=norm([(x3-x2),(y3-y2)])
   r3=norm([(x4-x3),(y4-y3)])
   r4=norm([(x1-x4),(y1-y4)])
   
%% no estaba seguro de que quieres graficar pero esto puede ser una aproximación, pondria marcador y color diferente a cada iteracion, 
   figure (1)
   setX=[x1,x2,x3,x4,x1];
   setY=[y1,y2,y3,y4,y1];
   
   plot(setX,setY,'ro-')
   %plot(setX,setY,marcadores{1+mod(i,length(marcadores)-1) });
   xlim ([-500,500]);
   ylim ([-500,500]);
   %hold on
   pause(0.5);
   %i=(i+1); 
%% dibujar trayectoria
%  :)   
end 
   
   



    
    
   
