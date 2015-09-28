clear all
clc

r1=25;
r2=200;
r3=100;
r4=200;

x=sym('x');
y=sym('y');
theta=sym('theta');

fx = symfun(r1*cos(theta)+r2*cos(x)+r3*cos(y)-r4,[theta,x,y]);
fy = symfun (r1*sin(theta)+r2*sin(x)+r3*sin(y),[theta,x,y]);

e=0.01;
t=1;
x0=[0.123123;pi*5/3];
x1=[pi;pi];

j1(x,y)=(jacobian([fx,fy],[x,y]));
vf(x,y)=[fx(theta,x,y);fy(theta,x,y)];

a(x,y)=inv(j1(x,y))*vf(x,y);

%% estas podrian ser las lineas que permiten modificar colores y tipo de marcador

%i=0;
marcadores = {'k+-','bo-','g*-','yx-','rs-','k^-','bv-','g>-','y<-','r.-','ks-','bd-','g^-','y>-','r<-','kp-'};


for theta_ = 0:0.1:2*pi
    
    while t>e
        
        temp=subs(a,{x,y,theta},{x0(1),x0(2),theta_});
        c=double(subs(a,{x,y,theta},{x0(1),x0(2),theta_}));
                
        j=transpose(c);
        x1=x0-j;
        t=abs(norm(x1-x0)/norm(x1));
        x0;
        x1;
        x0=x1; 
    end
   t=e*1.1; %Este fue el error más grave porque cuando pasas a otro theta la tolerancia ya quedó bien entonces nunca vuelve a entrar al while.
    
   x0
    
   x1=0;
   x2=r1*cos(theta_);
   x3=x2+r2*cos(x0(1));
   x4=x3+r3*cos(x0(2));
   %x4
   
   y1=0;
   y2=r1*sin(theta_);
   y3=r1*sin(theta_)+r2*sin(x0(1));
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
   
   



    
    
   
