FreeSurferFolder=/data3/cnl/xli/reproducibility/out/cpac_abcd/working/cpac_sub-0025427a_ses-1/anat_preproc_freesurfer_52/anat_freesurfer/recon_all
cd ${FreeSurferFolder}
MatrixX=$(mri_info mri/brain.finalsurfs.mgz | grep "c_r" | cut -d "=" -f 5 | sed s/" "/""/g)
MatrixY=$(mri_info mri/brain.finalsurfs.mgz | grep "c_a" | cut -d "=" -f 5 | sed s/" "/""/g)
MatrixZ=$(mri_info mri/brain.finalsurfs.mgz | grep "c_s" | cut -d "=" -f 5 | sed s/" "/""/g)
echo "1 0 0 ""$MatrixX" >> mri/c_ras.mat
echo "0 1 0 ""$MatrixY" >> mri/c_ras.mat
echo "0 0 1 ""$MatrixZ" >> mri/c_ras.mat
echo "0 0 0 1" >> mri/c_ras.mat

# MatrixX=$(mri_info "$FreeSurferFolder"/mri/brain.finalsurfs.mgz | grep "c_r" | tail -n 1 | cut -d "=" -f 5 | sed s/" "/""/g)
# MatrixY=$(mri_info "$FreeSurferFolder"/mri/brain.finalsurfs.mgz | grep "c_a" | tail -n 1 | cut -d "=" -f 5 | sed s/" "/""/g)
# MatrixZ=$(mri_info "$FreeSurferFolder"/mri/brain.finalsurfs.mgz | grep "c_s" | tail -n 1 | cut -d "=" -f 5 | sed s/" "/""/g)
# echo "1 0 0 ""$MatrixX" >> "$FreeSurferFolder"/mri/c_ras.mat
# echo "0 1 0 ""$MatrixY" >> "$FreeSurferFolder"/mri/c_ras.mat
# echo "0 0 1 ""$MatrixZ" >> "$FreeSurferFolder"/mri/c_ras.mat
# echo "0 0 0 1" >> "$FreeSurferFolder"/mri/c_ras.mat