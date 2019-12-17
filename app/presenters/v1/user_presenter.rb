module V1
  module UserPresenter
    extend ActiveSupport::Concern

    included do
      acts_as_api

      api_accessible :base do |t|
        t.add :id
        t.add :username
      end

      api_accessible :v1_index, extend: :base
      api_accessible :v1_show, extend: :base
    end
  end
end
