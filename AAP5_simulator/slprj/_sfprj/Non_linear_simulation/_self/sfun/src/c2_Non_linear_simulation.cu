/* Include files */

#include "Non_linear_simulation_sfun.h"
#include "c2_Non_linear_simulation.h"
#include "MWCudaDimUtility.hpp"
#include "mwmathutil.h"
#ifdef utFree
#undef utFree
#endif

#ifdef utMalloc
#undef utMalloc
#endif

#ifdef __cplusplus

extern "C" void *utMalloc(size_t size);
extern "C" void utFree(void*);

#else

extern void *utMalloc(size_t size);
extern void utFree(void*);

#endif

#include "MWCUBLASUtils.hpp"

/* Type Definitions */

/* Named Constants */
const int32_T CALL_EVENT = -1;

/* Variable Declarations */

/* Variable Definitions */
static real_T _sfTime_;

/* Function Declarations */
static void initialize_c2_Non_linear_simulation
  (SFc2_Non_linear_simulationInstanceStruct *chartInstance);
static void initialize_params_c2_Non_linear_simulation
  (SFc2_Non_linear_simulationInstanceStruct *chartInstance);
static void enable_c2_Non_linear_simulation
  (SFc2_Non_linear_simulationInstanceStruct *chartInstance);
static void disable_c2_Non_linear_simulation
  (SFc2_Non_linear_simulationInstanceStruct *chartInstance);
static void c2_do_animation_call_c2_Non_linear_simulation
  (SFc2_Non_linear_simulationInstanceStruct *chartInstance);
static void ext_mode_exec_c2_Non_linear_simulation
  (SFc2_Non_linear_simulationInstanceStruct *chartInstance);
static const mxArray *get_sim_state_c2_Non_linear_simulation
  (SFc2_Non_linear_simulationInstanceStruct *chartInstance);
static void set_sim_state_c2_Non_linear_simulation
  (SFc2_Non_linear_simulationInstanceStruct *chartInstance, const mxArray *c2_st);
static void sf_gateway_c2_Non_linear_simulation
  (SFc2_Non_linear_simulationInstanceStruct *chartInstance);
static void mdl_start_c2_Non_linear_simulation
  (SFc2_Non_linear_simulationInstanceStruct *chartInstance);
static void mdl_terminate_c2_Non_linear_simulation
  (SFc2_Non_linear_simulationInstanceStruct *chartInstance);
static void mdl_setup_runtime_resources_c2_Non_linear_simulation
  (SFc2_Non_linear_simulationInstanceStruct *chartInstance);
static void mdl_cleanup_runtime_resources_c2_Non_linear_simulation
  (SFc2_Non_linear_simulationInstanceStruct *chartInstance);
static void initSimStructsc2_Non_linear_simulation
  (SFc2_Non_linear_simulationInstanceStruct *chartInstance);
static void c2_eML_blk_kernel(SFc2_Non_linear_simulationInstanceStruct
  *chartInstance, real_T c2_b_signals[3], real_T c2_b_iterationCounter, real_T
  c2_b_armPartPatchHandle, real_T c2_b_pendPartPatchHandle, real_T
  c2_b_drivePartPatchHandle, real_T c2_b_thetaPlotHandle, real_T
  c2_b_alphaPlotHandle, real_T c2_b_frameRate, real_T c2_b_armPartVertices[88224],
  real_T c2_b_drivePartVertices[14976], real_T c2_b_pendPartVertices[26064]);
static uint8_T c2_emlrt_marshallIn(SFc2_Non_linear_simulationInstanceStruct
  *chartInstance, const mxArray *c2_b_is_active_c2_Non_linear_simulation, const
  char_T *c2_identifier);
static uint8_T c2_b_emlrt_marshallIn(SFc2_Non_linear_simulationInstanceStruct
  *chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId);
static void c2_set(SFc2_Non_linear_simulationInstanceStruct *chartInstance,
                   const mxArray *c2_input0, const mxArray *c2_input1, const
                   mxArray *c2_input2, const mxArray *c2_input3, const mxArray
                   *c2_input4);
static void c2_b_set(SFc2_Non_linear_simulationInstanceStruct *chartInstance,
                     const mxArray *c2_input0, const mxArray *c2_input1, const
                     mxArray *c2_input2, const mxArray *c2_input3, const mxArray
                     *c2_input4);
static void c2_c_set(SFc2_Non_linear_simulationInstanceStruct *chartInstance,
                     const mxArray *c2_input0, const mxArray *c2_input1, const
                     mxArray *c2_input2, const mxArray *c2_input3, const mxArray
                     *c2_input4, const mxArray *c2_input5, const mxArray
                     *c2_input6);
static void c2_d_set(SFc2_Non_linear_simulationInstanceStruct *chartInstance,
                     const mxArray *c2_input0, const mxArray *c2_input1, const
                     mxArray *c2_input2, const mxArray *c2_input3, const mxArray
                     *c2_input4, const mxArray *c2_input5, const mxArray
                     *c2_input6);
static void c2_e_set(SFc2_Non_linear_simulationInstanceStruct *chartInstance,
                     const mxArray *c2_input0, const mxArray *c2_input1, const
                     mxArray *c2_input2, const mxArray *c2_input3, const mxArray
                     *c2_input4, const mxArray *c2_input5, const mxArray
                     *c2_input6);
static const mxArray *c2_get(SFc2_Non_linear_simulationInstanceStruct
  *chartInstance, const mxArray *c2_input0, const mxArray *c2_input1);
static const mxArray *c2_horzcat(SFc2_Non_linear_simulationInstanceStruct
  *chartInstance, const mxArray *c2_input0, const mxArray *c2_input1);
static const mxArray *c2_b_get(SFc2_Non_linear_simulationInstanceStruct
  *chartInstance, const mxArray *c2_input0, const mxArray *c2_input1);
static const mxArray *c2_b_horzcat(SFc2_Non_linear_simulationInstanceStruct
  *chartInstance, const mxArray *c2_input0, const mxArray *c2_input1);
static void c2_f_set(SFc2_Non_linear_simulationInstanceStruct *chartInstance,
                     const mxArray *c2_input0, const mxArray *c2_input1, const
                     mxArray *c2_input2, const mxArray *c2_input3, const mxArray
                     *c2_input4);
static const mxArray *c2_c_get(SFc2_Non_linear_simulationInstanceStruct
  *chartInstance, const mxArray *c2_input0, const mxArray *c2_input1);
static const mxArray *c2_c_horzcat(SFc2_Non_linear_simulationInstanceStruct
  *chartInstance, const mxArray *c2_input0, const mxArray *c2_input1);
static const mxArray *c2_d_get(SFc2_Non_linear_simulationInstanceStruct
  *chartInstance, const mxArray *c2_input0, const mxArray *c2_input1);
static const mxArray *c2_d_horzcat(SFc2_Non_linear_simulationInstanceStruct
  *chartInstance, const mxArray *c2_input0, const mxArray *c2_input1);
static void c2_g_set(SFc2_Non_linear_simulationInstanceStruct *chartInstance,
                     const mxArray *c2_input0, const mxArray *c2_input1, const
                     mxArray *c2_input2, const mxArray *c2_input3, const mxArray
                     *c2_input4);
static __global__ void c2_eML_blk_kernel_kernel1(const real_T c2_sy, const
  real_T c2_cy, const real_T c2_b_sy, const real_T c2_b_cy, real_T
  c2_BaseToDrive[16], real_T c2_BaseToArm[16]);
static __global__ void c2_eML_blk_kernel_kernel2(const int8_T c2_b_dv1[4], const
  real_T c2_dv[4], real_T c2_BaseToDrive[16], real_T c2_BaseToArm[16]);
static __global__ void c2_eML_blk_kernel_kernel3(real_T
  c2_armPart_vertices_G_frame[88224]);
static __global__ void c2_eML_blk_kernel_kernel4(real_T c2_b_Zt[22056], real_T
  c2_armPart_vertices_G_frame[22056], real_T c2_b_Yt[22056], real_T
  c2_b_armPart_vertices_G_frame[22056], real_T c2_c_Xt[22056], real_T
  c2_c_armPart_vertices_G_frame[88224], real_T c2_d_armPart_vertices_G_frame
  [22056]);
static __global__ void c2_eML_blk_kernel_kernel5(const real_T c2_sr, const
  real_T c2_cr, real_T c2_dv[16]);
static __global__ void c2_eML_blk_kernel_kernel6(const int8_T c2_b_dv1[4],
  real_T c2_dv[16]);
static __global__ void c2_eML_blk_kernel_kernel7(const real_T c2_dv[16], real_T
  c2_BaseToArm[16], real_T c2_y[16]);
static __global__ void c2_eML_blk_kernel_kernel8(real_T
  c2_pendPart_vertices_G_frame[26064]);
static __global__ void c2_eML_blk_kernel_kernel9(real_T c2_b_Zt[6516], real_T
  c2_pendPart_vertices_G_frame[6516], real_T c2_b_Yt[6516], real_T
  c2_b_pendPart_vertices_G_frame[6516], real_T c2_c_Xt[6516], real_T
  c2_c_pendPart_vertices_G_frame[26064], real_T c2_d_pendPart_vertices_G_frame
  [6516]);
static __global__ void c2_eML_blk_kernel_kernel10(real_T
  c2_drivePart_vertices_G_frame[14976]);
static __global__ void c2_eML_blk_kernel_kernel11(real_T c2_b_Zt[3744], real_T
  c2_drivePart_vertices_G_frame[3744], real_T c2_b_Yt[3744], real_T
  c2_b_drivePart_vertices_G_frame[3744], real_T c2_c_Xt[3744], real_T
  c2_c_drivePart_vertices_G_frame[14976], real_T
  c2_d_drivePart_vertices_G_frame[3744]);
static void init_dsm_address_info(SFc2_Non_linear_simulationInstanceStruct
  *chartInstance);
static void init_simulink_io_address(SFc2_Non_linear_simulationInstanceStruct
  *chartInstance);

/* Function Definitions */
static void initialize_c2_Non_linear_simulation
  (SFc2_Non_linear_simulationInstanceStruct *chartInstance)
{
  emlrtLicenseCheckR2012b(chartInstance->c2_fEmlrtCtx,
    "distrib_computing_toolbox", 2);
  sim_mode_is_external(chartInstance->S);
  _sfTime_ = sf_get_time(chartInstance->S);
  chartInstance->c2_is_active_c2_Non_linear_simulation = 0U;
  cublasEnsureInitialization(CUBLAS_POINTER_MODE_DEVICE);
  cudaGetLastError();
  cudaMalloc(&chartInstance->c2_d_gpu_armPart_vertices_G_frame, 176448UL);
  cudaMalloc(&chartInstance->c2_gpu_BaseToDrive, 128UL);
  cudaMalloc(&chartInstance->c2_b_gpu_sy, 8UL);
  cudaMalloc(&chartInstance->c2_gpu_BaseToArm, 128UL);
  cudaMalloc(&chartInstance->c2_gpu_drivePartVertices, 119808UL);
  cudaMalloc(&chartInstance->c2_gpu_drivePart_vertices_G_frame, 119808UL);
  cudaMalloc(&chartInstance->c2_gpu_Yt, 52128UL);
  cudaMalloc(&chartInstance->c2_b_gpu_alpha1, 8UL);
  cudaMalloc(&chartInstance->c2_b_gpu_armPart_vertices_G_frame, 176448UL);
  cudaMalloc(&chartInstance->c2_gpu_alpha1, 8UL);
  cudaMalloc(&chartInstance->c2_gpu_Zt, 29952UL);
  cudaMalloc(&chartInstance->c2_gpu_armPart_vertices_G_frame, 705792UL);
  cudaMalloc(&chartInstance->c2_gpu_sr, 8UL);
  cudaMalloc(&chartInstance->c2_c_gpu_pendPart_vertices_G_frame, 52128UL);
  cudaMalloc(&chartInstance->c2_gpu_beta1, 8UL);
  cudaMalloc(&chartInstance->c2_c_gpu_Zt, 176448UL);
  cudaMalloc(&chartInstance->c2_d_gpu_pendPart_vertices_G_frame, 52128UL);
  cudaMalloc(&chartInstance->c2_b_gpu_beta1, 8UL);
  cudaMalloc(&chartInstance->c2_gpu_Xt, 176448UL);
  cudaMalloc(&chartInstance->c2_b_gpu_Xt, 52128UL);
  cudaMalloc(&chartInstance->c2_c_gpu_alpha1, 8UL);
  cudaMalloc(&chartInstance->c2_b_gpu_dv, 128UL);
  cudaMalloc(&chartInstance->c2_gpu_dv1, 4UL);
  cudaMalloc(&chartInstance->c2_gpu_cy, 8UL);
  cudaMalloc(&chartInstance->c2_b_gpu_Zt, 52128UL);
  cudaMalloc(&chartInstance->c2_d_gpu_drivePart_vertices_G_frame, 29952UL);
  cudaMalloc(&chartInstance->c2_c_gpu_armPart_vertices_G_frame, 176448UL);
  cudaMalloc(&chartInstance->c2_b_gpu_Yt, 29952UL);
  cudaMalloc(&chartInstance->c2_b_gpu_cy, 8UL);
  cudaMalloc(&chartInstance->c2_c_gpu_Yt, 176448UL);
  cudaMalloc(&chartInstance->c2_b_gpu_pendPart_vertices_G_frame, 208512UL);
  cudaMalloc(&chartInstance->c2_gpu_sy, 8UL);
  cudaMalloc(&chartInstance->c2_gpu_dv, 32UL);
  cudaMalloc(&chartInstance->c2_gpu_pendPart_vertices_G_frame, 52128UL);
  cudaMalloc(&chartInstance->c2_c_gpu_Xt, 29952UL);
  cudaMalloc(&chartInstance->c2_b_gpu_drivePart_vertices_G_frame, 29952UL);
  cudaMalloc(&chartInstance->c2_c_gpu_drivePart_vertices_G_frame, 29952UL);
  cudaMalloc(&chartInstance->c2_gpu_armPartVertices, 705792UL);
  cudaMalloc(&chartInstance->c2_c_gpu_beta1, 8UL);
  cudaMalloc(&chartInstance->c2_gpu_y, 128UL);
  cudaMalloc(&chartInstance->c2_gpu_cr, 8UL);
  cudaMalloc(&chartInstance->c2_gpu_pendPartVertices, 208512UL);
}

static void initialize_params_c2_Non_linear_simulation
  (SFc2_Non_linear_simulationInstanceStruct *chartInstance)
{
}

static void enable_c2_Non_linear_simulation
  (SFc2_Non_linear_simulationInstanceStruct *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void disable_c2_Non_linear_simulation
  (SFc2_Non_linear_simulationInstanceStruct *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void c2_do_animation_call_c2_Non_linear_simulation
  (SFc2_Non_linear_simulationInstanceStruct *chartInstance)
{
  sfDoAnimationWrapper(chartInstance->S, false, true);
  sfDoAnimationWrapper(chartInstance->S, false, false);
}

static void ext_mode_exec_c2_Non_linear_simulation
  (SFc2_Non_linear_simulationInstanceStruct *chartInstance)
{
}

static const mxArray *get_sim_state_c2_Non_linear_simulation
  (SFc2_Non_linear_simulationInstanceStruct *chartInstance)
{
  const mxArray *c2_b_y = NULL;
  const mxArray *c2_st = NULL;
  const mxArray *c2_y = NULL;
  c2_st = NULL;
  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_createcellmatrix(1, 1), false);
  c2_b_y = NULL;
  sf_mex_assign(&c2_b_y, sf_mex_create("y",
    &chartInstance->c2_is_active_c2_Non_linear_simulation, 3, 0U, 0U, 0U, 0),
                false);
  sf_mex_setcell(c2_y, 0, c2_b_y);
  sf_mex_assign(&c2_st, c2_y, false);
  return c2_st;
}

static void set_sim_state_c2_Non_linear_simulation
  (SFc2_Non_linear_simulationInstanceStruct *chartInstance, const mxArray *c2_st)
{
  const mxArray *c2_u;
  c2_u = sf_mex_dup(c2_st);
  chartInstance->c2_is_active_c2_Non_linear_simulation = c2_emlrt_marshallIn
    (chartInstance, sf_mex_dup(sf_mex_getcell(c2_u, 0)),
     "is_active_c2_Non_linear_simulation");
  sf_mex_destroy(&c2_u);
  sf_mex_destroy(&c2_st);
}

static void sf_gateway_c2_Non_linear_simulation
  (SFc2_Non_linear_simulationInstanceStruct *chartInstance)
{
  real_T c2_dv[3];
  int32_T c2_i;
  int32_T c2_i1;
  int32_T c2_i2;
  int32_T c2_i3;
  chartInstance->c2_JITTransitionAnimation[0] = 0U;
  _sfTime_ = sf_get_time(chartInstance->S);
  for (c2_i = 0; c2_i < 3; c2_i++) {
    c2_dv[c2_i] = (*chartInstance->c2_signals)[c2_i];
  }

  for (c2_i1 = 0; c2_i1 < 88224; c2_i1++) {
    chartInstance->c2_dv1[c2_i1] = (*chartInstance->c2_armPartVertices)[c2_i1];
  }

  for (c2_i2 = 0; c2_i2 < 14976; c2_i2++) {
    chartInstance->c2_dv2[c2_i2] = (*chartInstance->c2_drivePartVertices)[c2_i2];
  }

  for (c2_i3 = 0; c2_i3 < 26064; c2_i3++) {
    chartInstance->c2_dv3[c2_i3] = (*chartInstance->c2_pendPartVertices)[c2_i3];
  }

  c2_eML_blk_kernel(chartInstance, c2_dv, *chartInstance->c2_iterationCounter,
                    *chartInstance->c2_armPartPatchHandle,
                    *chartInstance->c2_pendPartPatchHandle,
                    *chartInstance->c2_drivePartPatchHandle,
                    *chartInstance->c2_thetaPlotHandle,
                    *chartInstance->c2_alphaPlotHandle,
                    *chartInstance->c2_frameRate, chartInstance->c2_dv1,
                    chartInstance->c2_dv2, chartInstance->c2_dv3);
  c2_do_animation_call_c2_Non_linear_simulation(chartInstance);
}

static void mdl_start_c2_Non_linear_simulation
  (SFc2_Non_linear_simulationInstanceStruct *chartInstance)
{
}

static void mdl_terminate_c2_Non_linear_simulation
  (SFc2_Non_linear_simulationInstanceStruct *chartInstance)
{
  cudaError_t c2_errCode;
  cudaFree(*chartInstance->c2_c_gpu_pendPart_vertices_G_frame);
  cudaFree(*chartInstance->c2_b_gpu_Yt);
  cudaFree(*chartInstance->c2_c_gpu_Zt);
  cudaFree(*chartInstance->c2_b_gpu_dv);
  cudaFree(chartInstance->c2_c_gpu_alpha1);
  cudaFree(*chartInstance->c2_gpu_drivePart_vertices_G_frame);
  cudaFree(*chartInstance->c2_c_gpu_Yt);
  cudaFree(*chartInstance->c2_gpu_Xt);
  cudaFree(*chartInstance->c2_b_gpu_pendPart_vertices_G_frame);
  cudaFree(*chartInstance->c2_gpu_armPart_vertices_G_frame);
  cudaFree(*chartInstance->c2_gpu_BaseToDrive);
  cudaFree(*chartInstance->c2_c_gpu_armPart_vertices_G_frame);
  cudaFree(chartInstance->c2_gpu_sr);
  cudaFree(chartInstance->c2_gpu_cy);
  cudaFree(chartInstance->c2_gpu_alpha1);
  cudaFree(chartInstance->c2_c_gpu_beta1);
  cudaFree(*chartInstance->c2_gpu_Yt);
  cudaFree(chartInstance->c2_b_gpu_cy);
  cudaFree(*chartInstance->c2_gpu_drivePartVertices);
  cudaFree(chartInstance->c2_b_gpu_sy);
  cudaFree(*chartInstance->c2_c_gpu_drivePart_vertices_G_frame);
  cudaFree(*chartInstance->c2_b_gpu_armPart_vertices_G_frame);
  cudaFree(chartInstance->c2_gpu_beta1);
  cudaFree(chartInstance->c2_gpu_sy);
  cudaFree(*chartInstance->c2_gpu_armPartVertices);
  cudaFree(*chartInstance->c2_b_gpu_drivePart_vertices_G_frame);
  cudaFree(*chartInstance->c2_b_gpu_Zt);
  cudaFree(*chartInstance->c2_d_gpu_armPart_vertices_G_frame);
  cudaFree(chartInstance->c2_b_gpu_alpha1);
  cudaFree(*chartInstance->c2_d_gpu_drivePart_vertices_G_frame);
  cudaFree(*chartInstance->c2_c_gpu_Xt);
  cudaFree(*chartInstance->c2_b_gpu_Xt);
  cudaFree(chartInstance->c2_gpu_cr);
  cudaFree(*chartInstance->c2_gpu_pendPartVertices);
  cudaFree(*chartInstance->c2_gpu_y);
  cudaFree(*chartInstance->c2_gpu_pendPart_vertices_G_frame);
  cudaFree(*chartInstance->c2_gpu_Zt);
  cudaFree(*chartInstance->c2_gpu_BaseToArm);
  cudaFree(*chartInstance->c2_d_gpu_pendPart_vertices_G_frame);
  cudaFree(chartInstance->c2_b_gpu_beta1);
  cudaFree(*chartInstance->c2_gpu_dv1);
  cudaFree(*chartInstance->c2_gpu_dv);
  c2_errCode = cudaGetLastError();
  if (c2_errCode != cudaSuccess) {
    emlrtThinCUDAError(c2_errCode, cudaGetErrorName(c2_errCode),
                       cudaGetErrorString(c2_errCode), "SimGPUErrorChecks",
                       chartInstance->c2_fEmlrtCtx);
  }

  cublasEnsureDestruction();
}

static void mdl_setup_runtime_resources_c2_Non_linear_simulation
  (SFc2_Non_linear_simulationInstanceStruct *chartInstance)
{
  setLegacyDebuggerFlag(chartInstance->S, false);
  setDebuggerFlag(chartInstance->S, false);
  sim_mode_is_external(chartInstance->S);
}

static void mdl_cleanup_runtime_resources_c2_Non_linear_simulation
  (SFc2_Non_linear_simulationInstanceStruct *chartInstance)
{
}

static void initSimStructsc2_Non_linear_simulation
  (SFc2_Non_linear_simulationInstanceStruct *chartInstance)
{
}

const mxArray *sf_c2_Non_linear_simulation_get_eml_resolved_functions_info()
{
  const mxArray *c2_nameCaptureInfo = NULL;
  c2_nameCaptureInfo = NULL;
  sf_mex_assign(&c2_nameCaptureInfo, sf_mex_create("nameCaptureInfo", NULL, 0,
    0U, 1U, 0U, 2, 0, 1), false);
  return c2_nameCaptureInfo;
}

static void c2_eML_blk_kernel(SFc2_Non_linear_simulationInstanceStruct
  *chartInstance, real_T c2_b_signals[3], real_T c2_b_iterationCounter, real_T
  c2_b_armPartPatchHandle, real_T c2_b_pendPartPatchHandle, real_T
  c2_b_drivePartPatchHandle, real_T c2_b_thetaPlotHandle, real_T
  c2_b_alphaPlotHandle, real_T c2_b_frameRate, real_T c2_b_armPartVertices[88224],
  real_T c2_b_drivePartVertices[14976], real_T c2_b_pendPartVertices[26064])
{
  static real_T c2_dv[4] = { -0.0, 0.0, 1.0, 0.12 };

  static char_T c2_cv[5] = { 'x', 'D', 'a', 't', 'a' };

  static char_T c2_cv1[5] = { 'y', 'D', 'a', 't', 'a' };

  static char_T c2_cv2[5] = { 'z', 'D', 'a', 't', 'a' };

  static char_T c2_cv3[5] = { 'x', 'd', 'a', 't', 'a' };

  static char_T c2_cv4[5] = { 'y', 'd', 'a', 't', 'a' };

  static int8_T c2_b_dv1[4] = { 0, 0, 0, 1 };

  const mxArray *c2_ab_y = NULL;
  const mxArray *c2_alphaAngles = NULL;
  const mxArray *c2_b_y = NULL;
  const mxArray *c2_bb_y = NULL;
  const mxArray *c2_c_y = NULL;
  const mxArray *c2_cb_y = NULL;
  const mxArray *c2_d_y = NULL;
  const mxArray *c2_db_y = NULL;
  const mxArray *c2_e_y = NULL;
  const mxArray *c2_eb_y = NULL;
  const mxArray *c2_f_y = NULL;
  const mxArray *c2_fb_y = NULL;
  const mxArray *c2_g_y = NULL;
  const mxArray *c2_gb_y = NULL;
  const mxArray *c2_h_y = NULL;
  const mxArray *c2_hb_y = NULL;
  const mxArray *c2_i_y = NULL;
  const mxArray *c2_ib_y = NULL;
  const mxArray *c2_j_y = NULL;
  const mxArray *c2_jb_y = NULL;
  const mxArray *c2_k_y = NULL;
  const mxArray *c2_kb_y = NULL;
  const mxArray *c2_l_y = NULL;
  const mxArray *c2_lb_y = NULL;
  const mxArray *c2_m_y = NULL;
  const mxArray *c2_mb_y = NULL;
  const mxArray *c2_n_y = NULL;
  const mxArray *c2_nb_y = NULL;
  const mxArray *c2_o_y = NULL;
  const mxArray *c2_ob_y = NULL;
  const mxArray *c2_p_y = NULL;
  const mxArray *c2_pb_y = NULL;
  const mxArray *c2_q_y = NULL;
  const mxArray *c2_qb_y = NULL;
  const mxArray *c2_r_y = NULL;
  const mxArray *c2_rb_y = NULL;
  const mxArray *c2_s_y = NULL;
  const mxArray *c2_sb_y = NULL;
  const mxArray *c2_t_y = NULL;
  const mxArray *c2_tb_y = NULL;
  const mxArray *c2_thetaAngles = NULL;
  const mxArray *c2_times = NULL;
  const mxArray *c2_u_y = NULL;
  const mxArray *c2_ub_y = NULL;
  const mxArray *c2_v_y = NULL;
  const mxArray *c2_vb_y = NULL;
  const mxArray *c2_w_y = NULL;
  const mxArray *c2_wb_y = NULL;
  const mxArray *c2_x_y = NULL;
  const mxArray *c2_xb_y = NULL;
  const mxArray *c2_y = NULL;
  const mxArray *c2_y_y = NULL;
  real_T c2_b_Yt[6516];
  real_T c2_b_Zt[6516];
  real_T c2_c_Xt[3744];
  real_T c2_c_Yt[3744];
  real_T c2_c_Zt[3744];
  real_T c2_b_dv[16];
  real_T c2_YAW;
  real_T c2_alpha1;
  real_T c2_b_alpha1;
  real_T c2_b_beta1;
  real_T c2_b_u;
  real_T c2_beta1;
  real_T c2_c_alpha1;
  real_T c2_c_beta1;
  real_T c2_c_u;
  real_T c2_cr;
  real_T c2_currentTime;
  real_T c2_d_u;
  real_T c2_e_u;
  real_T c2_f_u;
  real_T c2_q;
  real_T c2_r;
  real_T c2_sr;
  real_T c2_u;
  boolean_T c2_dv1_dirtyOnCpu;
  boolean_T c2_rEQ0;
  if (c2_b_iterationCounter == 0.0) {
    c2_y = NULL;
    sf_mex_assign(&c2_y, sf_mex_create("y", &c2_b_thetaPlotHandle, 0, 0U, 0U, 0U,
      0), false);
    c2_b_y = NULL;
    sf_mex_assign(&c2_b_y, sf_mex_create("y", c2_cv, 10, 0U, 1U, 0U, 2, 1, 5),
                  false);
    c2_u = rtInf;
    c2_c_y = NULL;
    sf_mex_assign(&c2_c_y, sf_mex_create("y", &c2_u, 0, 0U, 0U, 0U, 0), false);
    c2_d_y = NULL;
    sf_mex_assign(&c2_d_y, sf_mex_create("y", c2_cv1, 10, 0U, 1U, 0U, 2, 1, 5),
                  false);
    c2_b_u = rtInf;
    c2_e_y = NULL;
    sf_mex_assign(&c2_e_y, sf_mex_create("y", &c2_b_u, 0, 0U, 0U, 0U, 0), false);
    c2_set(chartInstance, c2_y, c2_b_y, c2_c_y, c2_d_y, c2_e_y);
    c2_f_y = NULL;
    sf_mex_assign(&c2_f_y, sf_mex_create("y", &c2_b_alphaPlotHandle, 0, 0U, 0U,
      0U, 0), false);
    c2_g_y = NULL;
    sf_mex_assign(&c2_g_y, sf_mex_create("y", c2_cv, 10, 0U, 1U, 0U, 2, 1, 5),
                  false);
    c2_c_u = rtInf;
    c2_h_y = NULL;
    sf_mex_assign(&c2_h_y, sf_mex_create("y", &c2_c_u, 0, 0U, 0U, 0U, 0), false);
    c2_i_y = NULL;
    sf_mex_assign(&c2_i_y, sf_mex_create("y", c2_cv1, 10, 0U, 1U, 0U, 2, 1, 5),
                  false);
    c2_d_u = rtInf;
    c2_k_y = NULL;
    sf_mex_assign(&c2_k_y, sf_mex_create("y", &c2_d_u, 0, 0U, 0U, 0U, 0), false);
    c2_b_set(chartInstance, c2_f_y, c2_g_y, c2_h_y, c2_i_y, c2_k_y);
  }

  if (muDoubleScalarIsNaN(c2_b_iterationCounter) || muDoubleScalarIsInf
      (c2_b_iterationCounter)) {
    c2_r = rtNaN;
  } else if (c2_b_iterationCounter == 0.0) {
    c2_r = 0.0;
  } else {
    c2_r = muDoubleScalarRem(c2_b_iterationCounter, 0.005);
    c2_rEQ0 = (c2_r == 0.0);
    if (!c2_rEQ0) {
      c2_q = muDoubleScalarAbs(c2_b_iterationCounter / 0.005);
      c2_rEQ0 = !(muDoubleScalarAbs(c2_q - muDoubleScalarFloor(c2_q + 0.5)) >
                  2.2204460492503131E-16 * c2_q);
    }

    if (c2_rEQ0) {
      c2_r = 0.0;
    } else {
      if (c2_b_iterationCounter < 0.0) {
        c2_r += 0.005;
      }
    }
  }

  if (c2_r == 0.0) {
    c2_currentTime = c2_b_signals[2];
    c2_cr = muDoubleScalarCos(c2_b_signals[0]);
    c2_sr = muDoubleScalarSin(c2_b_signals[0]);
    c2_YAW = -c2_b_signals[1] * 5.0;
    c2_eML_blk_kernel_kernel1<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
      (muDoubleScalarSin(c2_YAW), muDoubleScalarCos(c2_YAW), muDoubleScalarSin
       (c2_b_signals[1]), muDoubleScalarCos(c2_b_signals[1]),
       *chartInstance->c2_gpu_BaseToDrive, *chartInstance->c2_gpu_BaseToArm);
    cudaMemcpy(chartInstance->c2_gpu_dv1, &c2_b_dv1[0], 4UL,
               cudaMemcpyHostToDevice);
    c2_dv1_dirtyOnCpu = false;
    cudaMemcpy(chartInstance->c2_gpu_dv, &c2_dv[0], 32UL, cudaMemcpyHostToDevice);
    c2_eML_blk_kernel_kernel2<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
      (*chartInstance->c2_gpu_dv1, *chartInstance->c2_gpu_dv,
       *chartInstance->c2_gpu_BaseToDrive, *chartInstance->c2_gpu_BaseToArm);
    c2_alpha1 = 1.0;
    c2_beta1 = 0.0;
    c2_eML_blk_kernel_kernel3<<<dim3(173U, 1U, 1U), dim3(512U, 1U, 1U)>>>
      (*chartInstance->c2_gpu_armPart_vertices_G_frame);
    cudaMemcpy(chartInstance->c2_b_gpu_alpha1, &c2_alpha1, 8UL,
               cudaMemcpyHostToDevice);
    cudaMemcpy(chartInstance->c2_gpu_armPartVertices, &c2_b_armPartVertices[0],
               705792UL, cudaMemcpyHostToDevice);
    cudaMemcpy(chartInstance->c2_b_gpu_beta1, &c2_beta1, 8UL,
               cudaMemcpyHostToDevice);
    cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N, 4, 22056, 4,
                (double *)chartInstance->c2_b_gpu_alpha1, (double *)
                &(*chartInstance->c2_gpu_BaseToArm)[0], 4, (double *)
                &(*chartInstance->c2_gpu_armPartVertices)[0], 4, (double *)
                chartInstance->c2_b_gpu_beta1, (double *)
                &(*chartInstance->c2_gpu_armPart_vertices_G_frame)[0], 4);
    c2_eML_blk_kernel_kernel4<<<dim3(44U, 1U, 1U), dim3(512U, 1U, 1U)>>>
      (*chartInstance->c2_c_gpu_Zt,
       *chartInstance->c2_b_gpu_armPart_vertices_G_frame,
       *chartInstance->c2_c_gpu_Yt,
       *chartInstance->c2_d_gpu_armPart_vertices_G_frame,
       *chartInstance->c2_gpu_Xt,
       *chartInstance->c2_gpu_armPart_vertices_G_frame,
       *chartInstance->c2_c_gpu_armPart_vertices_G_frame);
    c2_j_y = NULL;
    sf_mex_assign(&c2_j_y, sf_mex_create("y", &c2_b_armPartPatchHandle, 0, 0U,
      0U, 0U, 0), false);
    c2_l_y = NULL;
    sf_mex_assign(&c2_l_y, sf_mex_create("y", c2_cv, 10, 0U, 1U, 0U, 2, 1, 5),
                  false);
    c2_m_y = NULL;
    cudaMemcpy(&chartInstance->c2_Xt[0], chartInstance->c2_gpu_Xt, 176448UL,
               cudaMemcpyDeviceToHost);
    sf_mex_assign(&c2_m_y, sf_mex_create("y", chartInstance->c2_Xt, 0, 0U, 1U,
      0U, 2, 3, 7352), false);
    c2_n_y = NULL;
    sf_mex_assign(&c2_n_y, sf_mex_create("y", c2_cv1, 10, 0U, 1U, 0U, 2, 1, 5),
                  false);
    c2_o_y = NULL;
    cudaMemcpy(&chartInstance->c2_Yt[0], chartInstance->c2_c_gpu_Yt, 176448UL,
               cudaMemcpyDeviceToHost);
    sf_mex_assign(&c2_o_y, sf_mex_create("y", chartInstance->c2_Yt, 0, 0U, 1U,
      0U, 2, 3, 7352), false);
    c2_p_y = NULL;
    sf_mex_assign(&c2_p_y, sf_mex_create("y", c2_cv2, 10, 0U, 1U, 0U, 2, 1, 5),
                  false);
    c2_q_y = NULL;
    cudaMemcpy(&chartInstance->c2_Zt[0], chartInstance->c2_c_gpu_Zt, 176448UL,
               cudaMemcpyDeviceToHost);
    sf_mex_assign(&c2_q_y, sf_mex_create("y", chartInstance->c2_Zt, 0, 0U, 1U,
      0U, 2, 3, 7352), false);
    c2_c_set(chartInstance, c2_j_y, c2_l_y, c2_m_y, c2_n_y, c2_o_y, c2_p_y,
             c2_q_y);
    c2_b_dv[0] = 1.0;
    c2_b_dv[4] = 0.0 * c2_sr - 0.0 * c2_cr;
    cudaMemcpy(chartInstance->c2_b_gpu_dv, &c2_b_dv[0], 128UL,
               cudaMemcpyHostToDevice);
    c2_eML_blk_kernel_kernel5<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(c2_sr,
      c2_cr, *chartInstance->c2_b_gpu_dv);
    if (c2_dv1_dirtyOnCpu) {
      cudaMemcpy(chartInstance->c2_gpu_dv1, &c2_b_dv1[0], 4UL,
                 cudaMemcpyHostToDevice);
    }

    c2_eML_blk_kernel_kernel6<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
      (*chartInstance->c2_gpu_dv1, *chartInstance->c2_b_gpu_dv);
    c2_eML_blk_kernel_kernel7<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
      (*chartInstance->c2_b_gpu_dv, *chartInstance->c2_gpu_BaseToArm,
       *chartInstance->c2_gpu_y);
    c2_b_alpha1 = 1.0;
    c2_b_beta1 = 0.0;
    c2_eML_blk_kernel_kernel8<<<dim3(51U, 1U, 1U), dim3(512U, 1U, 1U)>>>
      (*chartInstance->c2_b_gpu_pendPart_vertices_G_frame);
    cudaMemcpy(chartInstance->c2_c_gpu_alpha1, &c2_b_alpha1, 8UL,
               cudaMemcpyHostToDevice);
    cudaMemcpy(chartInstance->c2_gpu_pendPartVertices, &c2_b_pendPartVertices[0],
               208512UL, cudaMemcpyHostToDevice);
    cudaMemcpy(chartInstance->c2_gpu_beta1, &c2_b_beta1, 8UL,
               cudaMemcpyHostToDevice);
    cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N, 4, 6516, 4,
                (double *)chartInstance->c2_c_gpu_alpha1, (double *)
                &(*chartInstance->c2_gpu_y)[0], 4, (double *)
                &(*chartInstance->c2_gpu_pendPartVertices)[0], 4, (double *)
                chartInstance->c2_gpu_beta1, (double *)
                &(*chartInstance->c2_b_gpu_pendPart_vertices_G_frame)[0], 4);
    c2_eML_blk_kernel_kernel9<<<dim3(13U, 1U, 1U), dim3(512U, 1U, 1U)>>>
      (*chartInstance->c2_b_gpu_Zt,
       *chartInstance->c2_c_gpu_pendPart_vertices_G_frame,
       *chartInstance->c2_gpu_Yt,
       *chartInstance->c2_d_gpu_pendPart_vertices_G_frame,
       *chartInstance->c2_b_gpu_Xt,
       *chartInstance->c2_b_gpu_pendPart_vertices_G_frame,
       *chartInstance->c2_gpu_pendPart_vertices_G_frame);
    c2_r_y = NULL;
    sf_mex_assign(&c2_r_y, sf_mex_create("y", &c2_b_pendPartPatchHandle, 0, 0U,
      0U, 0U, 0), false);
    c2_s_y = NULL;
    sf_mex_assign(&c2_s_y, sf_mex_create("y", c2_cv, 10, 0U, 1U, 0U, 2, 1, 5),
                  false);
    c2_t_y = NULL;
    cudaMemcpy(&chartInstance->c2_b_Xt[0], chartInstance->c2_b_gpu_Xt, 52128UL,
               cudaMemcpyDeviceToHost);
    sf_mex_assign(&c2_t_y, sf_mex_create("y", chartInstance->c2_b_Xt, 0, 0U, 1U,
      0U, 2, 3, 2172), false);
    c2_u_y = NULL;
    sf_mex_assign(&c2_u_y, sf_mex_create("y", c2_cv1, 10, 0U, 1U, 0U, 2, 1, 5),
                  false);
    c2_v_y = NULL;
    cudaMemcpy(&c2_b_Yt[0], chartInstance->c2_gpu_Yt, 52128UL,
               cudaMemcpyDeviceToHost);
    sf_mex_assign(&c2_v_y, sf_mex_create("y", c2_b_Yt, 0, 0U, 1U, 0U, 2, 3, 2172),
                  false);
    c2_w_y = NULL;
    sf_mex_assign(&c2_w_y, sf_mex_create("y", c2_cv2, 10, 0U, 1U, 0U, 2, 1, 5),
                  false);
    c2_x_y = NULL;
    cudaMemcpy(&c2_b_Zt[0], chartInstance->c2_b_gpu_Zt, 52128UL,
               cudaMemcpyDeviceToHost);
    sf_mex_assign(&c2_x_y, sf_mex_create("y", c2_b_Zt, 0, 0U, 1U, 0U, 2, 3, 2172),
                  false);
    c2_d_set(chartInstance, c2_r_y, c2_s_y, c2_t_y, c2_u_y, c2_v_y, c2_w_y,
             c2_x_y);
    c2_c_alpha1 = 1.0;
    c2_c_beta1 = 0.0;
    c2_eML_blk_kernel_kernel10<<<dim3(30U, 1U, 1U), dim3(512U, 1U, 1U)>>>
      (*chartInstance->c2_gpu_drivePart_vertices_G_frame);
    cudaMemcpy(chartInstance->c2_gpu_alpha1, &c2_c_alpha1, 8UL,
               cudaMemcpyHostToDevice);
    cudaMemcpy(chartInstance->c2_gpu_drivePartVertices, &c2_b_drivePartVertices
               [0], 119808UL, cudaMemcpyHostToDevice);
    cudaMemcpy(chartInstance->c2_c_gpu_beta1, &c2_c_beta1, 8UL,
               cudaMemcpyHostToDevice);
    cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N, 4, 3744, 4,
                (double *)chartInstance->c2_gpu_alpha1, (double *)
                &(*chartInstance->c2_gpu_BaseToDrive)[0], 4, (double *)
                &(*chartInstance->c2_gpu_drivePartVertices)[0], 4, (double *)
                chartInstance->c2_c_gpu_beta1, (double *)
                &(*chartInstance->c2_gpu_drivePart_vertices_G_frame)[0], 4);
    c2_eML_blk_kernel_kernel11<<<dim3(8U, 1U, 1U), dim3(512U, 1U, 1U)>>>
      (*chartInstance->c2_gpu_Zt,
       *chartInstance->c2_d_gpu_drivePart_vertices_G_frame,
       *chartInstance->c2_b_gpu_Yt,
       *chartInstance->c2_b_gpu_drivePart_vertices_G_frame,
       *chartInstance->c2_c_gpu_Xt,
       *chartInstance->c2_gpu_drivePart_vertices_G_frame,
       *chartInstance->c2_c_gpu_drivePart_vertices_G_frame);
    c2_y_y = NULL;
    sf_mex_assign(&c2_y_y, sf_mex_create("y", &c2_b_drivePartPatchHandle, 0, 0U,
      0U, 0U, 0), false);
    c2_ab_y = NULL;
    sf_mex_assign(&c2_ab_y, sf_mex_create("y", c2_cv, 10, 0U, 1U, 0U, 2, 1, 5),
                  false);
    c2_bb_y = NULL;
    cudaMemcpy(&c2_c_Xt[0], chartInstance->c2_c_gpu_Xt, 29952UL,
               cudaMemcpyDeviceToHost);
    sf_mex_assign(&c2_bb_y, sf_mex_create("y", c2_c_Xt, 0, 0U, 1U, 0U, 2, 3,
      1248), false);
    c2_cb_y = NULL;
    sf_mex_assign(&c2_cb_y, sf_mex_create("y", c2_cv1, 10, 0U, 1U, 0U, 2, 1, 5),
                  false);
    c2_db_y = NULL;
    cudaMemcpy(&c2_c_Yt[0], chartInstance->c2_b_gpu_Yt, 29952UL,
               cudaMemcpyDeviceToHost);
    sf_mex_assign(&c2_db_y, sf_mex_create("y", c2_c_Yt, 0, 0U, 1U, 0U, 2, 3,
      1248), false);
    c2_eb_y = NULL;
    sf_mex_assign(&c2_eb_y, sf_mex_create("y", c2_cv2, 10, 0U, 1U, 0U, 2, 1, 5),
                  false);
    c2_fb_y = NULL;
    cudaMemcpy(&c2_c_Zt[0], chartInstance->c2_gpu_Zt, 29952UL,
               cudaMemcpyDeviceToHost);
    sf_mex_assign(&c2_fb_y, sf_mex_create("y", c2_c_Zt, 0, 0U, 1U, 0U, 2, 3,
      1248), false);
    c2_e_set(chartInstance, c2_y_y, c2_ab_y, c2_bb_y, c2_cb_y, c2_db_y, c2_eb_y,
             c2_fb_y);
    c2_gb_y = NULL;
    sf_mex_assign(&c2_gb_y, sf_mex_create("y", &c2_b_thetaPlotHandle, 0, 0U, 0U,
      0U, 0), false);
    c2_hb_y = NULL;
    sf_mex_assign(&c2_hb_y, sf_mex_create("y", c2_cv, 10, 0U, 1U, 0U, 2, 1, 5),
                  false);
    c2_ib_y = NULL;
    sf_mex_assign(&c2_ib_y, sf_mex_create("y", &c2_currentTime, 0, 0U, 0U, 0U, 0),
                  false);
    sf_mex_assign(&c2_times, c2_horzcat(chartInstance, c2_get(chartInstance,
      c2_gb_y, c2_hb_y), c2_ib_y), false);
    c2_jb_y = NULL;
    sf_mex_assign(&c2_jb_y, sf_mex_create("y", &c2_b_thetaPlotHandle, 0, 0U, 0U,
      0U, 0), false);
    c2_kb_y = NULL;
    sf_mex_assign(&c2_kb_y, sf_mex_create("y", c2_cv1, 10, 0U, 1U, 0U, 2, 1, 5),
                  false);
    c2_e_u = c2_b_signals[1] * 180.0 / 3.1415926535897931;
    c2_lb_y = NULL;
    sf_mex_assign(&c2_lb_y, sf_mex_create("y", &c2_e_u, 0, 0U, 0U, 0U, 0), false);
    sf_mex_assign(&c2_thetaAngles, c2_b_horzcat(chartInstance, c2_b_get
      (chartInstance, c2_jb_y, c2_kb_y), c2_lb_y), false);
    c2_mb_y = NULL;
    sf_mex_assign(&c2_mb_y, sf_mex_create("y", &c2_b_thetaPlotHandle, 0, 0U, 0U,
      0U, 0), false);
    c2_nb_y = NULL;
    sf_mex_assign(&c2_nb_y, sf_mex_create("y", c2_cv3, 10, 0U, 1U, 0U, 2, 1, 5),
                  false);
    c2_ob_y = NULL;
    sf_mex_assign(&c2_ob_y, sf_mex_create("y", c2_cv4, 10, 0U, 1U, 0U, 2, 1, 5),
                  false);
    c2_f_set(chartInstance, c2_mb_y, c2_nb_y, sf_mex_dup(c2_times), c2_ob_y,
             sf_mex_dup(c2_thetaAngles));
    c2_pb_y = NULL;
    sf_mex_assign(&c2_pb_y, sf_mex_create("y", &c2_b_alphaPlotHandle, 0, 0U, 0U,
      0U, 0), false);
    c2_qb_y = NULL;
    sf_mex_assign(&c2_qb_y, sf_mex_create("y", c2_cv, 10, 0U, 1U, 0U, 2, 1, 5),
                  false);
    c2_rb_y = NULL;
    sf_mex_assign(&c2_rb_y, sf_mex_create("y", &c2_currentTime, 0, 0U, 0U, 0U, 0),
                  false);
    sf_mex_assign(&c2_times, c2_c_horzcat(chartInstance, c2_c_get(chartInstance,
      c2_pb_y, c2_qb_y), c2_rb_y), false);
    c2_sb_y = NULL;
    sf_mex_assign(&c2_sb_y, sf_mex_create("y", &c2_b_alphaPlotHandle, 0, 0U, 0U,
      0U, 0), false);
    c2_tb_y = NULL;
    sf_mex_assign(&c2_tb_y, sf_mex_create("y", c2_cv1, 10, 0U, 1U, 0U, 2, 1, 5),
                  false);
    c2_f_u = c2_b_signals[0] * 180.0 / 3.1415926535897931;
    c2_ub_y = NULL;
    sf_mex_assign(&c2_ub_y, sf_mex_create("y", &c2_f_u, 0, 0U, 0U, 0U, 0), false);
    sf_mex_assign(&c2_alphaAngles, c2_d_horzcat(chartInstance, c2_d_get
      (chartInstance, c2_sb_y, c2_tb_y), c2_ub_y), false);
    c2_vb_y = NULL;
    sf_mex_assign(&c2_vb_y, sf_mex_create("y", &c2_b_alphaPlotHandle, 0, 0U, 0U,
      0U, 0), false);
    c2_wb_y = NULL;
    sf_mex_assign(&c2_wb_y, sf_mex_create("y", c2_cv3, 10, 0U, 1U, 0U, 2, 1, 5),
                  false);
    c2_xb_y = NULL;
    sf_mex_assign(&c2_xb_y, sf_mex_create("y", c2_cv4, 10, 0U, 1U, 0U, 2, 1, 5),
                  false);
    c2_g_set(chartInstance, c2_vb_y, c2_wb_y, sf_mex_dup(c2_times), c2_xb_y,
             sf_mex_dup(c2_alphaAngles));
  }

  sf_mex_destroy(&c2_times);
  sf_mex_destroy(&c2_thetaAngles);
  sf_mex_destroy(&c2_alphaAngles);
}

static uint8_T c2_emlrt_marshallIn(SFc2_Non_linear_simulationInstanceStruct
  *chartInstance, const mxArray *c2_b_is_active_c2_Non_linear_simulation, const
  char_T *c2_identifier)
{
  emlrtMsgIdentifier c2_thisId;
  uint8_T c2_y;
  c2_thisId.fIdentifier = const_cast<const char_T *>(c2_identifier);
  c2_thisId.fParent = NULL;
  c2_thisId.bParentIsCell = false;
  c2_y = c2_b_emlrt_marshallIn(chartInstance, sf_mex_dup
    (c2_b_is_active_c2_Non_linear_simulation), &c2_thisId);
  sf_mex_destroy(&c2_b_is_active_c2_Non_linear_simulation);
  return c2_y;
}

static uint8_T c2_b_emlrt_marshallIn(SFc2_Non_linear_simulationInstanceStruct
  *chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId)
{
  uint8_T c2_b_u;
  uint8_T c2_y;
  sf_mex_import(c2_parentId, sf_mex_dup(c2_u), &c2_b_u, 1, 3, 0U, 0, 0U, 0);
  c2_y = c2_b_u;
  sf_mex_destroy(&c2_u);
  return c2_y;
}

static void c2_set(SFc2_Non_linear_simulationInstanceStruct *chartInstance,
                   const mxArray *c2_input0, const mxArray *c2_input1, const
                   mxArray *c2_input2, const mxArray *c2_input3, const mxArray
                   *c2_input4)
{
  sf_mex_call(chartInstance->c2_fEmlrtCtx, NULL, "set", 0U, 5U, 14, sf_mex_dup
              (c2_input0), 14, sf_mex_dup(c2_input1), 14, sf_mex_dup(c2_input2),
              14, sf_mex_dup(c2_input3), 14, sf_mex_dup(c2_input4));
  sf_mex_destroy(&c2_input0);
  sf_mex_destroy(&c2_input1);
  sf_mex_destroy(&c2_input2);
  sf_mex_destroy(&c2_input3);
  sf_mex_destroy(&c2_input4);
}

static void c2_b_set(SFc2_Non_linear_simulationInstanceStruct *chartInstance,
                     const mxArray *c2_input0, const mxArray *c2_input1, const
                     mxArray *c2_input2, const mxArray *c2_input3, const mxArray
                     *c2_input4)
{
  sf_mex_call(chartInstance->c2_fEmlrtCtx, NULL, "set", 0U, 5U, 14, sf_mex_dup
              (c2_input0), 14, sf_mex_dup(c2_input1), 14, sf_mex_dup(c2_input2),
              14, sf_mex_dup(c2_input3), 14, sf_mex_dup(c2_input4));
  sf_mex_destroy(&c2_input0);
  sf_mex_destroy(&c2_input1);
  sf_mex_destroy(&c2_input2);
  sf_mex_destroy(&c2_input3);
  sf_mex_destroy(&c2_input4);
}

static void c2_c_set(SFc2_Non_linear_simulationInstanceStruct *chartInstance,
                     const mxArray *c2_input0, const mxArray *c2_input1, const
                     mxArray *c2_input2, const mxArray *c2_input3, const mxArray
                     *c2_input4, const mxArray *c2_input5, const mxArray
                     *c2_input6)
{
  sf_mex_call(chartInstance->c2_fEmlrtCtx, NULL, "set", 0U, 7U, 14, sf_mex_dup
              (c2_input0), 14, sf_mex_dup(c2_input1), 14, sf_mex_dup(c2_input2),
              14, sf_mex_dup(c2_input3), 14, sf_mex_dup(c2_input4), 14,
              sf_mex_dup(c2_input5), 14, sf_mex_dup(c2_input6));
  sf_mex_destroy(&c2_input0);
  sf_mex_destroy(&c2_input1);
  sf_mex_destroy(&c2_input2);
  sf_mex_destroy(&c2_input3);
  sf_mex_destroy(&c2_input4);
  sf_mex_destroy(&c2_input5);
  sf_mex_destroy(&c2_input6);
}

static void c2_d_set(SFc2_Non_linear_simulationInstanceStruct *chartInstance,
                     const mxArray *c2_input0, const mxArray *c2_input1, const
                     mxArray *c2_input2, const mxArray *c2_input3, const mxArray
                     *c2_input4, const mxArray *c2_input5, const mxArray
                     *c2_input6)
{
  sf_mex_call(chartInstance->c2_fEmlrtCtx, NULL, "set", 0U, 7U, 14, sf_mex_dup
              (c2_input0), 14, sf_mex_dup(c2_input1), 14, sf_mex_dup(c2_input2),
              14, sf_mex_dup(c2_input3), 14, sf_mex_dup(c2_input4), 14,
              sf_mex_dup(c2_input5), 14, sf_mex_dup(c2_input6));
  sf_mex_destroy(&c2_input0);
  sf_mex_destroy(&c2_input1);
  sf_mex_destroy(&c2_input2);
  sf_mex_destroy(&c2_input3);
  sf_mex_destroy(&c2_input4);
  sf_mex_destroy(&c2_input5);
  sf_mex_destroy(&c2_input6);
}

static void c2_e_set(SFc2_Non_linear_simulationInstanceStruct *chartInstance,
                     const mxArray *c2_input0, const mxArray *c2_input1, const
                     mxArray *c2_input2, const mxArray *c2_input3, const mxArray
                     *c2_input4, const mxArray *c2_input5, const mxArray
                     *c2_input6)
{
  sf_mex_call(chartInstance->c2_fEmlrtCtx, NULL, "set", 0U, 7U, 14, sf_mex_dup
              (c2_input0), 14, sf_mex_dup(c2_input1), 14, sf_mex_dup(c2_input2),
              14, sf_mex_dup(c2_input3), 14, sf_mex_dup(c2_input4), 14,
              sf_mex_dup(c2_input5), 14, sf_mex_dup(c2_input6));
  sf_mex_destroy(&c2_input0);
  sf_mex_destroy(&c2_input1);
  sf_mex_destroy(&c2_input2);
  sf_mex_destroy(&c2_input3);
  sf_mex_destroy(&c2_input4);
  sf_mex_destroy(&c2_input5);
  sf_mex_destroy(&c2_input6);
}

static const mxArray *c2_get(SFc2_Non_linear_simulationInstanceStruct
  *chartInstance, const mxArray *c2_input0, const mxArray *c2_input1)
{
  const mxArray *c2_ = NULL;
  c2_ = NULL;
  sf_mex_assign(&c2_, sf_mex_call(chartInstance->c2_fEmlrtCtx, NULL, "get", 1U,
    2U, 14, sf_mex_dup(c2_input0), 14, sf_mex_dup(c2_input1)), false);
  sf_mex_destroy(&c2_input0);
  sf_mex_destroy(&c2_input1);
  return c2_;
}

static const mxArray *c2_horzcat(SFc2_Non_linear_simulationInstanceStruct
  *chartInstance, const mxArray *c2_input0, const mxArray *c2_input1)
{
  const mxArray *c2_ = NULL;
  c2_ = NULL;
  sf_mex_assign(&c2_, sf_mex_call(chartInstance->c2_fEmlrtCtx, NULL, "horzcat",
    1U, 2U, 14, sf_mex_dup(c2_input0), 14, sf_mex_dup(c2_input1)), false);
  sf_mex_destroy(&c2_input0);
  sf_mex_destroy(&c2_input1);
  return c2_;
}

static const mxArray *c2_b_get(SFc2_Non_linear_simulationInstanceStruct
  *chartInstance, const mxArray *c2_input0, const mxArray *c2_input1)
{
  const mxArray *c2_ = NULL;
  c2_ = NULL;
  sf_mex_assign(&c2_, sf_mex_call(chartInstance->c2_fEmlrtCtx, NULL, "get", 1U,
    2U, 14, sf_mex_dup(c2_input0), 14, sf_mex_dup(c2_input1)), false);
  sf_mex_destroy(&c2_input0);
  sf_mex_destroy(&c2_input1);
  return c2_;
}

static const mxArray *c2_b_horzcat(SFc2_Non_linear_simulationInstanceStruct
  *chartInstance, const mxArray *c2_input0, const mxArray *c2_input1)
{
  const mxArray *c2_ = NULL;
  c2_ = NULL;
  sf_mex_assign(&c2_, sf_mex_call(chartInstance->c2_fEmlrtCtx, NULL, "horzcat",
    1U, 2U, 14, sf_mex_dup(c2_input0), 14, sf_mex_dup(c2_input1)), false);
  sf_mex_destroy(&c2_input0);
  sf_mex_destroy(&c2_input1);
  return c2_;
}

static void c2_f_set(SFc2_Non_linear_simulationInstanceStruct *chartInstance,
                     const mxArray *c2_input0, const mxArray *c2_input1, const
                     mxArray *c2_input2, const mxArray *c2_input3, const mxArray
                     *c2_input4)
{
  sf_mex_call(chartInstance->c2_fEmlrtCtx, NULL, "set", 0U, 5U, 14, sf_mex_dup
              (c2_input0), 14, sf_mex_dup(c2_input1), 14, sf_mex_dup(c2_input2),
              14, sf_mex_dup(c2_input3), 14, sf_mex_dup(c2_input4));
  sf_mex_destroy(&c2_input0);
  sf_mex_destroy(&c2_input1);
  sf_mex_destroy(&c2_input2);
  sf_mex_destroy(&c2_input3);
  sf_mex_destroy(&c2_input4);
}

static const mxArray *c2_c_get(SFc2_Non_linear_simulationInstanceStruct
  *chartInstance, const mxArray *c2_input0, const mxArray *c2_input1)
{
  const mxArray *c2_ = NULL;
  c2_ = NULL;
  sf_mex_assign(&c2_, sf_mex_call(chartInstance->c2_fEmlrtCtx, NULL, "get", 1U,
    2U, 14, sf_mex_dup(c2_input0), 14, sf_mex_dup(c2_input1)), false);
  sf_mex_destroy(&c2_input0);
  sf_mex_destroy(&c2_input1);
  return c2_;
}

static const mxArray *c2_c_horzcat(SFc2_Non_linear_simulationInstanceStruct
  *chartInstance, const mxArray *c2_input0, const mxArray *c2_input1)
{
  const mxArray *c2_ = NULL;
  c2_ = NULL;
  sf_mex_assign(&c2_, sf_mex_call(chartInstance->c2_fEmlrtCtx, NULL, "horzcat",
    1U, 2U, 14, sf_mex_dup(c2_input0), 14, sf_mex_dup(c2_input1)), false);
  sf_mex_destroy(&c2_input0);
  sf_mex_destroy(&c2_input1);
  return c2_;
}

static const mxArray *c2_d_get(SFc2_Non_linear_simulationInstanceStruct
  *chartInstance, const mxArray *c2_input0, const mxArray *c2_input1)
{
  const mxArray *c2_ = NULL;
  c2_ = NULL;
  sf_mex_assign(&c2_, sf_mex_call(chartInstance->c2_fEmlrtCtx, NULL, "get", 1U,
    2U, 14, sf_mex_dup(c2_input0), 14, sf_mex_dup(c2_input1)), false);
  sf_mex_destroy(&c2_input0);
  sf_mex_destroy(&c2_input1);
  return c2_;
}

static const mxArray *c2_d_horzcat(SFc2_Non_linear_simulationInstanceStruct
  *chartInstance, const mxArray *c2_input0, const mxArray *c2_input1)
{
  const mxArray *c2_ = NULL;
  c2_ = NULL;
  sf_mex_assign(&c2_, sf_mex_call(chartInstance->c2_fEmlrtCtx, NULL, "horzcat",
    1U, 2U, 14, sf_mex_dup(c2_input0), 14, sf_mex_dup(c2_input1)), false);
  sf_mex_destroy(&c2_input0);
  sf_mex_destroy(&c2_input1);
  return c2_;
}

static void c2_g_set(SFc2_Non_linear_simulationInstanceStruct *chartInstance,
                     const mxArray *c2_input0, const mxArray *c2_input1, const
                     mxArray *c2_input2, const mxArray *c2_input3, const mxArray
                     *c2_input4)
{
  sf_mex_call(chartInstance->c2_fEmlrtCtx, NULL, "set", 0U, 5U, 14, sf_mex_dup
              (c2_input0), 14, sf_mex_dup(c2_input1), 14, sf_mex_dup(c2_input2),
              14, sf_mex_dup(c2_input3), 14, sf_mex_dup(c2_input4));
  sf_mex_destroy(&c2_input0);
  sf_mex_destroy(&c2_input1);
  sf_mex_destroy(&c2_input2);
  sf_mex_destroy(&c2_input3);
  sf_mex_destroy(&c2_input4);
}

static __global__ __launch_bounds__(32, 1) void c2_eML_blk_kernel_kernel1(const
  real_T c2_sy, const real_T c2_cy, const real_T c2_b_sy, const real_T c2_b_cy,
  real_T c2_BaseToDrive[16], real_T c2_BaseToArm[16])
{
  int32_T c2_tmpIdx;
  c2_tmpIdx = (int32_T)mwGetGlobalThreadIndex();
  if (c2_tmpIdx < 1) {
    c2_BaseToArm[0] = c2_b_cy;
    c2_BaseToArm[4] = c2_b_cy * 0.0 * 0.0 - c2_b_sy;
    c2_BaseToArm[8] = c2_b_cy * 0.0 + c2_b_sy * 0.0;
    c2_BaseToArm[12] = 0.0;
    c2_BaseToArm[1] = c2_b_sy;
    c2_BaseToArm[5] = c2_b_sy * 0.0 * 0.0 + c2_b_cy;
    c2_BaseToArm[9] = c2_b_sy * 0.0 - c2_b_cy * 0.0;
    c2_BaseToArm[13] = 0.0;
    c2_BaseToDrive[0] = c2_cy;
    c2_BaseToDrive[4] = c2_cy * 0.0 * 0.0 - c2_sy;
    c2_BaseToDrive[8] = c2_cy * 0.0 + c2_sy * 0.0;
    c2_BaseToDrive[12] = 0.0;
    c2_BaseToDrive[1] = c2_sy;
    c2_BaseToDrive[5] = c2_sy * 0.0 * 0.0 + c2_cy;
    c2_BaseToDrive[9] = c2_sy * 0.0 - c2_cy * 0.0;
    c2_BaseToDrive[13] = 0.036;
  }
}

static __global__ __launch_bounds__(32, 1) void c2_eML_blk_kernel_kernel2(const
  int8_T c2_b_dv1[4], const real_T c2_dv[4], real_T c2_BaseToDrive[16], real_T
  c2_BaseToArm[16])
{
  int32_T c2_i;
  c2_i = (int32_T)mwGetGlobalThreadIndex();
  if (c2_i < 4) {
    c2_BaseToArm[(c2_i << 2) + 2] = c2_dv[c2_i];
    c2_BaseToArm[(c2_i << 2) + 3] = (real_T)c2_b_dv1[c2_i];
    c2_BaseToDrive[(c2_i << 2) + 2] = c2_dv[c2_i];
    c2_BaseToDrive[(c2_i << 2) + 3] = (real_T)c2_b_dv1[c2_i];
  }
}

static __global__ __launch_bounds__(512, 1) void c2_eML_blk_kernel_kernel3
  (real_T c2_armPart_vertices_G_frame[88224])
{
  int32_T c2_i1;
  c2_i1 = (int32_T)mwGetGlobalThreadIndex();
  if (c2_i1 < 88224) {
    c2_armPart_vertices_G_frame[c2_i1] = 0.0;
  }
}

static __global__ __launch_bounds__(512, 1) void c2_eML_blk_kernel_kernel4
  (real_T c2_b_Zt[22056], real_T c2_armPart_vertices_G_frame[22056], real_T
   c2_b_Yt[22056], real_T c2_b_armPart_vertices_G_frame[22056], real_T c2_c_Xt
   [22056], real_T c2_c_armPart_vertices_G_frame[88224], real_T
   c2_d_armPart_vertices_G_frame[22056])
{
  int32_T c2_i2;
  c2_i2 = (int32_T)mwGetGlobalThreadIndex();
  if (c2_i2 < 22056) {
    c2_d_armPart_vertices_G_frame[c2_i2] = c2_c_armPart_vertices_G_frame[c2_i2 <<
      2];
    c2_c_Xt[c2_i2] = c2_d_armPart_vertices_G_frame[c2_i2];
    c2_b_armPart_vertices_G_frame[c2_i2] = c2_c_armPart_vertices_G_frame[(c2_i2 <<
      2) + 1];
    c2_b_Yt[c2_i2] = c2_b_armPart_vertices_G_frame[c2_i2];
    c2_armPart_vertices_G_frame[c2_i2] = c2_c_armPart_vertices_G_frame[(c2_i2 <<
      2) + 2];
    c2_b_Zt[c2_i2] = c2_armPart_vertices_G_frame[c2_i2];
  }
}

static __global__ __launch_bounds__(32, 1) void c2_eML_blk_kernel_kernel5(const
  real_T c2_sr, const real_T c2_cr, real_T c2_dv[16])
{
  int32_T c2_tmpIdx;
  c2_tmpIdx = (int32_T)mwGetGlobalThreadIndex();
  if (c2_tmpIdx < 1) {
    c2_dv[8] = 0.0 * c2_cr + 0.0 * c2_sr;
    c2_dv[12] = 0.142;
    c2_dv[1] = 0.0;
    c2_dv[5] = 0.0 * c2_sr + c2_cr;
    c2_dv[9] = 0.0 * c2_cr - c2_sr;
    c2_dv[13] = 0.0;
    c2_dv[2] = -0.0;
    c2_dv[6] = c2_sr;
    c2_dv[10] = c2_cr;
    c2_dv[14] = 0.05;
  }
}

static __global__ __launch_bounds__(32, 1) void c2_eML_blk_kernel_kernel6(const
  int8_T c2_b_dv1[4], real_T c2_dv[16])
{
  int32_T c2_i3;
  c2_i3 = (int32_T)mwGetGlobalThreadIndex();
  if (c2_i3 < 4) {
    c2_dv[(c2_i3 << 2) + 3] = (real_T)c2_b_dv1[c2_i3];
  }
}

static __global__ __launch_bounds__(32, 1) void c2_eML_blk_kernel_kernel7(const
  real_T c2_dv[16], real_T c2_BaseToArm[16], real_T c2_y[16])
{
  uint64_T c2_threadId;
  int32_T c2_i4;
  int32_T c2_i5;
  int32_T c2_i7;
  c2_threadId = mwGetGlobalThreadIndex();
  c2_i7 = (int32_T)(c2_threadId % 4UL);
  c2_i4 = (int32_T)((c2_threadId - (uint64_T)c2_i7) / 4UL);
  if ((c2_i4 < 4) && (c2_i7 < 4)) {
    c2_y[c2_i4 + (c2_i7 << 2)] = 0.0;
    for (c2_i5 = 0; c2_i5 < 4; c2_i5++) {
      c2_y[c2_i4 + (c2_i7 << 2)] += c2_BaseToArm[c2_i4 + (c2_i5 << 2)] *
        c2_dv[c2_i5 + (c2_i7 << 2)];
    }
  }
}

static __global__ __launch_bounds__(512, 1) void c2_eML_blk_kernel_kernel8
  (real_T c2_pendPart_vertices_G_frame[26064])
{
  int32_T c2_i6;
  c2_i6 = (int32_T)mwGetGlobalThreadIndex();
  if (c2_i6 < 26064) {
    c2_pendPart_vertices_G_frame[c2_i6] = 0.0;
  }
}

static __global__ __launch_bounds__(512, 1) void c2_eML_blk_kernel_kernel9
  (real_T c2_b_Zt[6516], real_T c2_pendPart_vertices_G_frame[6516], real_T
   c2_b_Yt[6516], real_T c2_b_pendPart_vertices_G_frame[6516], real_T c2_c_Xt
   [6516], real_T c2_c_pendPart_vertices_G_frame[26064], real_T
   c2_d_pendPart_vertices_G_frame[6516])
{
  int32_T c2_i8;
  c2_i8 = (int32_T)mwGetGlobalThreadIndex();
  if (c2_i8 < 6516) {
    c2_d_pendPart_vertices_G_frame[c2_i8] = c2_c_pendPart_vertices_G_frame[c2_i8
      << 2];
    c2_c_Xt[c2_i8] = c2_d_pendPart_vertices_G_frame[c2_i8];
    c2_b_pendPart_vertices_G_frame[c2_i8] = c2_c_pendPart_vertices_G_frame
      [(c2_i8 << 2) + 1];
    c2_b_Yt[c2_i8] = c2_b_pendPart_vertices_G_frame[c2_i8];
    c2_pendPart_vertices_G_frame[c2_i8] = c2_c_pendPart_vertices_G_frame[(c2_i8 <<
      2) + 2];
    c2_b_Zt[c2_i8] = c2_pendPart_vertices_G_frame[c2_i8];
  }
}

static __global__ __launch_bounds__(512, 1) void c2_eML_blk_kernel_kernel10
  (real_T c2_drivePart_vertices_G_frame[14976])
{
  int32_T c2_i9;
  c2_i9 = (int32_T)mwGetGlobalThreadIndex();
  if (c2_i9 < 14976) {
    c2_drivePart_vertices_G_frame[c2_i9] = 0.0;
  }
}

static __global__ __launch_bounds__(512, 1) void c2_eML_blk_kernel_kernel11
  (real_T c2_b_Zt[3744], real_T c2_drivePart_vertices_G_frame[3744], real_T
   c2_b_Yt[3744], real_T c2_b_drivePart_vertices_G_frame[3744], real_T c2_c_Xt
   [3744], real_T c2_c_drivePart_vertices_G_frame[14976], real_T
   c2_d_drivePart_vertices_G_frame[3744])
{
  int32_T c2_i10;
  c2_i10 = (int32_T)mwGetGlobalThreadIndex();
  if (c2_i10 < 3744) {
    c2_d_drivePart_vertices_G_frame[c2_i10] =
      c2_c_drivePart_vertices_G_frame[c2_i10 << 2];
    c2_c_Xt[c2_i10] = c2_d_drivePart_vertices_G_frame[c2_i10];
    c2_b_drivePart_vertices_G_frame[c2_i10] = c2_c_drivePart_vertices_G_frame
      [(c2_i10 << 2) + 1];
    c2_b_Yt[c2_i10] = c2_b_drivePart_vertices_G_frame[c2_i10];
    c2_drivePart_vertices_G_frame[c2_i10] = c2_c_drivePart_vertices_G_frame
      [(c2_i10 << 2) + 2];
    c2_b_Zt[c2_i10] = c2_drivePart_vertices_G_frame[c2_i10];
  }
}

static void init_dsm_address_info(SFc2_Non_linear_simulationInstanceStruct
  *chartInstance)
{
}

static void init_simulink_io_address(SFc2_Non_linear_simulationInstanceStruct
  *chartInstance)
{
  chartInstance->c2_fEmlrtCtx = (void *)sfrtGetEmlrtCtx(chartInstance->S);
  chartInstance->c2_signals = (real_T (*)[3])ssGetInputPortSignal_wrapper
    (chartInstance->S, 0);
  chartInstance->c2_iterationCounter = (real_T *)ssGetInputPortSignal_wrapper
    (chartInstance->S, 1);
  chartInstance->c2_armPartPatchHandle = (real_T *)ssGetInputPortSignal_wrapper
    (chartInstance->S, 2);
  chartInstance->c2_pendPartPatchHandle = (real_T *)ssGetInputPortSignal_wrapper
    (chartInstance->S, 3);
  chartInstance->c2_drivePartPatchHandle = (real_T *)
    ssGetInputPortSignal_wrapper(chartInstance->S, 4);
  chartInstance->c2_thetaPlotHandle = (real_T *)ssGetInputPortSignal_wrapper
    (chartInstance->S, 5);
  chartInstance->c2_alphaPlotHandle = (real_T *)ssGetInputPortSignal_wrapper
    (chartInstance->S, 6);
  chartInstance->c2_frameRate = (real_T *)ssGetInputPortSignal_wrapper
    (chartInstance->S, 7);
  chartInstance->c2_armPartVertices = (real_T (*)[88224])
    ssGetInputPortSignal_wrapper(chartInstance->S, 8);
  chartInstance->c2_drivePartVertices = (real_T (*)[14976])
    ssGetInputPortSignal_wrapper(chartInstance->S, 9);
  chartInstance->c2_pendPartVertices = (real_T (*)[26064])
    ssGetInputPortSignal_wrapper(chartInstance->S, 10);
}

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* SFunction Glue Code */
void sf_c2_Non_linear_simulation_get_check_sum(mxArray *plhs[])
{
  ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(1378966184U);
  ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(132574520U);
  ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(3765136740U);
  ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(2332890783U);
}

mxArray *sf_c2_Non_linear_simulation_third_party_uses_info(void)
{
  mxArray * mxcell3p = mxCreateCellMatrix(1,1);
  mxSetCell(mxcell3p, 0, mxCreateString("coder.internal.blas.BLASApi"));
  return(mxcell3p);
}

mxArray *sf_c2_Non_linear_simulation_jit_fallback_info(void)
{
  const char *infoFields[] = { "fallbackType", "fallbackReason",
    "hiddenFallbackType", "hiddenFallbackReason", "incompatibleSymbol" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 5, infoFields);
  mxArray *fallbackType = mxCreateString("pre");
  mxArray *fallbackReason = mxCreateString("GPUAcceleration");
  mxArray *hiddenFallbackType = mxCreateString("late");
  mxArray *hiddenFallbackReason = mxCreateString("ir_function_calls");
  mxArray *incompatibleSymbol = mxCreateString("gpublascheck");
  mxSetField(mxInfo, 0, infoFields[0], fallbackType);
  mxSetField(mxInfo, 0, infoFields[1], fallbackReason);
  mxSetField(mxInfo, 0, infoFields[2], hiddenFallbackType);
  mxSetField(mxInfo, 0, infoFields[3], hiddenFallbackReason);
  mxSetField(mxInfo, 0, infoFields[4], incompatibleSymbol);
  return mxInfo;
}

mxArray *sf_c2_Non_linear_simulation_updateBuildInfo_args_info(void)
{
  mxArray *mxBIArgs = mxCreateCellMatrix(1,0);
  return mxBIArgs;
}

static const mxArray *sf_get_sim_state_info_c2_Non_linear_simulation(void)
{
  const char *infoFields[] = { "chartChecksum", "varInfo" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 2, infoFields);
  mxArray *mxVarInfo = sf_mex_decode(
    "eNpjYPT0ZQACPiB2YGRgYAPSHEDMxAABrFA+IxKGiLPAxRWAuKSyIBUkXlyU7JkCpPMSc8H8xNI"
    "Kz7y0fLD5FgwI89kImM8JFYcABQfK9EP8F4GknwWLfiUk/QJQfmZxfGJySWZZanyyUbxffl58Tm"
    "ZeamJRfHFmbmlOYklmfh7CfBAAAF9lGV0="
    );
  mxArray *mxChecksum = mxCreateDoubleMatrix(1, 4, mxREAL);
  sf_c2_Non_linear_simulation_get_check_sum(&mxChecksum);
  mxSetField(mxInfo, 0, infoFields[0], mxChecksum);
  mxSetField(mxInfo, 0, infoFields[1], mxVarInfo);
  return mxInfo;
}

static const char* sf_get_instance_specialization(void)
{
  return "sQgXoM7hvXpFBsvvSFLvcxE";
}

static void sf_opaque_initialize_c2_Non_linear_simulation(void *chartInstanceVar)
{
  initialize_params_c2_Non_linear_simulation
    ((SFc2_Non_linear_simulationInstanceStruct*) chartInstanceVar);
  initialize_c2_Non_linear_simulation((SFc2_Non_linear_simulationInstanceStruct*)
    chartInstanceVar);
}

static void sf_opaque_enable_c2_Non_linear_simulation(void *chartInstanceVar)
{
  enable_c2_Non_linear_simulation((SFc2_Non_linear_simulationInstanceStruct*)
    chartInstanceVar);
}

static void sf_opaque_disable_c2_Non_linear_simulation(void *chartInstanceVar)
{
  disable_c2_Non_linear_simulation((SFc2_Non_linear_simulationInstanceStruct*)
    chartInstanceVar);
}

static void sf_opaque_gateway_c2_Non_linear_simulation(void *chartInstanceVar)
{
  sf_gateway_c2_Non_linear_simulation((SFc2_Non_linear_simulationInstanceStruct*)
    chartInstanceVar);
}

static const mxArray* sf_opaque_get_sim_state_c2_Non_linear_simulation(SimStruct*
  S)
{
  return get_sim_state_c2_Non_linear_simulation
    ((SFc2_Non_linear_simulationInstanceStruct *)sf_get_chart_instance_ptr(S));/* raw sim ctx */
}

static void sf_opaque_set_sim_state_c2_Non_linear_simulation(SimStruct* S, const
  mxArray *st)
{
  set_sim_state_c2_Non_linear_simulation
    ((SFc2_Non_linear_simulationInstanceStruct*)sf_get_chart_instance_ptr(S), st);
}

static void sf_opaque_cleanup_runtime_resources_c2_Non_linear_simulation(void
  *chartInstanceVar)
{
  if (chartInstanceVar!=NULL) {
    SimStruct *S = ((SFc2_Non_linear_simulationInstanceStruct*) chartInstanceVar)
      ->S;
    if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
      sf_clear_rtw_identifier(S);
      unload_Non_linear_simulation_optimization_info();
    }

    mdl_cleanup_runtime_resources_c2_Non_linear_simulation
      ((SFc2_Non_linear_simulationInstanceStruct*) chartInstanceVar);
    ((SFc2_Non_linear_simulationInstanceStruct*) chartInstanceVar)->
      ~SFc2_Non_linear_simulationInstanceStruct();
    utFree(chartInstanceVar);
    if (ssGetUserData(S)!= NULL) {
      sf_free_ChartRunTimeInfo(S);
    }

    ssSetUserData(S,NULL);
  }
}

static void sf_opaque_mdl_start_c2_Non_linear_simulation(void *chartInstanceVar)
{
  mdl_start_c2_Non_linear_simulation((SFc2_Non_linear_simulationInstanceStruct*)
    chartInstanceVar);
}

static void sf_opaque_mdl_terminate_c2_Non_linear_simulation(void
  *chartInstanceVar)
{
  mdl_terminate_c2_Non_linear_simulation
    ((SFc2_Non_linear_simulationInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_init_subchart_simstructs(void *chartInstanceVar)
{
  initSimStructsc2_Non_linear_simulation
    ((SFc2_Non_linear_simulationInstanceStruct*) chartInstanceVar);
}

extern unsigned int sf_machine_global_initializer_called(void);
static void mdlProcessParameters_c2_Non_linear_simulation(SimStruct *S)
{
  int i;
  for (i=0;i<ssGetNumRunTimeParams(S);i++) {
    if (ssGetSFcnParamTunable(S,i)) {
      ssUpdateDlgParamAsRunTimeParam(S,i);
    }
  }

  sf_warn_if_symbolic_dimension_param_changed(S);
  if (sf_machine_global_initializer_called()) {
    initialize_params_c2_Non_linear_simulation
      ((SFc2_Non_linear_simulationInstanceStruct*)sf_get_chart_instance_ptr(S));
    initSimStructsc2_Non_linear_simulation
      ((SFc2_Non_linear_simulationInstanceStruct*)sf_get_chart_instance_ptr(S));
  }
}

const char* sf_c2_Non_linear_simulation_get_post_codegen_info(void)
{
  int i;
  const char* encStrCodegen [18] = {
    "eNrtV82P00YUd1YLKqKg5VSpqgTlAhIX1As9IciH1aCEXXAW9hbNjl/iUcYz7nx4syfuIHHnjHr",
    "puX9MT5w58ifwxnY+cOyEdAXaIkbyesf+vZ/f95t4jW7fw3UVr/fXPO8i3n/Aa8fL14Vi31i68u",
    "e73q1i/w8KCRsfEEVi7a1dgsTwFLTk1jApumIkK2FMjECBoIhNpDJ1bJrFljMx8a2gjk8/jxiNg",
    "khaHjZRloT7gp8iW2LNAfK0mQJqfIDQREraceRzMp5rrMxJKwI60TZeZ4IGE9jEqaX7lhuWcOhM",
    "gXaFNgQ11gvdAkMMtMy01kxnqQ5mQBknnBFRaW1EdAAJOtjAYRLi331r0KgyjEZEmSZEJAXdY5O",
    "MUwooczKNL46ZIEYqRngn5i0nuKrbAUd9+jIEvsYhqFtTAZkkkglTH//AR0s7ghxzaMOxHdezBf",
    "CndcF/xuAEVK3fRi2ZgiJj2Be1H80c0plm0ZpnySrMsBieEfWQYvw0hLXZi5mjA4JxggFK1MEgM",
    "7KrB4ql6N5aNht3XWZuKhkb58HWm2AZWyeFdVGYs/lUtAjnuhY2kEkPUuAZa5sYsh6Ws1bjtGbh",
    "QKKDXXrXV4MVDANfwFpShKwyXGkJkPWdx9hYPkVSq42MW5i87V5v9fUqrCsMqBGhUNUFFGEa0Ge",
    "Ze+vZQqZd7BGIWplMvSpwniGbUJ4eWdE+kWqCPlnTRBYmuIjWAmM9xlhiJRxqLJp1MBfLTThKaA",
    "ShazCMQx/LBrEVPtGutT3EukuZOW2DpoolFVG1WHXYhjouoU4TOBQTIU+Er2QcFD0+jwJ2BuzhM",
    "cZgkNWYoEjFtMF2wRafDwEwKYkSTIyb2ObUqY9KVkbMzb273mLu/fgZc28mV77fXuJpVPB4S3eH",
    "f7CEv7TzKf5y6bs7s2eLVclzpfTd3RKPw+3h9fb1u86dR3+/fPXz3l9vpi9+LfuhrE9jRZ9G9r+",
    "T+9DY7txwtdj/MmvQ84JLV/LcYf9Y0mu3gv+nJf69Yq+fjI9k/16UHiV+U6dp4PdSOu3k/tpS39",
    "nzG25SYHZmea1oNywONG5PbD7mHf/vS/pe3MB/qXierxsPziaf++tog79ulvx1M5unQ+KqFIb0t",
    "+FjKYZYc1hBw+yIRVzFrub7f82XbeW8ryz3f9Hzu9yXj/vnzIPLZ5wj513urPZtOxfPG/7umn7q",
    "lfB759iOs55XvjT+X2+7uXy92N+f/8RoRYyHFafN4jWeCUdVb7+RPN0G/xGG5b5i",
    ""
  };

  static char newstr [1265] = "";
  newstr[0] = '\0';
  for (i = 0; i < 18; i++) {
    strcat(newstr, encStrCodegen[i]);
  }

  return newstr;
}

static void mdlSetWorkWidths_c2_Non_linear_simulation(SimStruct *S)
{
  const char* newstr = sf_c2_Non_linear_simulation_get_post_codegen_info();
  sf_set_work_widths(S, newstr);
  ssSetChecksum0(S,(1172213411U));
  ssSetChecksum1(S,(2326415915U));
  ssSetChecksum2(S,(2769296011U));
  ssSetChecksum3(S,(562002073U));
}

static void mdlRTW_c2_Non_linear_simulation(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S)) {
    ssWriteRTWStrParam(S, "StateflowChartType", "Embedded MATLAB");
  }
}

static void mdlSetupRuntimeResources_c2_Non_linear_simulation(SimStruct *S)
{
  SFc2_Non_linear_simulationInstanceStruct *chartInstance;
  chartInstance = (SFc2_Non_linear_simulationInstanceStruct *)utMalloc(sizeof
    (SFc2_Non_linear_simulationInstanceStruct));
  if (chartInstance==NULL) {
    sf_mex_error_message("Could not allocate memory for chart instance.");
  }

  memset(chartInstance, 0, sizeof(SFc2_Non_linear_simulationInstanceStruct));
  chartInstance = new (chartInstance) SFc2_Non_linear_simulationInstanceStruct;
  chartInstance->chartInfo.chartInstance = chartInstance;
  chartInstance->chartInfo.isEMLChart = 1;
  chartInstance->chartInfo.chartInitialized = 0;
  chartInstance->chartInfo.sFunctionGateway =
    sf_opaque_gateway_c2_Non_linear_simulation;
  chartInstance->chartInfo.initializeChart =
    sf_opaque_initialize_c2_Non_linear_simulation;
  chartInstance->chartInfo.mdlStart =
    sf_opaque_mdl_start_c2_Non_linear_simulation;
  chartInstance->chartInfo.mdlTerminate =
    sf_opaque_mdl_terminate_c2_Non_linear_simulation;
  chartInstance->chartInfo.mdlCleanupRuntimeResources =
    sf_opaque_cleanup_runtime_resources_c2_Non_linear_simulation;
  chartInstance->chartInfo.enableChart =
    sf_opaque_enable_c2_Non_linear_simulation;
  chartInstance->chartInfo.disableChart =
    sf_opaque_disable_c2_Non_linear_simulation;
  chartInstance->chartInfo.getSimState =
    sf_opaque_get_sim_state_c2_Non_linear_simulation;
  chartInstance->chartInfo.setSimState =
    sf_opaque_set_sim_state_c2_Non_linear_simulation;
  chartInstance->chartInfo.getSimStateInfo =
    sf_get_sim_state_info_c2_Non_linear_simulation;
  chartInstance->chartInfo.zeroCrossings = NULL;
  chartInstance->chartInfo.outputs = NULL;
  chartInstance->chartInfo.derivatives = NULL;
  chartInstance->chartInfo.mdlRTW = mdlRTW_c2_Non_linear_simulation;
  chartInstance->chartInfo.mdlSetWorkWidths =
    mdlSetWorkWidths_c2_Non_linear_simulation;
  chartInstance->chartInfo.callGetHoverDataForMsg = NULL;
  chartInstance->chartInfo.extModeExec = NULL;
  chartInstance->chartInfo.restoreLastMajorStepConfiguration = NULL;
  chartInstance->chartInfo.restoreBeforeLastMajorStepConfiguration = NULL;
  chartInstance->chartInfo.storeCurrentConfiguration = NULL;
  chartInstance->chartInfo.callAtomicSubchartUserFcn = NULL;
  chartInstance->chartInfo.callAtomicSubchartAutoFcn = NULL;
  chartInstance->chartInfo.callAtomicSubchartEventFcn = NULL;
  chartInstance->chartInfo.chartStateSetterFcn = NULL;
  chartInstance->chartInfo.chartStateGetterFcn = NULL;
  chartInstance->S = S;
  chartInstance->chartInfo.dispatchToExportedFcn = NULL;
  sf_init_ChartRunTimeInfo(S, &(chartInstance->chartInfo), false, 0,
    chartInstance->c2_JITStateAnimation,
    chartInstance->c2_JITTransitionAnimation);
  init_dsm_address_info(chartInstance);
  init_simulink_io_address(chartInstance);
  if (!sim_mode_is_rtw_gen(S)) {
  }

  mdl_setup_runtime_resources_c2_Non_linear_simulation(chartInstance);
}

void c2_Non_linear_simulation_method_dispatcher(SimStruct *S, int_T method, void
  *data)
{
  switch (method) {
   case SS_CALL_MDL_SETUP_RUNTIME_RESOURCES:
    mdlSetupRuntimeResources_c2_Non_linear_simulation(S);
    break;

   case SS_CALL_MDL_SET_WORK_WIDTHS:
    mdlSetWorkWidths_c2_Non_linear_simulation(S);
    break;

   case SS_CALL_MDL_PROCESS_PARAMETERS:
    mdlProcessParameters_c2_Non_linear_simulation(S);
    break;

   default:
    /* Unhandled method */
    sf_mex_error_message("Stateflow Internal Error:\n"
                         "Error calling c2_Non_linear_simulation_method_dispatcher.\n"
                         "Can't handle method %d.\n", method);
    break;
  }
}
