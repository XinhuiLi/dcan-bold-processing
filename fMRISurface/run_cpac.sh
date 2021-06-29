Path=/data3/cnl/xli/cpac_features/abcd/PostFreeSurfer
Subject=sub-0025427a
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
ResultsFolder="$AtlasSpaceFolder"/"$ResultsFolder"/"$NameOffMRI" # we don't have this folder
ROIFolder="$AtlasSpaceFolder"/"$ROIFolder"

#Make fMRI Ribbon
#Noisy Voxel Outlier Exclusion
#Ribbon-based Volume to Surface mapping and resampling to standard surface
log_Msg "Make fMRI Ribbon"
log_Msg "mkdir -p ${ResultsFolder}/RibbonVolumeToSurfaceMapping"
mkdir -p "$ResultsFolder"/RibbonVolumeToSurfaceMapping
"$PipelineScripts"/RibbonVolumeToSurfaceMapping.sh "$ResultsFolder"/RibbonVolumeToSurfaceMapping "$ResultsFolder"/"$NameOffMRI" "$Subject" "$AtlasSpaceFolder"/"$DownSampleFolder" "$LowResMesh" "$AtlasSpaceFolder"/"$NativeFolder" "${RegName}"

#Surface Smoothing
# log_Msg "Surface Smoothing"
# "$PipelineScripts"/SurfaceSmoothing.sh "$ResultsFolder"/"$NameOffMRI" "$Subject" "$AtlasSpaceFolder"/"$DownSampleFolder" "$LowResMesh" "$SmoothingFWHM"