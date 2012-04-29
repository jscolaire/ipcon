raw_config = File.read("#{Rails.root}/config/app_config.yml")
APP_CONFIG = YAML.load(raw_config)[Rails.env].symbolize_keys

if !File.exist?("log")
  Dir.mkdir("log")
end

pattern = Log4r::PatternFormatter.new(:pattern => "[ %l ] %d : %m")
LOGFILE = Log4r::FileOutputter.new(APP_CONFIG[:codename],
                                   :filename => APP_CONFIG[:log],
                                   :truncate => false,
                                   :pattern => pattern)

log = Log4r::Logger.new("app")
log.add(LOGFILE)
log.info("Starting app application")

