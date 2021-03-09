%Matric Number 17149675

a1=25;
a2=15;
d1=30;

L(1)=Link([0,d1,a1,0,0],'standard');
L(2)=Link([0,0,a2,pi,0],'standard');
L(3)=Link([0,0,0,0,1],'standard');
L(3).qlim=[0 30];
Rob=SerialLink(L,'name','SCARA');

%path_data_points
%theta=0:60:360;
%x=35*cosd(theta);
%y=35*sind(theta);
%z=[30,20,10,0,10,20,30];
input_data=readmatrix('data.xlsx',"Range",'B24:H26');
x=input_data(1,:);
y=input_data(2,:);
z=input_data(3,:);

%z_discrete
f=figure(1);
plot(x,y,'-b','LineWidth',2);
T=transl(x(1),y(1),0);
q=Rob.ikine(T,'q0',[-0.4 0.7 30],'mask',[1 1 1 0 0 0]);
for i=1:(length(x))
    T=transl(x(i),y(i),0);
    q(i,:)=Rob.ikine(T,'q0',[-0.4 0.7 30],'mask',[1 1 1 0 0 0]);
end
for i=1:(length(x))
    qs=q(i,:);
    Q1(i)=fkine(Rob,qs);
    Rob.plot(qs,'workspace',[-100 100 -100 100 -100 100]);
    pause(0.5);
end
clf(f)
%z_varied_continuously
plot3(x,y,z,'-r','LineWidth',2);
for i=1:(length(x))
    T=transl(x(i),y(i),z(i));
    q(i,:)=Rob.ikine(T,'q0',[-0.4 0.7 30],'mask',[1 1 1 0 0 0]);
end
for i=1:(length(x))
    qs=q(i,:);
    Q2(i)=fkine(Rob,qs);
    Rob.plot(qs,'workspace',[-100 100 -100 100 -100 100]);
    pause(0.5);
end
