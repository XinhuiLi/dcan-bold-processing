FreeSurferFolder=/data3/cnl/xli/reproducibility/out/cpac_abcd/working/cpac_sub-0025427a_ses-1/anat_preproc_freesurfer_52/anat_freesurfer/recon_all
T1wFolder=/data3/cnl/xli/cpac_features/abcd
NativeFolder=bold_proc
CARET7DIR=''
AtlasSpaceFolder=''
InverseAtlasTransform="$AtlasSpaceFolder"/xfms/standard2acpc_dc


# Questions: 
# how to get "$FreeSurferFolder"/mri/c_ras.mat?
# how to get "$T1wFolder"/"$NativeFolder"/"$Subject".native.wb.spec?


for Hemisphere in L R ; do
	#Set a bunch of different ways of saying left and right
	if [ $Hemisphere = "L" ] ; then
		hemisphere="l"
		Structure="CORTEX_LEFT"
	elif [ $Hemisphere = "R" ] ; then
		hemisphere="r"
		Structure="CORTEX_RIGHT"
	fi
    
    Types="ANATOMICAL@GRAY_WHITE ANATOMICAL@PIAL"
	i=1
    for Surface in white pial ; do
        Type=$(echo "$Types" | cut -d " " -f $i)
        Secondary=$(echo "$Type" | cut -d "@" -f 2)
        Type=$(echo "$Type" | cut -d "@" -f 1)
        if [ ! $Secondary = $Type ] ; then
            Secondary=$(echo " -surface-secondary-type ""$Secondary")
        else
            Secondary=""
        fi
        mris_convert "$FreeSurferFolder"/surf/"$hemisphere"h."$Surface" "$T1wFolder"/"$NativeFolder"/"$Subject"."$Hemisphere"."$Surface".native.surf.gii
        ${CARET7DIR}/wb_command -set-structure "$T1wFolder"/"$NativeFolder"/"$Subject"."$Hemisphere"."$Surface".native.surf.gii ${Structure} -surface-type $Type$Secondary
        ${CARET7DIR}/wb_command -surface-apply-affine "$T1wFolder"/"$NativeFolder"/"$Subject"."$Hemisphere"."$Surface".native.surf.gii "$FreeSurferFolder"/mri/c_ras.mat "$T1wFolder"/"$NativeFolder"/"$Subject"."$Hemisphere"."$Surface".native.surf.gii
        ${CARET7DIR}/wb_command -add-to-spec-file "$T1wFolder"/"$NativeFolder"/"$Subject".native.wb.spec $Structure "$T1wFolder"/"$NativeFolder"/"$Subject"."$Hemisphere"."$Surface".native.surf.gii
        ${CARET7DIR}/wb_command -surface-apply-warpfield "$T1wFolder"/"$NativeFolder"/"$Subject"."$Hemisphere"."$Surface".native.surf.gii "$InverseAtlasTransform".nii.gz "$AtlasSpaceFolder"/"$NativeFolder"/"$Subject"."$Hemisphere"."$Surface".native.surf.gii -fnirt "$AtlasTransform".nii.gz
        ${CARET7DIR}/wb_command -add-to-spec-file "$AtlasSpaceFolder"/"$NativeFolder"/"$Subject".native.wb.spec $Structure "$AtlasSpaceFolder"/"$NativeFolder"/"$Subject"."$Hemisphere"."$Surface".native.surf.gii
        i=$(( i+1 ))
    done

done