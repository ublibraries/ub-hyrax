# frozen_string_literal: true

module Hyrax
  ##
  # View Helpers for Hydra Batch Edit functionality
  module BatchEditsHelper
    # Displays the delete button for batch editing
    def batch_delete
      render 'hyrax/batch_edits/delete_selected'
    end

    # Displays a "check all" button with a dropdown that has "Select None"
    # and "Select current page" actions
    def render_check_all
      render 'hyrax/batch_edits/check_all'
    end
  end
end
