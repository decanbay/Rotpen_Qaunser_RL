#ifndef __c2_Non_linear_simulation_h__
#define __c2_Non_linear_simulation_h__
#include "MWCUBLASUtils.hpp"

/* Type Definitions */
#ifndef struct_tag_59AHcW6hH2dOmmDfwkvrnG
#define struct_tag_59AHcW6hH2dOmmDfwkvrnG

struct tag_59AHcW6hH2dOmmDfwkvrnG
{
  int32_T f1;
  int32_T f2;
};

#endif                                 /*struct_tag_59AHcW6hH2dOmmDfwkvrnG*/

#ifndef typedef_c2_s_59AHcW6hH2dOmmDfwkvrnG
#define typedef_c2_s_59AHcW6hH2dOmmDfwkvrnG

typedef tag_59AHcW6hH2dOmmDfwkvrnG c2_s_59AHcW6hH2dOmmDfwkvrnG;

#endif                                 /*typedef_c2_s_59AHcW6hH2dOmmDfwkvrnG*/

#ifndef struct_tag_5h8uI2HsgOdDFFzIMaqEFH
#define struct_tag_5h8uI2HsgOdDFFzIMaqEFH

struct tag_5h8uI2HsgOdDFFzIMaqEFH
{
  c2_s_59AHcW6hH2dOmmDfwkvrnG _data;
};

#endif                                 /*struct_tag_5h8uI2HsgOdDFFzIMaqEFH*/

#ifndef typedef_c2_s_5h8uI2HsgOdDFFzIMaqEFH
#define typedef_c2_s_5h8uI2HsgOdDFFzIMaqEFH

typedef tag_5h8uI2HsgOdDFFzIMaqEFH c2_s_5h8uI2HsgOdDFFzIMaqEFH;

#endif                                 /*typedef_c2_s_5h8uI2HsgOdDFFzIMaqEFH*/

#ifndef struct_SFc2_Non_linear_simulationInstanceStruct
#define struct_SFc2_Non_linear_simulationInstanceStruct

struct SFc2_Non_linear_simulationInstanceStruct
{
  SimStruct *S;
  ChartInfoStruct chartInfo;
  uint8_T c2_is_active_c2_Non_linear_simulation;
  uint8_T c2_JITStateAnimation[1];
  uint8_T c2_JITTransitionAnimation[1];
  real_T c2_dv1[88224];
  real_T c2_dv3[26064];
  real_T c2_Xt[22056];
  real_T c2_Yt[22056];
  real_T c2_Zt[22056];
  real_T c2_dv2[14976];
  real_T c2_b_Xt[6516];
  void *c2_fEmlrtCtx;
  real_T (*c2_signals)[3];
  real_T *c2_iterationCounter;
  real_T *c2_armPartPatchHandle;
  real_T *c2_pendPartPatchHandle;
  real_T *c2_drivePartPatchHandle;
  real_T *c2_thetaPlotHandle;
  real_T *c2_alphaPlotHandle;
  real_T *c2_frameRate;
  real_T (*c2_armPartVertices)[88224];
  real_T (*c2_drivePartVertices)[14976];
  real_T (*c2_pendPartVertices)[26064];
  real_T (*c2_gpu_Yt)[6516];
  real_T (*c2_gpu_armPart_vertices_G_frame)[88224];
  real_T *c2_gpu_beta1;
  real_T *c2_gpu_sy;
  real_T *c2_gpu_alpha1;
  real_T *c2_gpu_cr;
  real_T (*c2_gpu_Xt)[22056];
  real_T *c2_b_gpu_beta1;
  real_T (*c2_gpu_dv)[4];
  real_T (*c2_gpu_BaseToArm)[16];
  real_T (*c2_b_gpu_dv)[16];
  real_T *c2_c_gpu_beta1;
  real_T (*c2_gpu_pendPart_vertices_G_frame)[6516];
  real_T (*c2_b_gpu_armPart_vertices_G_frame)[22056];
  real_T *c2_gpu_cy;
  real_T (*c2_b_gpu_pendPart_vertices_G_frame)[26064];
  real_T (*c2_b_gpu_Xt)[6516];
  real_T *c2_b_gpu_sy;
  real_T (*c2_gpu_pendPartVertices)[26064];
  real_T (*c2_gpu_drivePartVertices)[14976];
  real_T (*c2_c_gpu_armPart_vertices_G_frame)[22056];
  real_T (*c2_gpu_drivePart_vertices_G_frame)[14976];
  real_T (*c2_gpu_BaseToDrive)[16];
  real_T (*c2_d_gpu_armPart_vertices_G_frame)[22056];
  real_T (*c2_gpu_y)[16];
  real_T *c2_b_gpu_cy;
  int8_T (*c2_gpu_dv1)[4];
  real_T (*c2_c_gpu_pendPart_vertices_G_frame)[6516];
  real_T (*c2_gpu_armPartVertices)[88224];
  real_T (*c2_gpu_Zt)[3744];
  real_T (*c2_b_gpu_Zt)[6516];
  real_T (*c2_b_gpu_drivePart_vertices_G_frame)[3744];
  real_T (*c2_d_gpu_pendPart_vertices_G_frame)[6516];
  real_T *c2_b_gpu_alpha1;
  real_T (*c2_c_gpu_Xt)[3744];
  real_T *c2_c_gpu_alpha1;
  real_T (*c2_c_gpu_Zt)[22056];
  real_T (*c2_b_gpu_Yt)[3744];
  real_T (*c2_c_gpu_drivePart_vertices_G_frame)[3744];
  real_T (*c2_c_gpu_Yt)[22056];
  real_T (*c2_d_gpu_drivePart_vertices_G_frame)[3744];
  real_T *c2_gpu_sr;
};

#endif                                 /*struct_SFc2_Non_linear_simulationInstanceStruct*/

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */
extern const mxArray
  *sf_c2_Non_linear_simulation_get_eml_resolved_functions_info();

/* Function Definitions */
extern void sf_c2_Non_linear_simulation_get_check_sum(mxArray *plhs[]);
extern void c2_Non_linear_simulation_method_dispatcher(SimStruct *S, int_T
  method, void *data);

#endif
