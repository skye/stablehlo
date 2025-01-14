/* Copyright 2023 The StableHLO Authors.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
==============================================================================*/

#ifndef STABLEHLO_REFERENCE_INTERPRETERVALUE_H
#define STABLEHLO_REFERENCE_INTERPRETERVALUE_H

#include <variant>

#include "mlir/IR/Types.h"
#include "stablehlo/reference/Tensor.h"
#include "stablehlo/reference/Token.h"

namespace mlir {
namespace stablehlo {

class InterpreterValue {
 public:
  /// \name Constructors
  /// @{
  InterpreterValue() = default;
  InterpreterValue(const Tensor &tensor);
  InterpreterValue(const Token &token);
  /// @}

  /// Getter method for Tensor object.
  Tensor getTensor() const;

  /// Getter method for Token object.
  Token getToken() const;

  /// Getter method for type_;
  Type getType() const;

  /// Returns whether value_ is a Tensor object.
  bool isTensor() const;

  /// Returns whether value_ is a Token object.
  bool isToken() const;

  /// Print utilities for InterpreterValue objects.
  void print(raw_ostream &os) const;

  /// Print utilities for InterpreterValue objects.
  void dump() const;

 private:
  std::variant<Tensor, Token> value_;
};

}  // namespace stablehlo
}  // namespace mlir

#endif  // STABLEHLO_INTERPRETERVALUE_H
