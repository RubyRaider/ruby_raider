# :reek:FeatureEnvy { enabled: false }
# :reek:UtilityFunction { enabled: false }

module SettingsHelper
  def create_settings(options)
    automation = options[:automation]
    visual = options[:visual]
    framework = options[:framework]
    {
      automation:,
      framework:,
      name: "#{framework}_#{automation}#{'_visual' if visual}",
      visual:
    }
  end
end
