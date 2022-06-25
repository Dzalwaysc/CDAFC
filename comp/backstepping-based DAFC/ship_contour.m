function [xx yy]=ship_contour(ship,L,B,L01)
%ship:船舶运动学和动力学数据，6维向量
%L:船长，m
%B:船宽，m
%L01：船艏到船重心的距离，m
x=ship(1,1);
y=ship(2,1);
phi=ship(3,1);

rho=sqrt((L-L01)^2+(B/2)^2);
theta=atan2(B/2,L-L01);
x1=x+L01*cos(phi);
y1=y+L01*sin(phi);
x2=x+rho*cos(phi+theta);
y2=y+rho*sin(phi+theta);
x3=x+rho*cos(phi-theta);
y3=y+rho*sin(phi-theta);
x4=x+rho*cos(phi-(pi+theta));
y4=y+rho*sin(phi-(pi+theta));
x5=x+rho*cos(phi-(pi-theta));
y5=y+rho*sin(phi-(pi-theta));
xx=[x1 x3 x5 x4 x2 x1];
yy=[y1 y3 y5 y4 y2 y1];
end