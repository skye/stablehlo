// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_fun_flat_jax {
  func.func public @main(%arg0: tensor<i64>, %arg1: tensor<?x2x3xf32> {mhlo.sharding = ""}, %arg2: tensor<?x2x3xf32> {mhlo.sharding = ""}) -> tensor<?x4x3xf32> {
    %0 = stablehlo.concatenate %arg1, %arg2, dim = 1 : (tensor<?x2x3xf32>, tensor<?x2x3xf32>) -> tensor<?x4x3xf32>
    return %0 : tensor<?x4x3xf32>
  }
}

