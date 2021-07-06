Path=/data3/cnl/xli/cpac_features/abcd/PostFreeSurfer
Subject=0025427a
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
ResultsFolder="$AtlasSpaceFolder"/"$ResultsFolder"/"$NameOffMRI" # we don't have this folder so far, make one
ROIFolder="$AtlasSpaceFolder"/"$ROIFolder"

VolumefMRICPAC=/data3/cnl/xli/reproducibility/out/cpac_abcd/output/cpac_cpac_abcd-options/sub-0025427a_ses-1/func/sub-0025427a_ses-1_task-rest_run-1_space-template_desc-brain_bold.nii.gz
ScoutCPAC=/data3/cnl/cpac1.8.1/abcd_scout/working/cpac_sub-0025427_ses-1/_scan_rest_run-1/extract_scout_brain_161/sub-0025427_ses-1_task-rest_run-1_bold_calc_calc_warp_maths.nii.gz

if [ ! -e "$ResultsFolder" ] ; then
	mkdir "$ResultsFolder"
fi

if [ ! -e "$ResultsFolder"/"$NameOffMRI".nii.gz ] ; then
	cp ${VolumefMRICPAC} "$ResultsFolder"/"$NameOffMRI".nii.gz
fi

if [ ! -e "$ResultsFolder"/"$NameOffMRI"_SBRef.nii.gz ] ; then
	cp ${ScoutCPAC} "$ResultsFolder"/"$NameOffMRI"_SBRef.nii.gz
fi

#Make fMRI Ribbon
#Noisy Voxel Outlier Exclusion
#Ribbon-based Volume to Surface mapping and resampling to standard surface
# log_Msg "Make fMRI Ribbon"
# log_Msg "mkdir -p ${ResultsFolder}/RibbonVolumeToSurfaceMapping"
mkdir -p "$ResultsFolder"/RibbonVolumeToSurfaceMapping
bash RibbonVolumeToSurfaceMapping_cpac.sh "$ResultsFolder"/RibbonVolumeToSurfaceMapping "$ResultsFolder"/"$NameOffMRI" "$Subject" "$AtlasSpaceFolder"/"$DownSampleFolder" "$LowResMesh" "$AtlasSpaceFolder"/"$NativeFolder" "${RegName}"

#Surface Smoothing
# log_Msg "Surface Smoothing"
# "$PipelineScripts"/SurfaceSmoothing.sh "$ResultsFolder"/"$NameOffMRI" "$Subject" "$AtlasSpaceFolder"/"$DownSampleFolder" "$LowResMesh" "$SmoothingFWHM"