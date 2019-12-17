class Power
  include Consul::Power

  attr_reader :params

  def initialize(params: {})
    @params = params
  end

  ##-------------------V1::UserController-------------------##
  power :users_index,
        :users_create do
    User
  end
end
