# frozen_string_literal: true
module Hyrax
  # Overrides CanCan so that attributes are not automatically assigned
  # to loaded resources
  class ControllerResource < CanCan::ControllerResource
    private

    # Override resource_params to make this a nop. Hyrax uses actors to assign attributes
    def resource_params
      {}
    end
  end
end
