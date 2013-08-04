require 'active_support/callbacks'
require 'active_model/callbacks'

module Stylet
  module Callbacks
    extend ActiveSupport::Concern

    included do
      extend ActiveModel::Callbacks
      define_model_callbacks :update
    end

    def update
      run_callbacks(:update) { super }
    end
  end
end
