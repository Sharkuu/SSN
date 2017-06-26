function [] = getHStatistics( errorTable, h,hiddenNeuronNumber,cvStep,learningIteration)

sort(errorTable);
wartBladh = F_out_h(errorTable,h);
 
 
d = figure('visible','off');
plot(errorTable,wartBladh,'ko');
hstr = num2str(h);
hstrNew = strrep(hstr,'.','_');
fname = ['charts\H_',hstrNew,'_lneur_',int2str(hiddenNeuronNumber),'_cvStep_',int2str(cvStep),'_learIter_',int2str(learningIteration),'.jpg'];
saveas(d,fname);

c = figure('visible','off');
hist(errorTable);
fname2 =['charts\Histogram_','h_',hstrNew,'_lneur_',int2str(hiddenNeuronNumber),'_cvStep_',int2str(cvStep),'_learningIteration_',int2str(learningIteration),'.jpg'];
saveas(c,fname2)

end

