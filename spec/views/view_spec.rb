require 'spec_helper'

describe 'Compositor views', type: :view do  
  let(:source) do
    <<-RUBY
    string string: 'hello'
    RUBY
  end
  
  let(:partials) {
    {'test.json.compositor' => source}
  }
  
  let(:result) { JSON.parse(ActionView::Template.new(source, 'test', Compositor::Rails::Handler, :virtual_path => 'test').render(self, {}).strip) }
  
  before do
    lookup_context.view_paths = [ActionView::FixtureResolver.new(partials)]
  end
  
  it 'renders the compositor' do
    expect(result['string']).to eq('hello')
  end
end