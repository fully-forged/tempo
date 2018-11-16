FROM elixir:1.7.4

COPY . /app
WORKDIR /app

RUN mix local.hex --force
RUN mix deps.get
RUN mix local.rebar --force
RUN mix deps.compile
