# Compositor::Rails

Extensions to compositor that allow views to be created and used inside of Rails.

## Installation

Add this line to your application's Gemfile:

    gem 'compositor-rails'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install compositor-rails

## Usage

Given a `UserCompositor` as follows:

```ruby
# File: app/compositors/user_compositor.rb
class UserCompositor < Compositor::Leaf
  attr_accessor :user

  def initialize(context, user, attrs = {})
    super(context, attrs)
    self.user = user
  end

  def to_hash
    {
        id: user.id,
        username: user.username,
        location: user.location,
        bio: user.bio,
        url: user.url,
        image_url: context.image_path(user.avatar),  # using context to generate URL path from routes
        ...
    }
  end
end
```

To render a list of users, create a view and then write out the DSL as you normally would.

```ruby
# File: app/views/users/index.json.compositor
list :collection: @users, root: :users do |u|
  user: u
end
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/compositor-rails/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
