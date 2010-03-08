require 'test_helper'

class ResourceTest < ActiveSupport::TestCase
  fixtures :resources
  
  def test_invalid_with_empty_attributes
    resource = Resource.new
    assert !resource.valid?
    assert resource.errors.invalid?(:scope)
    assert resource.errors.invalid?(:key)
    assert resource.errors.invalid?(:value)
  end
  
  def test_valid_with_default_value
    resource = Resource.new
    assert_equal("String", resource.klass)
    assert_equal("active", resource.mode)
  end
  
  def test_mode
    yes = %w{ active inactive disabled }
    no = %w{ a b c}
    yes.each do |mode|
      resource = Resource.new(:scope => "system",
      :klass => "String",
      :key => "page_size",
      :value => "20",
      :mode => mode
      )
      assert resource.valid?, resource.errors.full_messages
    end
    no.each do |mode|
      resource = Resource.new(:scope => "system",
      :klass => "String",
      :key => "page_size",
      :value => "20",
      :mode => mode
      )
      assert !resource.valid?, "error #{mode}"
    end
  end
  
  def test_system_preferences
    preferences = Resource.system_preferences
    assert_equal(1, preferences.size)
  end
  
  def test_get_preference
    assert_equal(20, Resource["PageSize"])
  end
  
  def test_unqiue_key
    resource = Resource.new(:scope => "system",
    :klass => "String",
    :key => "page_size",
    :value => "20",
    :mode => "active"
    )
    
    assert resource.valid?
    resource = Resource.new(:scope => "system",
    :klass => "String",
    :key => resources("PageSize").key,
    :value => "20",
    :mode => "active"
    )
    assert !resource.valid?
  end
end
