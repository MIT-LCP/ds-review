function [CH , extracts ] = find_chronic_health_from_ds(chronic_health,DS)
% chronic_health: chronic health is a string
% DS: string too, the discharge summary
% returns boolean

% Define generic false positives
termsNeg = {'no','not','father','mother'};

switch chronic_health
    case 'aids'
        terms = {'HIV','AIDS'};
        termsNeg = [termsNeg {'NSAIDS','negative','test','hearing','shivering','denies'}];
    case 'hepfail'
        terms = {'hep.{0,10}fail','liver.{0,3}fail','lactulose'};
    case 'lymph'
        terms = {'lymphom'};
    case 'metcan'
        terms = {'metastasis','metast.{0,10}cancer'};
%     case 'leuk'
%         terms = {'.*leuk.*'};
    case 'immunosuppr'
        terms = {'immu.{0,10}sup','tacrolimus', 'prograf',...
'cyclosporine','neoral','sandimmune','mycophenolate','mofetil','cellcept',...
'sirolimus','belatacept','nulojix','atg','anti-thymocyteglobulin','basiliximab','simulect',...
'methotrexate','leflunomide','etanercept','infliximab','adalimumab','golimumab','certolizumab',...
'anakinraand','tocilizumab','abatacept','rituximab','chemotherapy'};
    case 'cirrhosis'
        terms = {'cirrhosis'};
    case 'vent'
        terms = {'CPAP', 'mech.{0,10}vent','intubat'};
    otherwise terms = {};
end

CH = false;
extracts = {};
fieldLength = 30;
for t=1:length(terms)
    locs = regexp(  DS ,terms{t}, 'ignorecase','start') ;
    if ~isempty( locs )
        extracts = [extracts ; arrayfun( @(x)DS((locs(x)-fieldLength):(locs(x)+fieldLength+5)) , 1:length(locs) , 'UniformOutput' , false)'];
    end
end

tbr = [];
%% Test for false positives
for t=1:length(termsNeg) 
    % for each false positive term
    for e=1:length(extracts) % loom at each identified positive
        locs = regexp(  extracts{e} ,termsNeg{t}, 'ignorecase','start') ;
        if ~isempty( locs )
            % if false positive...
            tbr = [tbr e];
        end 
    end
end
%... then remove
extracts(tbr) = []; 

if length(extracts)>=1
    CH=true;
end
    
