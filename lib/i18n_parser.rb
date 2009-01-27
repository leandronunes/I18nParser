# I18nParser
require 'rails_generator'
require 'rails_generator/commands'

module I18nParser #:nodoc:
  module Generator #:nodoc:
    module Commands #:nodoc:
      module Create
        def i18n_parser
          # Make code parser
          yaml_content = {}
          files_path = I18nParserConfig.files_path
          Dir.glob(files_path).each do |filename|
            next if File.directory?(filename)
            file = File.open(filename, "r")
            file.readlines.each do |line|
               
              str_match = line.scan(/(I18n\.|[^a-zA-Z0-9])t[ ]*[( ][ ]*[:'"]([0-9a-zA-Z_]*)['" )]?$?/)
              next if str_match.empty?
              str_match.each do |str_m|
                yaml_content[str_m[1].strip] = ''
              end
            end
          end

          # Generating lang files
          I18nParserConfig.locales.each do |lang|
            new_yaml_file = {lang => yaml_content}

            lang_path = File.join( I18nParserConfig.root, I18nParserConfig.lang_dir, lang + '.yml')

            current_yaml_file = {}
            if File.exists?(lang_path)
              old_yaml_file = YAML.load_file(lang_path) || {}
              current_yaml_file[lang] = new_yaml_file[lang].merge(old_yaml_file[lang])
            else
              current_yaml_file = new_yaml_file
            end
            write_file(lang, current_yaml_file)
          end
        end

        #FIXME Analyse why YAML.dump function didn't write the yml file correctly.
        # Files with accentuation it puts a lot off crazy characters.
        def write_file(lang, yaml_content)
          tmp_dir = File.join(I18nParserConfig.root,'tmp')
          FileUtils.mkdir_p(tmp_dir) unless File.exists?(tmp_dir)
          tmp_yaml_path = File.join(tmp_dir, lang + '_tmp.yml')
          yaml_file = File.open(tmp_yaml_path, 'w+')
          yaml_file.write("---\n")
          yaml_content.each do |lang, content| 
            yaml_file.write(lang + ":\n")
            content.each do |key, value|
              yaml_file.write("  %s: \"%s\"\n" % [key,value])
            end
          end
          yaml_file.close
          lang_path = File.join( I18nParserConfig.root, I18nParserConfig.lang_dir, lang + '.yml')
          FileUtils.mv(tmp_yaml_path,lang_path)
        end
      end
    end
  end
end

Rails::Generator::Commands::Create.send   :include,  I18nParser::Generator::Commands::Create

