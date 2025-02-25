# frozen_string_literal: true
Bulkrax.setup do | config |
  # Add local parsers
  # config.parsers += [
  #   { name: 'MODS - My Local MODS parser', class_name: 'Bulkrax::ModsXmlParser', partial: 'mods_fields' },
  # ]

  # Field to use during import to identify if the Work or Collection already exists.
  # Default is 'source'.
  # config.system_identifier_field = 'source'

  # WorkType to use as the default if none is specified in the import
  # Default is the first returned by Hyrax.config.curation_concerns
  config.default_work_type = 'GenericWork'

  # Path to store pending imports
  config.import_path = 'tmp/imports'

  # Path to store exports before download
  config.export_path = 'tmp/exports'

  # Server name for oai request header
  # config.server_name = 'my_server@name.com'

  # Field_mapping for establishing a parent-child relationship (FROM parent TO child)
  # This can be a Collection to Work, or Work to Work relationship
  # This value IS NOT used for OAI, so setting the OAI Entries here will have no effect
  # The mapping is supplied per Entry, provide the full class name as a string, eg. 'Bulkrax::CsvEntry'
  # Example:
  #   {
  #     'Bulkrax::RdfEntry'  => 'http://opaquenamespace.org/ns/contents',
  #     'Bulkrax::CsvEntry'  => 'children'
  #   }
  # By default no parent-child relationships are added
  #config.parent_child_field_mapping = { 'Bulkrax::CsvEntry'  => 'children'}

  # Field_mapping for establishing a collection relationship (FROM work TO collection)
  # This value IS NOT used for OAI, so setting the OAI parser here will have no effect
  # The mapping is supplied per Entry, provide the full class name as a string, eg. 'Bulkrax::CsvEntry'
  # The default value for CSV is collection
  # Add/replace parsers, for example:
  # config.collection_field_mapping['Bulkrax::RdfEntry'] = 'http://opaquenamespace.org/ns/set'

  # Field mappings
  # Create a completely new set of mappings by replacing the whole set as follows
  #   config.field_mappings = {
  #     "Bulkrax::OaiDcParser" => { **individual field mappings go here*** }
  #   }

  # Add to, or change existing mappings as follows
  #   e.g. to exclude date
  #   config.field_mappings["Bulkrax::OaiDcParser"]["date"] = { from: ["date"], excluded: true  }

  default_field_mapping = {
      'abstract' => { from: ['abstract'], split: true },
      'accessibility_feature' => { from: ['accessibility_feature'], split: '\|' },
      'accessibility_hazard' => { from: ['accessibility_hazard'], split: '\|' },
      'accessibility_summary' => { from: ['accessibility_summary'] },
      'additional_information' => { from: ['additional_information'], split: '\|', generated: true },
      'admin_note' => { from: ['admin_note'] },
      'admin_set_id' => { from: ['admin_set_id'], generated: true },
      'alternate_version' => { from: ['alternate_version'], split: '\|' },
      'alternative_title' => { from: ['alternative_title'], split: '\|', generated: true },
      'arkivo_checksum' => { from: ['arkivo_checksum'], split: '\|', generated: true },
      'audience' => { from: ['audience'], split: '\|' },
      'based_near' => { from: ['location'], split: '\|' },
      'bibliographic_citation' => { from: ['bibliographic_citation'], split: true },
      'contributor' => { from: ['contributor'], split: true },
      'create_date' => { from: ['create_date'], split: true },
      'children' => { from: ['children'], related_children_field_mapping: true },
      'committee_member' => { from: ['committee_member'], split: '\|' },
      'creator' => { from: ['creator'], split: true },
      'date_created' => { from: ['date_created'], split: true },
      'date_uploaded' => { from: ['date_uploaded'], generated: true },
      'degree_discipline' => { from: ['discipline'], split: '\|' },
      'degree_grantor' => { from: ['grantor'], split: '\|' },
      'degree_level' => { from: ['level'], split: '\|' },
      'degree_name' => { from: ['degree'], split: '\|' },
      'depositor' => { from: ['depositor'], split: '\|', generated: true },
      'description' => { from: ['description'], split: true },
      'discipline' => { from: ['discipline'], split: '\|' },
      'education_level' => { from: ['education_level'], split: '\|' },
      'embargo_id' => { from: ['embargo_id'], generated: true },
      'extent' => { from: ['extent'], split: true },
      'file' => { from: ['file'], split: /\s*[|]\s*/ },
      'identifier' => { from: ['identifier'], split: true },
      'import_url' => { from: ['import_url'], split: '\|', generated: true },
      'keyword' => { from: ['keyword'], split: true },
      'label' => { from: ['label'], generated: true },
      'language' => { from: ['language'], split: true },
      'lease_id' => { from: ['lease_id'], generated: true },
      'library_catalog_identifier' => { from: ['library_catalog_identifier'], split: '\|' },
      'license' => { from: ['license'], split: /\s*[|]\s*/ },
      'modified_date' => { from: ['modified_date'], split: true },
      'newer_version' => { from: ['newer_version'], split: '\|' },
      'oer_size' => { from: ['oer_size'], split: '\|' },
      'on_behalf_of' => { from: ['on_behalf_of'], generated: true },
      'owner' => { from: ['owner'], generated: true },
      'parents' => { from: ['parents'], related_parents_field_mapping: true },
      'previous_version' => { from: ['previous_version'], split: '\|' },
      'publisher' => { from: ['publisher'], split: true },
      'related_item' => { from: ['related_item'], split: '\|' },
      'relative_path' => { from: ['relative_path'], split: '\|', generated: true },
      'related_url' => { from: ['related_url', 'relation'], split: /\s* [|]\s*/ },
      'remote_files' => { from: ['remote_files'], split: /\s*[|]\s*/ },
      'rendering_ids' => { from: ['rendering_ids'], split: '\|', generated: true },
      'resource_type' => { from: ['resource_type'], split: true },
      'rights_holder' => { from: ['rights_holder'], split: '\|' },
      'rights_notes' => { from: ['rights_notes'], split: true },
      'rights_statement' => { from: ['rights', 'rights_statement'], split: '\|', generated: true },
      'source' => { from: ['source'], split: true },
      'state' => { from: ['state'], generated: true },
      'subject' => { from: ['subject'], split: true },
      'table_of_contents' => { from: ['table_of_contents'], split: '\|' },
      'title' => { from: ['title'], split: /\s*[|]\s*/ },
      'video_embed' => { from: ['video_embed'] }
    }

  config.field_mappings["Bulkrax::BagitParser"] = default_field_mapping.merge({
                                                                                  # add or remove custom mappings for this parser here
                                                                                })

  config.field_mappings["Bulkrax::CsvParser"] = default_field_mapping.merge({
    })

  config.field_mappings["Bulkrax::OaiDcParser"] = default_field_mapping.merge({
                                                                                  # add or remove custom mappings for this parser here
                                                                                })

  config.field_mappings["Bulkrax::OaiQualifiedDcParser"] = default_field_mapping.merge({
                                                                                           # add or remove custom mappings for this parser here
                                                                                         })

  config.field_mappings["Bulkrax::XmlParser"] = default_field_mapping.merge({
                                                                                # add or remove custom mappings for this parser here
                                                                              })
  # I might be stupid 
  #config.object_factory = Bulkrax::ObjectFactory
  config.object_factory = Bulkrax::ValkyrieObjectFactory
  
  config.field_mappings = {
    "Bulkrax::CsvParser" => {
      "title" => { from: ["title"] },
      "subject" => { from: ["subject"], parsed: true, split:true },
      "description" => { from: ["description"] },
      "creator" => { from: ["creator"], split: true },
      "related_url" => { from: ["relation"] },
      "publisher" => { from: ["publisher"] },
      "date_created" => { from: ["date"] },
      "contributor" => { from: ["contributor"], split:true },
      "rights_notes" => { from: ["rights_notes"], split: true },
      "rights_statement" => { from: ["rights", "rights_statement"], split: '\|', generated: true },
      "language" => { from: ["language"], parsed: true, split: true },
      "resource_type" => { from: ["resource_type"], parsed: true },
      "identifier" => { from: ["source_identifier"], source_identifier: true},
      "create_date" => { from: ["create_date"], split: true },
      "source" => { from: ["source"] },
      "extent" => { from: ["extent"] },
      "keyword" => { from: ["keyword"], split: true },
      "identifier" => { from: ["identifier"] },
      "license" => { from: ["license"], split: '\|' }, # some characters may need to be escaped
      "work_type" => { from: ["work_type"], split: true },
      "remote_files" => { from: ["thumbnail_url"], parsed: true },
      "parents" => { from: ["parents"], related_parents_field_mapping: true },
      "children" => { from: ["children"], related_children_field_mapping: true },
      "model" => { from: ["model"], split: true },
    }
  }
  end
  # rubocop:enable Metrics/BlockLength

  # Sidebar for hyrax 3+ support
  if Object.const_defined?(:Hyrax) && ::Hyrax::DashboardController&.respond_to?(:sidebar_partials)
    Hyrax::DashboardController.sidebar_partials[:repository_content] << "hyrax/dashboard/sidebar/bulkrax_sidebar_additions"
  end

#  Bulkrax::CreateRelationshipsJob.update_child_records_works_file_sets = true
  # valkyrie adapter fix (not in main branch of bulkrax 9.0.0 yet)
Bulkrax::ValkyrieObjectFactory.class_eval do
    def self.search_by_property(value:, klass:, field: nil, name_field: nil, **)
      name_field ||= field
      raise "Expected named_field or field got nil" if name_field.blank?
      return if value.blank?
      Hyrax.query_service.custom_queries.find_by_model_and_property_value(model: klass, property: name_field, value: value)
    end

    def find_by_id
      Hyrax.logger.error "###### Calling find_by_id, ID is: #{attributes[:id]}"
      Hyrax.query_service.find_by(id: attributes[:id]) if attributes.key? :id
    end  
end

# Adapted from emory-libraries/dlp-selfdeposit v
#
# Hyrax v5.0.1 Override - since Bulkrax introduces the Wings constant when it installs, the first test to determine query type passes,
#   but the `is_a?` method produces an error because `Wings::Valkyrie` constant doesn't exist. This provides that test, as well.
Rails.application.config.to_prepare do
  Hyrax::DownloadsController.class_eval do
    def file_set_parent(file_set_id)
      file_set = if defined?(Wings) && defined?(Wings::Valkyrie) && Hyrax.metadata_adapter.is_a?(Wings::Valkyrie::MetadataAdapter)
                   Hyrax.query_service.find_by_alternate_identifier(alternate_identifier: file_set_id, use_valkyrie: Hyrax.config.use_valkyrie?)
                 else
                   Hyrax.query_service.find_by(id: file_set_id)
                 end
      @parent ||=
        case file_set
        when Hyrax::Resource
          Hyrax.query_service.find_parents(resource: file_set).first
        else
          file_set.parent
       end
    end
  end
end
