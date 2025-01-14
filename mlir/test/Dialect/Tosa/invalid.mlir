// RUN: mlir-opt %s -split-input-file -verify-diagnostics


func.func @test_conv2d(%arg0: tensor<1x29x29x4xf32>, %arg1: tensor<16x3x3x4xi8>, %arg2: tensor<16xi8>) -> tensor<1x27x27x16xi8> {
  // expected-error@+1 {{expect both input and weight to be float or not together, got 'f32' and 'i8'}}
  %0 = "tosa.conv2d"(%arg0, %arg1, %arg2) {dilation = array<i64: 1, 1>, pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 1, 1>}
           : (tensor<1x29x29x4xf32>, tensor<16x3x3x4xi8>, tensor<16xi8>) -> tensor<1x27x27x16xi8>
  return %0 : tensor<1x27x27x16xi8>
}

// -----

func.func @test_conv2d(%arg0: tensor<*xi8>, %arg1: tensor<16x3x3x4xi8>, %arg2: tensor<16xi8>) -> tensor<1x27x27x16xi8> {
  // expected-error@+1 {{expect a ranked tensor for input, got <block argument> of type 'tensor<*xi8>' at index: 0}}
  %0 = "tosa.conv2d"(%arg0, %arg1, %arg2) {dilation = array<i64: 1, 1>, pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 1, 1>}
           : (tensor<*xi8>, tensor<16x3x3x4xi8>, tensor<16xi8>) -> tensor<1x27x27x16xi8>
  return %0 : tensor<1x27x27x16xi8>
}

// -----

func.func @test_conv2d(%arg0: tensor<1x29x29x4xi8>, %arg1: tensor<*xi8>, %arg2: tensor<16xi8>) -> tensor<1x27x27x16xi8> {
  // expected-error@+1 {{expect a ranked tensor for weight, got <block argument> of type 'tensor<*xi8>' at index: 1}}
  %0 = "tosa.conv2d"(%arg0, %arg1, %arg2) {dilation = array<i64: 1, 1>, pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 1, 1>}
           : (tensor<1x29x29x4xi8>, tensor<*xi8>, tensor<16xi8>) -> tensor<1x27x27x16xi8>
  return %0 : tensor<1x27x27x16xi8>
}


// -----

func.func @test_conv2d(%arg0: tensor<1x29x29x4xi8>, %arg1: tensor<16x3x3x4xi8>, %arg2: tensor<16xi8>) -> tensor<1x27x27x16xi8> {
  // expected-error@+1 {{'tosa.conv2d' op quantizationattr is required for quantized type, and not allowed for float type}}
  %0 = "tosa.conv2d"(%arg0, %arg1, %arg2) {dilation = array<i64: 1, 1>, pad = array<i64: 0, 0, 0, 0>, stride = array<i64: 1, 1>}
           : (tensor<1x29x29x4xi8>, tensor<16x3x3x4xi8>, tensor<16xi8>) -> tensor<1x27x27x16xi8>
  return %0 : tensor<1x27x27x16xi8>
}

// -----

func.func @test_concat(%arg0 : tensor<2x1xf32>, %arg1 : tensor<2x2xf32>) -> tensor<?x?xf32> {
  // expected-error@+1 {{Cannot concat tensors with different sizes on the non-axis dimension 1}}
  %0 = "tosa.concat"(%arg0, %arg1) {axis = 0 : i64} : (tensor<2x1xf32>, tensor<2x2xf32>) -> tensor<?x?xf32>
  return %0 : tensor<?x?xf32>
}
