class Power
  include Consul::Power

  attr_reader :params

  def initialize(params: {})
    @params = params
  end
end
