# frozen_string_literal: true
# There is an interplay between an AdminSet and a PermissionTemplate. Given
# that AdminSet is an ActiveFedora::Base and PermissionTemplate is ActiveRecord::Base
# we don't have the usual :has_many or :belongs_to methods to assist in defining that
# relationship. However, from a conceptual standpoint:
#
# * An AdminSet has_one :permission_tempate
# * A PermissionTemplate belongs_to :admin_set
#
# When an object is added as a member of an AdminSet, the AdminSet's associated
# PermissionTemplate is applied to that object (e.g. some of the object's attributes
# are updated as per the rules of the permission template)
#
# @see Hyrax::PermissionTemplate
# @see Hyrax::AdminSetService
# @see Hyrax::Forms::PermissionTemplateForm for validations and creation process
# @see Hyrax::DefaultAdminSetActor
# @see Hyrax::ApplyPermissionTemplateActor
class AdminSet < ActiveFedora::Base
  include Hydra::PCDM::CollectionBehavior
  include Hydra::AccessControls::Permissions
  include Hyrax::Noid
  include Hyrax::HumanReadableType
  include Hyrax::HasRepresentative
  include Hyrax::Permissions

  DEFAULT_ID = Hyrax::AdminSetCreateService::DEFAULT_ID
  DEFAULT_TITLE = Hyrax::AdminSetCreateService::DEFAULT_TITLE
  DEFAULT_WORKFLOW_NAME = Hyrax.config.default_active_workflow_name

  validates_with Hyrax::HasOneTitleValidator

  ##
  # @!group Class Attributes
  #
  # @!attribute internal_resource
  #   @return [String]
  class_attribute :internal_resource, default: "AdminSet"

  class_attribute :human_readable_short_description
  # @!endgroup Class Attributes
  ##

  def self.to_rdf_representation
    internal_resource
  end

  def to_rdf_representation
    internal_resource
  end

  self.indexer = Hyrax::AdminSetIndexer

  property :title,             predicate: ::RDF::Vocab::DC.title
  property :alternative_title, predicate: ::RDF::Vocab::DC.alternative
  property :description,       predicate: ::RDF::Vocab::DC.description
  property :creator,           predicate: ::RDF::Vocab::DC11.creator
  has_many :members,
           predicate: Hyrax.config.admin_set_predicate,
           class_name: 'ActiveFedora::Base'

  before_destroy :check_if_not_default_set, :check_if_empty, prepend: true
  after_destroy :destroy_permission_template

  def collection_type_gid
    # allow AdminSet to behave more like a regular Collection
    Hyrax::CollectionType.find_or_create_admin_set_type.to_global_id
  end

  def to_s
    title.presence || 'No Title'
  end

  # @api public
  # A bit of an analogue for a `has_one :admin_set` as it crosses from Fedora to the DB
  # @return [Hyrax::PermissionTemplate]
  # @raise [ActiveRecord::RecordNotFound]
  def permission_template
    Hyrax::PermissionTemplate.find_by!(source_id: id)
  end

  # @api public
  #
  # @return [Sipity::Workflow]
  # @raise [ActiveRecord::RecordNotFound]
  def active_workflow
    Sipity::Workflow.find_active_workflow_for(admin_set_id: id)
  end

  # @api public
  #
  # return an id for the AdminSet.
  # defaults to calling Hyrax::Noid, but needs a fall back if noid is off
  def assign_id
    super || SecureRandom.uuid
  end

  private

  def destroy_permission_template
    permission_template.destroy
  rescue ActiveRecord::RecordNotFound
    true
  end

  def check_if_empty
    return true if members.empty?
    errors.add(:base, I18n.t('hyrax.admin.admin_sets.delete.error_not_empty'))
    throw :abort
  end

  def check_if_not_default_set
    return true unless Hyrax::AdminSetCreateService.default_admin_set?(id: id)
    errors.add(:base, I18n.t('hyrax.admin.admin_sets.delete.error_default_set'))
    throw :abort
  end
end
