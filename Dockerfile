FROM elixir:1.7.4

RUN mix local.hex --force
RUN mix local.rebar --force

COPY . /app
WORKDIR /app

RUN mix deps.get
RUN mix compile
