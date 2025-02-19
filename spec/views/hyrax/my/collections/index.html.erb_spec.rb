# frozen_string_literal: true
RSpec.describe "hyrax/my/collections/index.html.erb", type: :view do
  let(:resp) { double(docs: "", total_count: 11) }

  before do
    assign(:managed_collection_count, 0)
    assign(:response, resp)

    allow(view).to receive(:can?).with(any_args).and_return(false)

    stub_template "hyrax/my/collections/_scripts" => " "
    stub_template "hyrax/my/collections/_default_group" => " "
    stub_template "hyrax/my/collections/_search_header" => " "
    stub_template "hyrax/my/collections/_results_pagination" => " "

    stub_template "hyrax/my/collections/_modal_add_to_collection" => " "
    stub_template "hyrax/my/collections/_modal_add_to_collection_deny" => " "
    stub_template "hyrax/my/collections/_modal_add_to_collection_permission_deny" => " "
    stub_template "hyrax/my/collections/_modal_collection_types_to_create" => " "
    stub_template "hyrax/my/collections/_modal_delete_admin_set_deny" => " "
    stub_template "hyrax/my/collections/_modal_delete_collection" => " "
    stub_template "hyrax/my/collections/_modal_delete_collection_deny" => " "
    stub_template "hyrax/my/collections/_modal_delete_collections_deny" => " "
    stub_template "hyrax/my/collections/_modal_delete_deny" => " "
    stub_template "hyrax/my/collections/_modal_delete_empty_collection" => " "
    stub_template "hyrax/my/collections/_modal_delete_selected_collections" => " "
    stub_template "hyrax/my/collections/_modal_edit_deny" => " "
  end

  it 'indicate the number of collections to be 11' do
    render
    expect(rendered).to have_content("11 collections in the repository")
  end

  describe 'tabs' do
    let(:ability) { instance_double(Ability, admin?: false) }

    before do
      assign(:managed_collection_count, 1)
      allow(view).to receive(:current_ability).and_return(ability)
    end

    it 'shows managed and my collections' do
      render
      expect(rendered).to have_link('Managed Collections')
      expect(rendered).to have_link('Your Collections')
    end

    context 'as admin' do
      let(:ability) { instance_double(Ability, admin?: true) }

      it 'shows all and my collections' do
        render
        expect(rendered).to have_link('All Collections')
        expect(rendered).to have_link('Your Collections')
      end
    end
  end
end
