filename='test_2afc_20160623a.h5';

pathname='/data/behavior';
fullfname=fullfile(pathname, filename);
hi=h5info(fullfname);
resultsData=hi.Groups(2).Datasets;
resultsLabels=hi.Groups(3).Datasets;

for i=1:length(resultsData)
%     fprintf('\n%d\t%s', i, resultsData(i).Name)
    eval(['data.', resultsData(i).Name, '=h5read(''', fullfname, ''', ''/resultsData/', resultsData(i).Name, ''');'])
end
for i=1:length(resultsLabels)
%     fprintf('\n%d\t%s', i, resultsLabels(i).Name)
    eval(['data.', resultsLabels(i).Name, '=h5read(''', fullfname, ''', ''/resultsLabels/', resultsLabels(i).Name, ''');'])
end

%choice: 0=left, 1=right, 2=none 
gapdurs=unique(data.targetGapdur);
numgapdurs=length(gapdurs);
m=[];
for i=1:numgapdurs
    gd=gapdurs(i); % this gapdur
    trials=find(data.targetGapdur==gd); %trials for this gapdur
    choice=data.choice(trials); %choice made on those trials
    go_right=choice==1;
    [fraction_go_right(i), conf(i,:)]=binofit(sum(go_right), length(choice), .05);
end
    

e=errorbar(1:numgapdurs, 100*fraction_go_right, 100*conf(:,1), 100*conf(:,2), '-o');
set(gca, 'ytick', [0:25:100], 'xtick', 1:numgapdurs, 'xticklabel', gapdurs)
xlabel('gap duration, ms')
ylabel('% correct GD')
line(xlim, [50 50], 'linest', '--')
line(xlim, [100 100], 'linest', '--')
shg

%data=h5read(fullfname, '/resultsData')

%fractionRightEachValue = nRightwardEachValue/nTrialsEachValue