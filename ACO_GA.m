clear; clc;

close all;
tic
G0=[0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0; 
   0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0; 
   0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0; 
   0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0; 
   0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0; 
   0 1 1 1 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0; 
   0 1 1 1 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0;
   0 1 1 1 0 0 1 1 1 0 1 1 1 1 0 0 0 0 0 0; 
   0 1 1 1 0 0 0 0 0 0 1 1 1 1 0 0 0 0 0 0; 
   0 0 0 0 0 0 0 0 0 0 1 1 1 1 0 0 0 0 0 0; 
   0 0 0 0 0 0 0 1 1 0 1 1 1 1 0 0 0 0 0 0; 
   0 0 0 0 0 0 0 1 1 0 1 1 1 1 0 0 0 0 0 0; 
   0 0 0 0 0 0 0 0 1 1 1 1  1 1 0 1 1 1 1 1; 
   0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 1 1 1 1 0; 
   1 1 1 1 0 0 0 0 0 0 0 0 1 1 0 1 1 1 1 0; 
   1 1 1 1 0 0 1 1 0 0 0 1 0 0 0 0 0 0 0 0; 
   0 0 0 0 0 0 1 1 0 1 1 1 0 0 0 0 0 1 1 0; 
   0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0; 
   0 0 1 1 0 0 0 0 0 0 1 1 0 0 1 0 0 0 0 0; 
   0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0;];

G=[0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0; 
   0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0; 
   0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0; 
   0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0; 
   0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0; 
   0 1 1 1 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0; 
   0 1 1 1 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0;
   0 1 1 1 0 0 1 1 1 0 1 1 1 1 0 0 0 0 0 0; 
   0 1 1 1 0 0 0 0 0 0 1 1 1 1 0 0 0 0 0 0; 
   0 0 0 0 0 0 0 0 0 0 1 1 1 1 0 0 0 0 0 0; 
   0 0 0 0 0 0 0 1 1 0 1 1 1 1 0 0 0 0 0 0; 
   0 0 0 0 0 0 0 1 1 0 1 1 1 1 0 0 0 0 0 0; 
   1 1 1 1 0 0 0 0 1 1 1 1 0 0 0 1 1 1 1 1;
   0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 1 1 1 1 0; 
   1 1 1 1 0 0 0 0 0 0 0 0 1 1 0 1 1 1 1 0; 
   1 1 1 1 0 0 1 1 0 0 0 1 0 0 0 0 0 0 0 0; 
   0 0 0 0 0 0 1 1 0 1 1 1 0 0 0 0 0 1 1 0; 
   0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0; 
   0 0 1 1 0 0 0 0 0 0 1 1 0 0 1 0 0 0 0 0; 
   0 0 0 1 1 1 0 0 0 0 1 1 0 0 0 0 0 0 0 0;];

%G=G0
n=size(G,1);
m=50;    
Alpha=2;  
Beta=6; 
Rho=0.1; 
NC_max=100;
Q=1;         
Tau=ones(n,n);    
NC=1;               
r_e=1;  c_e=20;
s=n;
position_e=n*(n-1)+1;
min_PL_NC_ant=inf;
min_ant=0;
min_NC=0;

z=1;
max_generation=200;
p_crossover=0.2;
p_mutation=0.05;
weight_length=20;
weight_smooth=1;
new_population={};
for i=1:n
    for j=1:n
        if G(i,j)==0 
            D(i,j)=((i-r_e)^2+(j-c_e)^2)^0.5;
        else
            D(i,j)=inf;     
        end
    end
end 
D(r_e,c_e)=0.05;
Eta=1./D;          
Tau=10.*Eta;

 D_move=zeros(n*n,8);
 for point=1:n*n
     if G(point)==0
         [r,c]=position2rc(point);
         move=1;
         for k=1:n
             for m1=1:n
                 im=abs(r-k);
                 jn=abs(c-m1); 
                 if im+jn==1||(im==1&&jn==1) 
                     if G(k,m1)==0
                         D_move(point,move)=(m1-1)*n+k;
                         move=move+1;
                     end
                 end
             end
         end
     end 
 end
routes=cell(NC_max,m);
PL=zeros(NC_max,m); 
while NC<=NC_max
    for ant=1:m
        current_position=s;
        path=s;
        PL_NC_ant=0;
        Tabu=ones(1,n*n);   
        Tabu(s)=0;
        D_D=D_move;
        D_work=D_D(current_position,:);
        nonzeros_D_work=find(D_work);
        for i1=1:length(nonzeros_D_work)
            if Tabu(D_work(i1))==0
                D_work(nonzeros_D_work(i1))=[];
                D_work=[D_work,zeros(1,8-length(D_work))];
            end
        end

        len_D_work=length(find(D_work));
        while current_position~=position_e&&len_D_work>=1
            p=zeros(1,len_D_work);
            for j1=1:len_D_work
                [r1,c1]=position2rc(D_work(j1));
                p(j1)=(Tau(r1,c1)^Alpha)*(Eta(r1,c1)^Beta);
            end
            p=p/sum(p);
            pcum=cumsum(p);
            select=find(pcum>=rand);
            to_visit=D_work(select(1));

            path=[path,to_visit];
            dis=distance(current_position,to_visit);
            PL_NC_ant=PL_NC_ant+dis;
            current_position=to_visit;
            D_work=D_D(current_position,:);
            Tabu(current_position)=0;
            for kk=1:400
                if Tabu(kk)==0
                    for i3=1:8
                        if D_work(i3)==kk
                           D_work(i3)=[];
                           D_work=[D_work,zeros(1,8-length(D_work))];
                        end
                    end
                end
            end
            len_D_work=length(find(D_work));
        end
        
        routes{NC,ant}=path;
        if path(end)==position_e
            PL(NC,ant)=PL_NC_ant;
            if PL_NC_ant<min_PL_NC_ant
                min_NC=NC;min_ant=ant;min_PL_NC_ant=PL_NC_ant;
            end
        else
            PL(NC,ant)=0;
        end
    end
    delta_Tau=zeros(n,n);
    for j3=1:m
        if PL(NC,ant)
            rout=routes{NC,ant};
            tiaoshu=length(rout)-1;
            value_PL=PL(NC,ant);
            for u=1:tiaoshu
                [r3,c3]=position2rc(rout(u+1));
                delta_Tau(r3,c3)=delta_Tau(r3,c3)+Q/value_PL;
            end
        end
    end
    Tau=(1-Rho).*Tau+delta_Tau;
    NC=NC+1;
end
z=1;
for NC=1:NC_max
    for i=1:m
        if PL(NC,m)
            new_population(z)=routes(NC,m);
            z=z+1
        end
    end
end
path_value=calculation_path_value(new_population);
[sort1,index]=sort(path_value);
new_population=new_population(index);
path_value=calculation_path_value(new_population);
smooth_value=calculation_smooth_value(new_population);
fit_value=(weight_length./path_value)+(weight_smooth./smooth_value);
mean_path_value=zeros(1,max_generation);
min_path_value=zeros(1,max_generation);
 for i=1:max_generation
    new_population_1=selection(new_population,fit_value);
    new_population_1=crossover(new_population_1,p_crossover);
    new_population_1=mutation(new_population_1,p_mutation,G,r);
    new_population_1=GenerateSmoothPath(new_population_1,G);  
    new_population=new_population_1;
    
    path_value=calculation_path_value(new_population);
    smooth_value=calculation_smooth_value(new_population);
    fit_value=(weight_length./path_value)+(weight_smooth./smooth_value);
    mean_path_value(i)=mean(path_value);
    [~,ma]=max(fit_value);
    min_path_value(i)=path_value(ma);
    min_path{i}=new_population(ma);
 end

 

min(min_path_value)
%legend('average length','optimal length');
[~,min_index]=min(min_path_value);
minmin_path=min_path{min_index};
minmin_path=minmin_path{1};

hold on;
title('ACOG PATH');
xlabel('X');
ylabel('Y');
for i=1:r
    for j=1:r
        if G(i,j)==1 
            x1=j-1;y1=r-i; 
            x2=j;y2=r-i; 
            x3=j;y3=r-i+1; 
            x4=j-1;y4=r-i+1; 
            fill([x1,x2,x3,x4],[y1,y2,y3,y4],'r'); 
            hold on 
        else 
            x1=j-1;y1=r-i; 
            x2=j;y2=r-i; 
            x3=j;y3=r-i+1; 
            x4=j-1;y4=r-i+1; 
            fill([x1,x2,x3,x4],[y1,y2,y3,y4],[1,1,1]); 
            hold on 
        end 
    end 
end 
hold on 

LENGTH_minmin_path=length(minmin_path);
RX=minmin_path;
RY=minmin_path;
for i=1:LENGTH_minmin_path
    RX(i)=ceil(minmin_path(i)/r)-0.5;
    RY(i)=r-mod(minmin_path(i),r)+0.5;
    if RY(i)==r+0.5
        RY(i)=0.5;
    end
end
hold on
plot(RX,RY,'ms-','LineWidth',1.5,'markersize',4);
plot(0.5,0.5,'ro','MarkerSize',4,'LineWidth',4);  
plot(19.5,19.5,'gs','MarkerSize',5,'LineWidth',5);  
 toc
 
    
    
    