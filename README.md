# Toll

![Toll](http://cdn2.hubspot.net/hub/42741/file-29805357-jpg/images/toll-booth1-resized-600.jpg)

Toll is a small yet powerful library to help you handle authentication for your Rails API using the right response headers & code.

## Table of contents
- [Quick start](#quick-start)
- [Configuration](#configuration)
- [Sessions Controller Example](#sessions-controller-example)
- [Bug tracker & feature request](#bug-tracker-&-feature-request)
- [Documentation or Installation instructions](#documentation)
- [Contributing](#contributing)
- [Community](#community)
- [Heroes](#heroes)
- [License](#license)


## Quick Start

`toll` is really easy to install, you just need to add it to your Gemfile:

```ruby
gem 'toll'
```

And then execute:

```console
% bundle install
```

## Configuration

After installing the gem, it is highly recommended that you generate the configuration initializer:

```console
% rails g toll:install
```

The last command should create a file under `config/initializers` called `toll.rb`, you can leave the defaults for now.

After that you can start creating models that will be authenticated for the API, commonly a `User` model:

```console
% rails g toll User <attributes>
```

**WATCH OUT: We only support authentication for User models**

The `toll` generator will add an attribute called `authentication_token` for the `User`, but you can call it whatever you want and configure it on the `toll` initializer.

It will also add a `tollify` method to the `User` model which has all the logic to handle the token generation and authentication.

Last thing but really important is to include the `Authenticable` module to the `ApplicationController` or the one you are inheriting from on your API.

**app/controllers/application_controller.rb**

```ruby
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  include Toll::Controllers::Authenticable
end
```

### Session methods

The `Authenticable` module for the controllers provide a set of handy methods, which by the name you may be already familiar with:

```ruby
authenticate! # You can call this method to make sure a user is signed in

current_user # returns the user on 'session'

authenticated? # true or false whether the user is authenticated or not
```

## Sessions Controller Example

We provide a super simple example for a sessions controller using some of the [devise](https://github.com/plataformatec/devise) methods:

```ruby
class SessionsController < ApplicationController
  before_action :authenticate!, only: [:destroy]

  def create
    # session: {
    #  email: "email@example.com",
    #  password: "12345678"
    # }

    user_email = params[:session][:email]
    user_password = params[:session][:password]

    user = user_email.present? && User.find_by(email: user_email)
    # => user
    # => nil

    if user.valid_password? user_password
    	# the authenticate_with_token is provided by the Toll gem
      user.authenticate_with_token
      render json: user, status: :ok
    else
      render json: { session: { errors: "Invalid email or password" }}, status: :unprocessable_entity
    end
  end

  def destroy
	 # the sign_out is provided by the Toll gem
	 # it is an alias for the authenticate_with_token
    current_user.sign_out
    head :no_content
  end
end
```

## Bug tracker & feature request

Have a bug or a feature request? [Please open a new issue](https://github.com/IcaliaLabs/toll/issues). Before opening any issue, please search for existing issues.

## Contributing

Please submit all pull requests against a separate branch. Although it does not have tests yet, be a nice guy and add some for your feature. We'll be working hard to add them too.

In case you are wondering what to attack, we have a milestone with the version to work, some fixes and refactors. Feel free to start one.

Thanks!

## Heroes

**Abraham Kuri**

+ [http://twitter.com/kurenn](http://twitter.com/kurenn)
+ [http://github.com/kurenn](http://github.com/kurenn)
+ [http://klout.com/#/kurenn](http://klout.com/#/kurenn)

## License

Code and documentation copyright 2015 Icalia Labs. Code released under [the MIT license](LICENSE).