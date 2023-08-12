%opts = detectImportOptions('housing.csv');
%varNames = opts.VariableNames ;
%varTypes = {'double','double','double'...
 %   'double','double','double'...
  %  'double','double','double','categorical'}; 
%opts = setvartype(opts,varNames,varTypes); 
M= readmatrix('housing.csv');
long = M(:,1);
lat = M(:,2);
age =M(:,3);
room = M(:,4);
bed = M(:,5);
pop = M(:,6);
houses = M(:,7);
income = M(:,8);
value = M(:,9);
ocean = M(:,10);
%M = table2array(long,lat,age,room,bed,pop,houses,income,value);
%M2S = table2array(ocean);
%M=readmatrix("housing");
%A= ismissing(M);%to check if there are missing values


%mean_long = mean(long);
%long = fillmissing(long,"constant",mean_long);%if there are blanks
long = rescale(long); %rescaling to [0,1]


%mean_lat = mean(lat);
%lat = fillmissing(lat,"constant",mean_lat);
lat = rescale(lat);


%mean_age= mean(age);
%age = fillmissing(age,"constant",mean_age);
age = rescale(age);


%mean_room = mean(room);
%room = fillmissing(room,"constant",mean_room);
room= rescale(room);


mean_bed = nanmean(bed);
bed = fillmissing(bed,"constant",mean_bed);
bed = rescale(bed);


%mean_pop= mean(pop);
%pop = fillmissing(pop,"constant",mean_pop);
pop = rescale(pop);


%mean_houses = mean(houses);
%houses = fillmissing(houses,"constant",mean_houses);
houses = rescale(houses);


%mean_in = mean(income);
%income = fillmissing(income,"constant",mean_in);
income = rescale(income);


value = rescale(value);
%B = ismissing([long,lat,age,room,bed,pop,houses,income]);


%valueset= ['INLAND' 'NEAR BAY' '<1H OCEAN' 'ISLAND' 'NEAR OCEAN'];
%ocean = categorical(ocean,valueset);
%prox_ocean = onehotencode(ocean,'ClassNames',valueset);%one hot encoding


figure('Name','Location')
hold on
plot(long,'*b','LineWidth',1.6);
plot(lat,'*g','LineWidth',1.6);
legend('longitude','latitude')
grid on
hold off
figure('Name','House details')
hold on
plot(age,'*b','LineWidth',1.6);
plot(room,'*y','LineWidth',1.6);
plot(bed,'*c','LineWidth',1.6);
plot(houses,'*m','LineWidth',1.6);
legend('house age','total rooms','total bedrooms','households')
grid on
hold off
figure('Name','Area')
hold on
plot(pop,'*g','LineWidth',1.6);

plot(income,'*c','LineWidth',1.6);
plot(value,'*m','LineWidth',1.6);
plot(ocean,'*b','LineWidth',1.6);
legend('population','income','median house value','ocean proximity')
grid on
hold off


%istogrammata
edges= 0:0.03:1;
figure('Name','pdf1')
h1 = histogram(long,edges,'Normalization','probability');
xlabel('longtitude rescaled','FontSize',11);
ylabel('Probability','FontSize',11);

figure('Name','pdf2')
h2 = histogram(lat,edges,'Normalization','probability');
xlabel('lattitude rescaled','FontSize',11);
ylabel('Probability','FontSize',11);

figure('Name','pdf3')
h3 = histogram(age,edges,'Normalization','probability');
xlabel('house rescaled','FontSize',11);
ylabel('Probability','FontSize',11);

figure('Name','pdf4')
h4 = histogram(room,edges,'Normalization','probability');
xlabel('total rooms rescaled','FontSize',11);
ylabel('Probability','FontSize',11);

figure('Name','pdf5')
h5 = histogram(bed,edges,'Normalization','probability');
xlabel('total beds rescaled','FontSize',11);
ylabel('Probability','FontSize',11);

figure('Name','pdf6')
h6 = histogram(pop,edges,'Normalization','probability');
xlabel('population rescaled','FontSize',11);
ylabel('Probability','FontSize',11);

figure('Name','pdf7')
h7 = histogram(houses,edges,'Normalization','probability');
xlabel('households rescaled','FontSize',11);
ylabel('Probability','FontSize',11);

figure('Name','pdf8')
h8 = histogram(income,edges,'Normalization','probability');
xlabel('medean income rescaled','FontSize',11);
ylabel('Probability','FontSize',11);

figure('Name','pdf9')
h9 = histogram(ocean,edges,'Normalization','probability');
xlabel('ocean proximity rescaled','FontSize',11);
ylabel('Probability','FontSize',11);

hi1 = histcounts(long,edges);
hi2 = histcounts(lat,edges);
figure('Name','Histograms')
bar(edges(1:end-1),[hi1;hi2],1.8)
xlabel('longtitude and latitude','FontSize',11);
ylabel('count','FontSize',11);
legend({'Longitude','Latitude'});
title('longtitude compared to latitude','FontSize',11);

hi3 = histcounts(age,edges);
hi4 = histcounts(room,edges);
hi5 = histcounts(bed,edges);
figure('Name','Histograms2');
bar(edges(1:end-1),[hi3;hi4;hi5],0.8);
xlabel('age,rooms, beds ','FontSize',11);
ylabel('count','FontSize',11);
legend({'age','room','bed'});

hi6 = histcounts(pop,edges);
hi7 = histcounts(houses,edges);
figure('Name','Histograms3');
bar(edges(1:end-1),[hi6;hi7],0.8);
xlabel('population,value,income','FontSize',11);
ylabel('count','FontSize',11);
legend({'pop','houses'});

hi10 = histcounts(value,edges);
hi8 = histcounts(income,edges);
figure('Name','Histograms4');
bar(edges(1:end-1),[hi10;hi8],0.8);
xlabel('income,value','FontSize',11);
ylabel('count','FontSize',11);
legend({'income','value'});
x=[1 2 3 4 5];
N = 10; % filter length
u = .01; % learning rate
h = zeros(1, N);
for n = 1:20640
    if n-N < 1
        xn = [long(n:-1:1); zeros(N-n, 1)];
    else
        xn = long(n:-1:n-N+1);
    end
    en = lat(n) - h*xn;
    h = h + (u*en*xn)';
end
figure
plot(long,lat,'*g');
figure
plot(h)