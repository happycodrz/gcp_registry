use Mix.Config

config :goth, config_module: GcpRegistry.GothInit

if File.exists?("config/#{Mix.env()}.exs") do
  import_config "#{Mix.env()}.exs"
end
