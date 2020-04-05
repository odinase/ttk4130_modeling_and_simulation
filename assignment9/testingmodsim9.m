

B.A=[1/4 1/4-sqrt(3)/6;
    1/4+sqrt(3)/6 1/4];
B.c=[1/2-sqrt(3)/6; 1/2+sqrt(3)/6];
B.b=[1/2 1/2];
lambda=-2000;
f=@(t,x) lambda*x;
dfdx=@(t,x) lambda;
T=0:0.4:2;
x0=1;

x=IRKTemplate1(B, f, dfdx, T, x0);

hold on
plot(T,x);
plot(T,exp(lambda*T),'--r');
hold off
