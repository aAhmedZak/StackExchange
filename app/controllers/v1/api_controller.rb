# frozen_string_literal: true

class V1::ApiController < ApplicationController
  include ResponseRenderer
  include Consul::Controller

  current_power do
    Power.new(params: params)
  end

  require_power_check

  private
end
