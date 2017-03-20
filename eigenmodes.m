addpath('inputfiles') %include path of input files
addpath('Program Files') %include path of input files
param % load inputfiles/param.m
global kderivatives
kderivatives=0;
global multipleaxialnumber
if size(n,2)==1    %if a single azimuthal number is given 
    multipleaxialnumber=0;
    modesonly % calculate the eigenmodes
else % multiple azimuthal numbers
    timecheck=builtin('clock');
    if timecheck(1) > 2017 || (timecheck(1)==2017 && timecheck(2)>9) % this code stops working Jan 1, 2018
            disp('Please contact Cambridge Enterprise to renew your license');
            clear all
            close all
            break
    end
    latexmodesresults=0; % next four lines stop usual matlab2tikz writing to file
    if latexresults==1
        latexmodesresults=1;
    end
    multipleaxialnumber=1; %tells other files we have multiple azimuthal numbers
    NN=n; 
    D1multiple=cell(size(NN,2),1); %next five lines create empty cells to store results
    numericalmultiple=cell(size(NN,2),1);
    upidmultiple=cell(size(NN,2),1);
    doidmultiple=cell(size(NN,2),1);
    Vmultiple=cell(size(NN,2),1);   
    for ij=1:size(NN,2) % for each azimuthal number
        modesonly %calculate eigenmodes
        D1multiple{ij}=D1; %next five lines store results
        numericalmultiple{ij}=numerical; %D1 and numerical are eigenmodes in different forms
        upidmultiple{ij}=upid; %index of upstream modes
        doidmultiple{ij}=doid; % index of downstream modes
        Vmultiple{ij}=V; % eigenvectors
        figure(3*ij) 
        if latexmodesresults==1 %write to file the eigenmodes if specified
            matlab2tikz( ['./DATA/Eigenmodes' num2str(ij) '.tex'], 'height', '7cm', 'width', '10cm', 'standalone',true, 'floatFormat', '%.4g', 'showInfo', false);
        end
    end    
    for ij=2:size(NN,2) %close all plots of shear and swirl except for the first plot
        close(figure(3*ij-2))
        close(figure(3*ij-1))
    end
    clear ij D1 numerical upid doid multiple V eta latexmodesresults % clear any unnecesary variables at the end
end

clear multipleaxialnumber hydrodynamicdiscretisation kderivatives 