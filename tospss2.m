clear

files=listFiles('./','*.mat');

for lol=1:length(files)
    
    load (files(lol).name)
    
    Result=sortrows(Result,1);
    
    mult=[1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 ];
    
    for i=1:24
        Result(i,:)=Result(i,:).*mult;
    end
    
    Ratespeech=sum(Result(:,2:6),2);
    Ratereverb=sum(Result(:,7:11),2);
    Rateall=sum(Result(:,12:end),2);
    
    Room=[1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 3 3 3 3 3 3 3 3];
    Distance=[1 1 1 1 3 3 3 3 1 1 1 1 3 3 3 3 1 1 1 1 3 3 3 3]';
    EQMethods=[1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4]';
    SubjectNumber=lol*ones(24,1);
    
        
    spsss((lol-1)*24+1:(lol)*24,:)=[SubjectNumber Room EQMethods Distance Ratespeech Ratereverb Rateoverall];
   
end



  dlmwrite('test.txt',spsss)

