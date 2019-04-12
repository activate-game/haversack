# Haversack

Haversack is an Elixir + Phoenix web app that serves as a backend for [Blackguard](https://github.com/activate-game/blackguard) and [Conjurer](https://github.com/activate-game/conjurer) via a GraphQL web API.

This project was built for my [Activate](http://www.activateconf.com/) 2019 workshop, _Let’s Go On an Adventure: Building a Realtime, Collaborative Game with Web Tech_. One of the central ideas behind that workshop was that this project—and its related projects—should serve as but an MVP for a game, so PRs are welcome!

## Table of contents

- [Getting Started](#getting-started)
  - [Learn More About Phoenix](#learn-more-about-phoenix)
- [Contributing](#contributing)
- [Licenses](#licenses)

## Getting Started

You’ll need the following tools installed:

* Erlang/OTP 21
* Elixir 1.8
* PostgreSQL 11

First, clone the repo and then install the dependencies:

    mix deps.get

Next, initialize the database before proceeding:

    mix ecto.setup

Finally, start the app:

    mix phx.server

The server runs by default at [`localhost:4000`](http://localhost:4000).

### Learn more about Phoenix

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
  
## Contributing

If you submit a PR, please adhere to the [Code of Conduct](https://github.com/activate-game/haversack/blob/master/CODE_OF_CONDUCT.md).

## License

This project is [GPL-3.0-or-later © Nicholas Scheurich](https://github.com/haversack/blackguard/blob/master/LICENSE).
