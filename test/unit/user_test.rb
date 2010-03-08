require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users

  def test_invalid_with_empty_attributes
    user = User.new
    assert !user.valid?
    assert user.errors.invalid?(:name)
    assert user.errors.invalid?(:full_name)
    assert user.errors.invalid?(:email)
    assert user.errors.invalid?(:password)
  end

  def test_email
    yes = %w{ a@b.com a.b@c.com a_b@c.com }
    no = %w{ a#b.com a@b.c a@_b.com }
    yes.each do |email|
      user = User.new(:name => "aka",
        :full_name => "Alex Tang",
        :email => email,
        :password => 'password'
      )
      puts user.hashed_password, user.salt
      assert user.valid?, user.errors.full_messages
    end
    no.each do |email|
      user = User.new(:name => "aka",
        :full_name => "Alex Tang",
        :email => email,
        :password => 'password'
      )
      puts user.hashed_password, user.salt
      assert !user.valid?, "error #{email}"
    end
  end

  def test_password
    # TODO: how to test password and password confirmation
  end

  def test_unique_name
    user = User.new(:name => users(:alex).name,
      :full_name => "Alex Tang",
      :email => "lalextang@msn.com")
    assert !user.save
    assert_equal I18n.translate('activerecord.errors.messages')[:taken], user.errors.on(:name)
  end

  def test_unique_email
    user = User.new(:name => "aka",
      :full_name => "Alex Tang",
      :email => users(:alex).email)
    assert !user.save
    assert_equal I18n.translate('activerecord.errors.messages')[:taken], user.errors.on(:email)
  end

  def test_authenticate
    assert_nil User.authenticate(users(:alex).name, 'secret')
    assert_not_nil User.authenticate(users(:alex).name, 'password')
    assert_nil User.authenticate(users(:irene).name, 'secret')
    assert_not_nil User.authenticate(users(:irene).name, 'password')
  end
end
