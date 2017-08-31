use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :office, OfficeWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [node: ["node_modules/brunch/bin/brunch", "watch", "--stdin",
                    cd: Path.expand("../assets", __DIR__)]]


# Watch static and templates for browser reloading.
config :office, OfficeWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{lib/office/web/views/.*(ex)$},
      ~r{lib/office/web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :office, Office.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "office",
  password: "office",
  database: "office_dev",
  hostname: "localhost",
  pool_size: 10

config :ex_debug_toolbar,
  enable: true

config :office, OfficeWeb.Endpoint,
  instrumenters: [ExDebugToolbar.Collector.InstrumentationCollector]

config :office, Office.Repo,
  loggers: [ExDebugToolbar.Collector.EctoCollector, Ecto.LogEntry]

config :phoenix, :template_engines,
  eex: ExDebugToolbar.Template.EExEngine,
  exs: ExDebugToolbar.Template.ExsEngine
