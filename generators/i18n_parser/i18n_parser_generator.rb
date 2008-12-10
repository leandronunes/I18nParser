class I18nParserGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.directory I18nParserConfig.lang_dir
      m.i18n_parser
    end
  end
end
