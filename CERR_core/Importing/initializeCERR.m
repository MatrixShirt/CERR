function out = initializeCERR(cellName)
%"initializeCERR"
%   Return a skeleton planC structure with each cell's struct array having
%   zero length and properly set fieldnames.
%
%   An optional argument allows the user to specifiy a single empty planC
%   cell to be returned rather than the full empty planC, ie 'scan',
%   'structures', 'dose' etc.
%
%Usage:
%   planInitC = initializeCERR;
%   doseInitS = initializeCERR('dose')
%   scanInitS = initializeCERR('scan')
%
%   etc.
%
%Author: J. O. Deasy, deasy@radonc.wustl.edu
%
%Rerence:
%W. Harms, Specifications for Tape/Network Format for Exchange of Treatment Planning Information,
%version 3.22., RTOG 3D QA Center, (http://rtog3dqa.wustl.edu), 1997.
%
%Last Modified:  22 Apr 02, by JOD.
%                30 Apr 03, JOD, set doseScale default to 1 as per RTOG spec. 4.00.
%                28 Jun 06, JRA, Modified function prototype to return a
%                                single variable, planInitC, rather than
%                                individual structS.  Also modified the
%                                base scanInitS to reflect planC's current
%                                structure.
%
%
% Copyright 2010, Joseph O. Deasy, on behalf of the CERR development team.
% 
% This file is part of The Computational Environment for Radiotherapy Research (CERR).
% 
% CERR development has been led by:  Aditya Apte, Divya Khullar, James Alaly, and Joseph O. Deasy.
% 
% CERR has been financially supported by the US National Institutes of Health under multiple grants.
% 
% CERR is distributed under the terms of the Lesser GNU Public License. 
% 
%     This version of CERR is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
% CERR is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
% without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
% See the GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with CERR.  If not, see <http://www.gnu.org/licenses/>.

global stateS

if nargout > 1
    error('Invalid number of outputs requested from initializeCERR.  Check for the new single output prototype!');
end

headerInitS = struct(...
    'archive'                  ,  '',...
    'tapeStandardNumber'       ,  '',...
    'intercomparisonStandard'  ,  '',...
    'institution'              ,  '',...
    'dateCreated'              ,   '',...
    'writer'                   ,   '',...
    'sponsorID'                ,   '',...
    'protocolID'               ,   '',...
    'subjectID'                ,   '',...
    'submissionID'             ,   '',...
    'timeSaved'                ,   '',...
    'lastSavedInVer'           ,   '',...
    'CERRImportVersion'        ,   '',...
    'anonymizedID'             ,   '');

commentInitS = struct( ...
    'imageNumber'             ,   '', ...
    'imageType'               ,   '', ...
    'caseNumber'              ,   '', ...
    'patientName'             ,   '', ...
    'writer'                  ,   '', ...
    'commentDescription'      ,   '', ...
    'dateWritten'             ,   '', ...
    'fileOfOrigin'            ,   '', ...
    'unitNumber'              ,   '', ...
    'headInOut'               ,   '', ...
    'comment'                 ,   '');

scanInitS = struct(...
    'scanArray'               ,   '', ...
    'scanType'                ,   '', ...
    'scanInfo'                ,   '', ...
    'uniformScanInfo'         ,   '', ...
    'scanArraySuperior'       ,   '', ...
    'scanArrayInferior'       ,   '', ...
    'thumbnails'              ,   '', ...
    'transM'                  ,   '', ...
    'scanUID'                 ,   '', ...
    'assocDeformUID'          ,   ''  ...
    );

structureInitS = struct( ...
    'imageNumber'               ,   '', ...
    'imageType'                 ,   '', ...
    'caseNumber'                ,   '', ...
    'roiNumber'                 ,   '', ...
    'patientName'               ,   '', ...
    'structureName'             ,   '', ...
    'ROIInterpretedType'        ,   '', ... % DK %% New addition to match DICOM standard
    'numberRepresentation'      ,   '', ...
    'structureFormat'           ,   '', ...
    'numberOfScans'             ,   '', ...
    'maximumNumberScans'        ,   '', ...
    'maximumPointsPerSegment'   ,   '', ...
    'maximumSegmentsPerScan'    ,   '', ...
    'structureEdition'          ,   '', ...
    'unitNumber'                ,   '', ...
    'writer'                    ,   '', ...
    'dateWritten'               ,   '', ...
    'structureColor'            ,   '', ...
    'structureDescription'      ,   '', ...
    'studyNumberOfOrigin'       ,   '', ...
    'contour'                   ,   '', ...   %CERR addition
    'rasterSegments'            ,   '', ...   %CERR addition
    'DSHPoints'                 ,   '', ...   %CERR addition
    'orientationOfStructure'    ,   '', ...   %ORIENTATIONOFSTRUCTURE for BAT compatibility (non-RTOG keyword).
    'transferProtocol'          ,   '', ...
    'DICOMHeaders'              ,   '', ...
    'visible'                   ,   '', ...   %CERR addition
    'associatedScan'            ,   '', ...
    'strUID'                    ,   '', ...
    'assocScanUID'              ,   '', ...
    'rasterized'                ,   '' ...
    );      %CERR addition

structureArrayInitS        = struct( ...
    'indicesArray'              ,   '', ...
    'bitsArray'                 ,   '', ...
    'assocScanUID'              ,   '', ...
    'structureSetUID'           ,   ''  ...
    );

beamGeometryInitS          = struct( ...
    'imageNumber'                ,   '', ...
    'imageType'                  ,   '', ...
    'caseNumber'                 ,   '', ...
    'patientName'                ,   '', ...
    'beamNumber'                 ,   '', ...
    'beamModality'               ,   '', ...
    'beamEnergyMeV'              ,   '', ...
    'beamDescription'            ,   '', ...
    'RxDosePerTxGy'              ,   '', ...
    'MonitorUnitsPerTx'          ,   '', ...   %KU added 7Oct07
    'numberOfTx'                 ,   '', ...
    'fractionGroupID'            ,   '', ...
    'beamType'                   ,   '', ...
    'planIDOfOrigin'             ,   '', ...
    'collimatorType'             ,   '', ...
    'apertureType'               ,   '', ...
    'apertureDescription'        ,   '', ...
    'collimatorAngle'            ,   '', ...
    'gantryAngle'                ,   '', ...
    'couchAngle'                 ,   '', ...
    'headInOut'                  ,   '', ...
    'nominalIsocenterDistance'   ,   '', ...
    'numberRepresentation'       ,   '', ...
    'apertureID'                 ,   '', ...
    'wedgeAngle'                 ,   '', ...
    'wedgeRotationAngle'         ,   '', ...
    'arcAngle'                   ,   '', ...
    'machineID'                  ,   '', ...
    'beamWeight'                 ,   '', ...
    'weightUnits'                ,   '', ...
    'compensator'                ,   '', ...
    'compensatorFormat'          ,   '', ...
    'file'                       ,   '', ...
    'beamUID'                    ,   ''  ...
    );       %CERR addition


beamsInitS = struct(...
    'PatientName'                     ,   '', ...
    'PatientID'                       ,   '', ...
    'PatientBirthDate'                ,   '', ...
    'PatientSex'                      ,   '', ...
    'AcquisitionGroupLength'          ,   '', ...
    'RelationshipGroupLength'         ,   '', ...
    'ImagePresentationGroupLength'    ,   '', ...
    'PixelPaddingValue'               ,   '', ...
    'PlanGroupLength'                 ,   '', ...
    'RTPlanLabel'                     ,   '', ...
    'RTPlanDate'                      ,   '', ...
    'RTPlanTime'                      ,   '', ...
    'RTPlanGeometry'                  ,   '', ...
    'TreatmentSites'                  ,   '', ...
    'PrescriptionDescription'         ,   '', ...
    'DoseReferenceSequence'           ,   '', ...
    'FractionGroupSequence'           ,   '', ...
    'BeamSequence'                    ,   '', ...
    'PatientSetupSequence'            ,   '', ...
    'ReferencedRTGroupLength'         ,   '', ...
    'ReferencedStructureSetSequence'  ,   '', ...
    'ReferencedDoseSequence'          ,   '', ...
    'ReviewGroupLength'               ,   '', ...
    'ApprovalStatus'                  ,   '', ...
    'ReviewDate'                      ,   '', ...
    'ReviewTime'                      ,   '', ...
    'ReviewerName'                    ,   '', ...
    'SOPInstanceUID'                  ,   '', ...
    'BeamUID'                         ,   '' ...
    );

digitalFilmInitS = struct( ...
    'imageNumber'                ,   '', ...
    'imageType'                  ,   '', ...
    'caseNumber'                 ,   '', ...
    'patientName'                ,   '', ...
    'beamNumber'                 ,   '', ...
    'beamDescription'            ,   '', ...
    'filmNumber'                 ,   '', ...
    'filmDate'                   ,   '', ...
    'filmType'                   ,   '', ...
    'filmSource'                 ,   '', ...
    'numberOfDimensions'         ,   '', ...
    'sizeOfDimension1'           ,   '', ...
    'sizeOfDimension2'           ,   '', ...
    'grid1Units'                 ,   '', ...
    'grid2Units'                 ,   '', ...
    'sourceImageDistance'        ,   '', ...
    'xOffset'                    ,   '', ...
    'yOffset'                    ,   '', ...
    'bytesPerPixel'              ,   '', ...
    'numberRepresentation'       ,   '', ...
    'filmDescription'            ,   '', ...
    'unitNumber'                 ,   '', ...
    'ODScale'                    ,   '', ...
    'bitsPerPixel'               ,   '', ...
    'collimatorAngle'            ,   '', ...
    'image'                      ,   '');


doseInitS  = struct( ....
    'imageNumber'                ,   '', ...
    'imageType'                  ,   '', ...
    'caseNumber'                 ,   '', ...
    'patientName'                ,   '', ...
    'doseNumber'                 ,   '', ...
    'doseType'                   ,   '', ...
    'doseUnits'                  ,   '', ...
    'doseScale'                  ,   '', ...
    'fractionGroupID'            ,   '', ...
    'numberOfTx'                 ,   '', ...
    'orientationOfDose'          ,   '', ...
    'numberRepresentation'       ,   '', ...
    'numberOfDimensions'         ,   '', ...
    'sizeOfDimension1'           ,   '', ...
    'sizeOfDimension2'           ,   '', ...
    'sizeOfDimension3'           ,   '', ...
    'coord1OFFirstPoint'         ,   '', ...
    'coord2OFFirstPoint'         ,   '', ...
    'horizontalGridInterval'     ,   '', ...
    'verticalGridInterval'       ,   '', ...
    'doseDescription'            ,   '', ...
    'doseEdition'                ,   '', ...
    'unitNumber'                 ,   '', ...
    'writer'                     ,   '', ...
    'dateWritten'                ,   '', ...
    'planNumberOfOrigin'         ,   '', ...
    'planEditionOfOrigin'        ,   '', ...
    'studyNumberOfOrigin'        ,   '', ...
    'versionNumberOfProgram'     ,   '', ...
    'xcoordOfNormaliznPoint'     ,   '', ...
    'ycoordOfNormaliznPoint'     ,   '', ...
    'zcoordOfNormaliznPoint'     ,   '', ...
    'doseAtNormaliznPoint'       ,   '', ...
    'doseError'                  ,   '', ...
    'coord3OfFirstPoint'         ,   '', ...
    'depthGridInterval'          ,   '', ...
    'planIDOfOrigin'             ,   '', ...
    'doseArray'                  ,   '', ...  %CERR addition
    'zValues'                    ,   '', ...  %CERR addition
    'delivered'                  ,   '', ...  %CERR addition
    'cachedColor'                ,   '', ...  %CERR addition
    'cachedTime'                 ,   '', ...  %CERR addition
    'numCachedSlices'            ,   '', ...  %CERR addition
    'transferProtocol'           ,   '', ...
    'DICOMHeaders'               ,   '', ...
    'associatedScan'             ,   '', ...  %CERR addition
    'transM'                     ,   '', ...
    'doseUID'                    ,   '', ...
    'assocScanUID'               ,   '', ...
    'assocBeamUID'               ,   '', ...
    'Rx'                         ,   '', ...  % Priscription Dose
    'doseOffset'                 ,   '' ...   %CERR addition
    );



DVHInitS = struct( ...
    'imageNumber'                ,   '', ...
    'imageType'                  ,   '', ...
    'caseNumber'                 ,   '', ...
    'patientName'                ,   '', ...
    'structureName'              ,   '', ...
    'doseUnits'                  ,   '', ...
    'doseType'                   ,   '', ...
    'volumeType'                 ,   '', ...
    'numberOfPairs'              ,   '', ...
    'maximumNumberPairs'         ,   '', ...
    'numberRepresentation'       ,   '', ...
    'planIDOfOrigin'             ,   '', ...
    'fractionIDOfOrigin'         ,   '', ...  %CERR addition
    'doseScale'                  ,   '', ...
    'volumeScale'                ,   '', ...
    'dateOfDVH'                  ,   '', ...
    'DVHMatrix'                  ,   '', ...  %CERR addition
    'doseIndex'                  ,   '', ...  %CERR addition, index in planC of the dose distribution used to generate this DVH
    'dvhUID'                     ,   '', ...
    'assocStrUID'                ,   '', ...
    'assocDoseUID'               ,   ''  ...
    );

IVHInitS = struct( ...
    'imageNumber'                ,   '', ...
    'imageType'                  ,   '', ...
    'caseNumber'                 ,   '', ...
    'patientName'                ,   '', ...
    'structureName'              ,   '', ...
    'scanUnits'                  ,   '', ...
    'scanType'                   ,   '', ...
    'volumeType'                 ,   '', ...
    'numberOfPairs'              ,   '', ...
    'maximumNumberPairs'         ,   '', ...
    'numberRepresentation'       ,   '', ...
    'scanScale'                  ,   '', ...
    'volumeScale'                ,   '', ...
    'dateOfIVH'                  ,   '', ...
    'IVHMatrix'                  ,   '', ...  %CERR addition
    'scanIndex'                  ,   '', ...  %CERR addition, index in planC of the dose distribution used to generate this DVH
    'ivhUID'                     ,   '', ...
    'assocStrUID'                ,   '', ...
    'assocScanUID'               ,   ''  ...
    );

planParamS = struct(...
    'doseFractionID'        ,'',...
    'structureName'         ,'',...
    'lh_goalType'           ,'',...
    'lh_goal'               ,'',...
    'lh_unit'               ,'',...
    'operator'              ,'',...
    'rh_goalType'           ,'',...
    'rh_goal'               ,'',...
    'rh_unit'               ,'',...
    'category'              ,'',...
    'failPercent'           ,'',...
    'volume'                ,'',...
    'minDose'               ,'',...
    'maxDose'               ,'',...
    'meanDose'              ,'',...
    'result'                ,'',...
    'assocDoseUID'          ,'',...
    'assocStructUID'        ,''...
    );

seedGeometryInitS = struct(...
    'imageNumber'                ,   '', ...
    'imageType'                  ,   '', ...
    'caseNumber'                 ,   '', ...
    'patientName'                ,   '', ...
    'seedModel'                  ,   '', ...
    'isotope'                    ,   '', ...
    'seedStrength'               ,   '', ...
    'strengthUnits'              ,   '', ...
    'dateOfImplant'              ,   '', ...
    'numberOfSeeds'              ,   '', ...
    'numberRepresentation'       ,   '', ...
    'planIDOfOrigin'             ,   '', ...
    'pointsM'                    ,   '' ...  %CERR addition;
    );

deformS         = struct(...
 'baseScanUID'                  ,   '', ...
 'movScanUID'                   ,   '', ...
 'deformedScanUID'              ,   '', ...
 'deformUID'                    ,   '', ...
 'bsp_img_origin'               ,   '', ...
 'bsp_img_spacing'              ,   '', ...
 'bsp_img_dim'                  ,   '', ...
 'bsp_roi_offset'               ,   '', ...
 'bsp_roi_dim'                  ,   '', ...
 'bsp_vox_per_rgn'              ,   '', ...
 'bsp_coefficients'             ,   '', ...
 'vectorField4M'                ,   '', ...
 'bsp_direction_cosines'        ,   '' ...
  );

RTTreatmentInitS = struct('');          %CERR addition

importLogInitS = struct(...             %CERR addition
    'importLog'                 , '', ...
    'startTime'                 , '', ...
    'endTime'                   , '');

IMInitS = struct(...                    %CERR addition
    'IMSetup'                   , '', ...
    'IMDosimetry'               , '');

planInitC = cell(1,16);

indexS.header               = 1;
indexS.comment              = 2;
indexS.scan                 = 3;
indexS.structures           = 4;
indexS.structureArray       = 5;
indexS.structureArrayMore   = 6;
indexS.beams                = 7;
indexS.beamGeometry         = 8;
indexS.dose                 = 9;
indexS.DVH                  = 10;
indexS.IVH                  = 11;
indexS.planParam            = 12;
indexS.seedGeometry         = 13;
indexS.digitalFilm          = 14;
indexS.RTTreatment          = 15;
indexS.IM                   = 16;
indexS.deform               = 17;
indexS.importLog            = 18;
indexS.CERROptions          = 19;

% check if this is microRT and/or RPC film study and change the study
% accordingly
try
    if stateS.optS.chkMicroRT
        indexS.microRTP = 20;
        indexS.indexS   = 21;
        microRTPInitS = initializeMicroRTP(planInitC);
    else
        indexS.indexS = 20;
    end
catch
    indexS.indexS = 20;
end


indexInitS = indexS;

% Initialize the fields of each struct to be empty
headerInitS(1) = []; commentInitS(1) = []; scanInitS(1) = []; doseInitS(1) = [];
planInitC(1) = [];  DVHInitS(1) = []; IVHInitS(1) = [];
digitalFilmInitS(1) = []; importLogInitS(1) = []; IMInitS(1) = [];structureInitS(1) = [];
beamGeometryInitS(1) = []; structureArrayInitS(1) = []; seedGeometryInitS(1) = [];
deformS(1) = [];
% seedGeometryInitS(1) = []; This is never used commented by DK

planInitC{indexS.header}            = headerInitS;
planInitC{indexS.comment}           = commentInitS;
planInitC{indexS.scan}              = scanInitS;
planInitC{indexS.structures}        = structureInitS;
planInitC{indexS.structureArray}    = structureArrayInitS;
planInitC{indexS.structureArrayMore}= structureArrayInitS;
planInitC{indexS.beamGeometry}      = beamGeometryInitS;
planInitC{indexS.beams}             = beamsInitS;
planInitC{indexS.dose}              = doseInitS;
planInitC{indexS.DVH}               = DVHInitS;
planInitC{indexS.IVH}               = IVHInitS;
planInitC{indexS.planParam}         = planParamS;
planInitC{indexS.seedGeometry}      = seedGeometryInitS;
planInitC{indexS.digitalFilm}       = digitalFilmInitS;
planInitC{indexS.RTTreatment}       = RTTreatmentInitS;
planInitC{indexS.deform}            = deformS;
planInitC{indexS.importLog}         = importLogInitS;
planInitC{indexS.IM}                = IMInitS;
planInitC{indexS.CERROptions}       = struct([]); %Currently blank.  Set on planC creation.

%Store the indexS so requesting functions can extract the prototype they
%want, ie dose, structures etc.
planInitC{indexS.indexS}            = indexInitS;

try
    planInitC{indexS.microRTP}      = microRTPInitS;
end

%Handle various output options.
if nargin == 0
    out = planInitC;
elseif nargin == 1
    
    if isfield(indexS, cellName)
        cellNum = getfield(indexS, cellName);
        out = planInitC{cellNum};
    else
        error('Cell name requested from initializeCERR does not exist in planInitC.');
    end
    
    clear headerInitS commentInitS scanInitS doseInitS planInitC DVHInitS IVHInitS
    clear digitalFilmInitS importLogInitS IMInitS structureInitS beamGeometryInitS
    clear structureArrayInitS
    
end