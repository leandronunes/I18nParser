require 'test_helper'
require 'rails_generator'
require 'rails_generator/scripts/generate'

class I18nParserTest < ActiveSupport::TestCase

  def setup
    I18nParserConfig.root = File.join(RAILS_ROOT, 'vendor', 'plugins', 'i18n_parser', 'test')
    I18nParserConfig.files_path = File.join(RAILS_ROOT, 'vendor', 'plugins', 'i18n_parser', 'test', 'app', '**', '*')
    I18nParserConfig.lang_dir = 'lang'
    I18nParserConfig.locales = ['en', 'some', 'another']
  end

  def test_generate_locales
    I18nParserConfig.locales.each do |lang|
      file_path = File.join(I18nParserConfig.root,I18nParserConfig.lang_dir, lang + '.yml')
      IO.popen("rm #{file_path}") if File.exists?(file_path)
    end

    Rails::Generator::Scripts::Generate.new.run(["i18n_parser"])
    I18nParserConfig.locales.map do |lang|
      file_path = File.join(I18nParserConfig.root, I18nParserConfig.lang_dir, lang + '.yml')
      assert File.exists?(file_path)
    end
  end

  # This test will verify if the files generated are correct.
  # To do that, the parser made on test/app directory have to
  # generate languages file only with "match_n" symbols n is an
  # integer.
  #
  # To make this test possible you have to put the files in 
  # 'test/app' directory following the rules bellow:
  #
  #     1. When a string should be translated according rails I18n 
  #     definition put the symbol ':match_n' on it. 'n' is an integer.
  #
  #     2. When a string shouldn't be translated put any symbol on it,
  #     except symbols that match with the pattern "match_[0-9]+".
  def test_generate_correct_files
    Rails::Generator::Scripts::Generate.new.run(["i18n_parser"])
    expected_symbols = []
    Dir.glob(I18nParserConfig.files_path).each do |filename|
      next if File.directory?(filename)
      file = File.open(filename, "r")
      file.readlines.each do |line|
        str_match = line.scan(/(match_[0-9]+)/)
        next if str_match.empty?
        str_match.each do |str_m|
          expected_symbols.push(str_m[0].strip)
        end
      end
    end

    I18nParserConfig.locales.map do |lang|
      file_path = File.join(I18nParserConfig.root, I18nParserConfig.lang_dir, lang + '.yml')
      yaml_file = YAML.load_file(file_path)
      assert yaml_file

      assert_equal([], (expected_symbols - yaml_file[lang].keys))

      yaml_file[lang].delete_if do |key, value|
        expected_symbols.include?(key)
      end
      assert_equal({}, yaml_file[lang])
    end

  end


end
