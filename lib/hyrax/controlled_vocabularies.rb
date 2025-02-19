# frozen_string_literal: true
module Hyrax
  module ControlledVocabularies
    extend ActiveSupport::Autoload

    eager_autoload do
      autoload :Location
      autoload :ResourceLabelCaching
    end
  end
end
