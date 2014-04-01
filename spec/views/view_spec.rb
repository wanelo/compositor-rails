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


  describe '#partial' do
    let(:source) do
      <<-RUBY
        partial! 'boom', explosion: 'hai' 
      RUBY
    end

    let(:partial) do
      <<-RUBY
        string string: explosion
      RUBY
    end

    let(:partials) { { 'test.json.compositor' => source, '_boom.json.compositor' => partial } }

    it 'renders the partial' do
      expect(result['string']).to eq('hai')
    end
  end
end
