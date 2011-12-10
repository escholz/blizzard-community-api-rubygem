module RspecMatchers
  class BeBoolean
    def matches?(target)
      @target = target
      (@target.is_a?(TrueClass) || @target.is_a?(FalseClass))
    end
    def failure_message
      "expected #{@target.inspect} to be boolean class"
    end
    def negative_failure_message
      "expected #{@target.inspect} not to be a boolean class"
    end
  end

  def be_boolean
    BeBoolean.new
  end
end
