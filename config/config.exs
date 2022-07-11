import Config

if File.exists?(Path.join([__DIR__, "config.secret.exs"])) do
  import_config "config.secret.exs"
end
