# frozen_string_literal: true
module Hyrax
  class InspectWorkPresenter
    def initialize(solr_document, current_ability)
      @solr_document = solr_document
      @current_ability = current_ability
    end
    attr_reader :solr_document, :current_ability

    def workflow
      return { comments: [], roles: [] } unless sipity_entity
      {
        entity_id: sipity_entity.id,
        proxy_for: sipity_entity.proxy_for_global_id,
        workflow_id: sipity_entity.workflow_id,
        workflow_name: sipity_entity.workflow_name,
        state_id: sipity_entity.workflow_state_id,
        state_name: sipity_entity.workflow_state_name,
        comments: workflow_comments,
        roles: sipity_entity_roles
      }
    end

    def solr
      @solr_document.inspect
    end

    private

    def sipity_entity
      @sipity_entity ||= Sipity::Entity(solr_document)
    end

    def sipity_entity_roles
      roles = Workflow::PermissionQuery.scope_roles_associated_with_the_given_entity(entity: solr_document)
      roles.map do |role|
        { id: role.id, name: role.name, description: role.description, users: sipity_entity_role_users(role) }
      end
    end

    def sipity_entity_role_users(role)
      users = Workflow::PermissionQuery.scope_users_for_entity_and_roles(entity: sipity_entity, roles: role)
      users.map(&:user_key)
    end

    def workflow_comments
      return [] unless sipity_entity&.comments&.any?
      sipity_entity.comments.map do |comment|
        { comment: comment.comment, created_at: comment.created_at }
      end
    end
  end
end
