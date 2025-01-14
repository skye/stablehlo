// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_fun_flat_jax {
  func.func public @main(%arg0: tensor<i64>, %arg1: tensor<?x3x4xf32> {mhlo.sharding = ""}) -> tensor<?x3x4xcomplex<f32>> {
    %0 = stablehlo.constant dense<0.000000e+00> : tensor<f32>
    %1 = stablehlo.convert %arg0 : (tensor<i64>) -> tensor<i32>
    %2 = stablehlo.reshape %1 : (tensor<i32>) -> tensor<1xi32>
    %3 = stablehlo.constant dense<3> : tensor<1xi32>
    %4 = stablehlo.constant dense<4> : tensor<1xi32>
    %5 = stablehlo.concatenate %2, %3, %4, dim = 0 : (tensor<1xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<3xi32>
    %6 = stablehlo.dynamic_broadcast_in_dim %0, %5, dims = [] : (tensor<f32>, tensor<3xi32>) -> tensor<?x3x4xf32>
    %7 = stablehlo.complex %arg1, %6 : tensor<?x3x4xcomplex<f32>>
    return %7 : tensor<?x3x4xcomplex<f32>>
  }
}

