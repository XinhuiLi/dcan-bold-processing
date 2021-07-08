import os
import numpy as np
import nibabel as nb
from scipy.stats import pearsonr

cpacpath='/data3/cnl/xli/cpac_features/abcd/PostFreeSurfer/MNINonLinear/Results/task-rest01/task-rest01_Atlas.dtseries.nii'
abcdpath='/data3/cnl/ABCD_intermediates/abcd-hcp-pipeline/sub-0025427/ses-1/files/MNINonLinear/Results/task-rest01/task-rest01_Atlas.dtseries.nii'
cpac=np.squeeze(nb.load(cpacpath).get_data())
abcd=np.squeeze(nb.load(abcdpath).get_data())

ts_corr = np.zeros(cpac.shape[0]) 
for i in range(cpac.shape[0]):
    ts_corr[i] = pearsonr(cpac[i,:], abcd[i,:])[0]

ts_corr = ts_corr[~np.isnan(ts_corr)]
print(np.mean(ts_corr))