require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase
  fixtures :employees

  def test_invalid_with_empty_attributes
    e = Employee.new
    assert !e.valid?
    assert e.errors.invalid?(:name)
    assert e.errors.invalid?(:id_card_number)
  end

  def test_unqiue_id_card_number
    e = Employee.new(:name => "Irene", :id_card_number => employees("AKA").id_card_number)
    assert !e.valid?
    assert e.errors.invalid?(:id_card_number)
    assert_equal I18n.translate('activerecord.errors.messages')[:taken], e.errors.on(:id_card_number)
  end

  def test_valid_format_of_id_card_number
    e = Employee.new(:name => "Irene", :id_card_number => "360104740718002")
    assert !e.valid? && !e.errors.invalid?(:id_card_number)

    e = Employee.new(:name => "Irene", :id_card_number => "36010419740718001x")
    assert !e.valid?
    assert e.errors.invalid?(:id_card_number)
    assert_equal I18n.translate('activerecord.errors.messages')[:invalid], e.errors.on(:id_card_number)
  end
end
