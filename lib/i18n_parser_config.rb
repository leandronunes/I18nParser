class I18nParserConfig

  def self.config
    @i18n_parser_config ||= {}
  end

  def self.locales
    config[:locales] || ['en']
  end

  def self.locales=(params = [])
    config[:locales] = params.push('en').uniq
  end

  def self.lang_dir
    config[:lang_dir] || 'lang'
  end

  def self.lang_dir=(params)
    config[:lang_dir] = params
  end 

  def self.root
    config[:root] || RAILS_ROOT
  end

  def self.root=(params)
    config[:root] = params
  end 

  def self.root
    config[:root] || RAILS_ROOT
  end

  def self.files_path=(params)
    if params.kind_of?(Array)
      config[:files_path] = params.uniq
    elsif
      config[:files_path] = [params]
    else
      config[:files_path] ||= []
    end
  end 

  def self.files_path
    config[:files_path] || [File.join(RAILS_ROOT, 'app', '**', '*')]
  end 

end
