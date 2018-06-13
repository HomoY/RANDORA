%Input part:
%Atoms Parameter:
AtomsNumber = 30;

%AtomsName = 'Au'; %1 type
AtomsName = 'Au';

StructuresNumber = 30;

%Box Parameter:
InnerBoxMin =  2.9300; % It should have a Fomula,
InnerBoxMin = (2.88 * 2.88  * 2.88*1/8*AtomsNumber).^(1/3);

InnerBoxMax =  4.3007;%
InnerBoxMax =  (2.88 * 2.88  * 1/4 *AtomsNumber).^(1/2);

OuterBoxLength = 500;% 
OuterBoxLength = 2.88*(1/2)*AtomsNumber;

CenterPoint = OuterBoxLength/2;

%Comoare Parameter:
DistanceCut= 100;

%Parallel Setting
CoreNumber = 1;

%Structure Fit Parameter
BondMin = 1.0;% 2.25 may be better

BondMax = 4.5;



