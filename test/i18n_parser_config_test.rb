require 'test_helper'

class I18nParserConfigTest < ActiveSupport::TestCase

  def test_config_is_a_hash
    assert_kind_of Hash, I18nParserConfig.config
  end

  def test_locales_is_an_array
    assert_kind_of Array, I18nParserConfig.locales
  end

  def test_locales_has_at_least_one_lang
    assert I18nParserConfig.locales.length > 0

    I18nParserConfig.locales = []
    assert I18nParserConfig.locales.length > 0
  end

  def test_locales_must_have_en_lang
    assert I18nParserConfig.locales.include?('en')

    I18nParserConfig.locales = []
    assert I18nParserConfig.locales.include?('en')

    I18nParserConfig.locales = ['some']
    assert I18nParserConfig.locales.include?('en')
  end

  def test_should_define_locales
    I18nParserConfig.locales = ['some']
    assert I18nParserConfig.locales.include?('some')
  end

  def test_should_have_uniq_locales
    I18nParserConfig.locales = ['some', 'some', 'en']

    locales = I18nParserConfig.locales.select{ |l| l == 'some'}
    assert_equal 1, locales.length

    locales = I18nParserConfig.locales.select{ |l| l == 'en'}
    assert_equal 1, locales.length

  end

  def test_should_have_lang_dir
    assert_not_nil I18nParserConfig.lang_dir

    I18nParserConfig.lang_dir = nil
    assert_not_nil I18nParserConfig.lang_dir

    I18nParserConfig.lang_dir = ''
    assert_not_nil I18nParserConfig.lang_dir
  end

  def test_should_have_root_defined
    assert_not_nil I18nParserConfig.root

    I18nParserConfig.root = nil
    assert_not_nil I18nParserConfig.root

    I18nParserConfig.root = ''
    assert_not_nil I18nParserConfig.root
  end

  def test_should_have_rails_root_as_default_root
    I18nParserConfig.root = nil
    assert_equal RAILS_ROOT, I18nParserConfig.root
  end

  def test_should_define_a_root
    I18nParserConfig.root= '/some'
    assert_equal '/some', I18nParserConfig.root
  end

  def test_should_have_at_lest_one_file_path
    I18nParserConfig.files_path= nil
    assert_equal 1, I18nParserConfig.files_path.length
  end

  def test_should_have_unique_files_path
    I18nParserConfig.files_path = ['/some/*', '/some/*', '/another/**/*']
    assert_equal 2, I18nParserConfig.files_path.length
  end

  def test_should_have_an_default_file_path
    I18nParserConfig.files_path= nil
    assert_equal File.join(RAILS_ROOT, 'app', '**', '*'), I18nParserConfig.files_path.first
  end

  def test_should_file_path_be_an_array
    assert_equal Array, I18nParserConfig.files_path
    I18nParserConfig.files_path = nil
    assert_equal Array, I18nParserConfig.files_path
    I18nParserConfig.files_path = ''
    assert_equal Array, I18nParserConfig.files_path
    I18nParserConfig.files_path = 'some'
    assert_equal Array, I18nParserConfig.files_path
  end

end
