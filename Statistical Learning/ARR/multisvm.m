function z = multisvm(TrainingSet,GroupTrain,TestSet)
%Models a given training set with a corresponding group vector and 
%classifies a given test set using an SVM classifier according to a 
%one vs. all relation. 
%
%This code was written by Cody Neuburger cneuburg@fau.edu
%Florida Atlantic University, Florida USA
%This code was adapted and cleaned from Anand Mishra's multisvm function
%found at http://www.mathworks.com/matlabcentral/fileexchange/33170-multi-class-support-vector-machine/

u=unique(GroupTrain);
numClasses=length(u);
%result = zeros(length(TestSet(:,1)),1);

%build models
for k=1:numClasses
    %Vectorized statement that binarizes Group
    %where 1 is the current class and 0 is all other classes
    G1vAll=(GroupTrain==u(k));
    models{k} = fitcsvm(TrainingSet,G1vAll);
end

%classify test cases

    for k=1:numClasses
        [a,b{k}]=predict(models{k},TestSet); 
    end
    score=cell2mat(b);score=score(:,1:2:end);
    score_comp=repmat(min(score,[],2),1,numClasses); 
    [z,w]=find(score'==score_comp');
    
end
