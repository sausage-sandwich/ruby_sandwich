# frozen_string_literal: true

module Interactor
  module FailCircuit
    def fail_circuit
      result = yield
      result.success? ? result : context.fail!(result.to_h)
    end
  end
end
