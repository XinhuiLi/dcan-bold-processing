
# Input Variables
Path=/data3/cnl/hjin/cpac_features/abcd/PostFreeSurfer
Subject=sub-0025427a
SurfaceAtlasDIR=/data3/cnl/freesurfer/DCAN-HCP/global/templates/standard_mesh_atlases
GrayordinatesSpaceDIR=/data3/cnl/freesurfer/DCAN-HCP/global/templates/91282_Greyordinates
GrayordinatesResolutions=2
HighResMesh=164
SubcorticalGrayLabels=/data3/cnl/freesurfer/DCAN-HCP/global/config/FreeSurferSubcorticalLabelTableLut.txt
FreeSurferLabels=/data3/cnl/freesurfer/DCAN-HCP/global/config/FreeSurferAllLut.txt


Subject='0025427a'
NameOffMRI=task-rest01
LowResMesh=32
FinalfMRIResolution=2
SmoothingFWHM=2
GrayordinatesResolution=2
RegName=MSMSulc

AtlasSpaceFolder="MNINonLinear"
T1wFolder="T1w"
NativeFolder="Native"
ResultsFolder="Results"
DownSampleFolder="fsaverage_LR${LowResMesh}k"
ROIFolder="ROIs"
OutputAtlasDenseTimeseries="${NameOffMRI}_Atlas"

AtlasSpaceFolder="$Path"/"$AtlasSpaceFolder"
T1wFolder="$Path"/"$T1wFolder"
ResultsFolder="$AtlasSpaceFolder"/"$ResultsFolder"/"$NameOffMRI"
ROIFolder="$AtlasSpaceFolder"/"$ROIFolder"

'''
#Make fMRI Ribbon
#Noisy Voxel Outlier Exclusion
#Ribbon-based Volume to Surface mapping and resampling to standard surface
log_Msg "Make fMRI Ribbon"
log_Msg "mkdir -p ${ResultsFolder}/RibbonVolumeToSurfaceMapping"
mkdir -p "$ResultsFolder"/RibbonVolumeToSurfaceMapping
"$PipelineScripts"/RibbonVolumeToSurfaceMapping.sh "$ResultsFolder"/RibbonVolumeToSurfaceMapping "$ResultsFolder"/"$NameOffMRI" "$Subject" "$AtlasSpaceFolder"/"$DownSampleFolder" "$LowResMesh" "$AtlasSpaceFolder"/"$NativeFolder" "${RegName}"

#Surface Smoothing
log_Msg "Surface Smoothing"
bash ./SurfaceSmoothing_cpac.sh "$ResultsFolder"/"$NameOffMRI" "$Subject" "$AtlasSpaceFolder"/"$DownSampleFolder" "$LowResMesh" "$SmoothingFWHM"
'''
#Subcortical Processing
log_Msg "Subcortical Processing"
bash ./SubcorticalProcessing_cpac.sh "$AtlasSpaceFolder" "$ROIFolder" "$FinalfMRIResolution" "$ResultsFolder" "$NameOffMRI" "$SmoothingFWHM" "$GrayordinatesResolution"

#Generation of Dense Timeseries
log_Msg "Generation of Dense Timeseries"
bash ./CreateDenseTimeseries_cpac.sh "$AtlasSpaceFolder"/"$DownSampleFolder" "$Subject" "$LowResMesh" "$ResultsFolder"/"$NameOffMRI" "$SmoothingFWHM" "$ROIFolder" "$ResultsFolder"/"$OutputAtlasDenseTimeseries" "$GrayordinatesResolution"

log_Msg "Completed"


