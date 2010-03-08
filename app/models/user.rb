class User < ActiveRecord::Base
  has_many :permissions, :dependent => :delete_all
  has_many :roles, :through => :permissions

  belongs_to :default_group, :class_name => "Group", :foreign_key => "default_group_id"

  named_scope :all_users, :conditions => ["name != 'sysAdmin'"]

  validates_presence_of :name, :full_name, :email, :password
  validates_uniqueness_of :name, :email
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/
  validates_confirmation_of :password

  def password
    @password
  end

  def password=(password)
    @password = password
    return if password.blank?
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end

  def self.authenticate(name, password)
    user = self.find_by_name(name)
    if user
      expected_password = encrypted_password(password, user.salt)
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user
  end

  private

  def create_new_salt
    self.salt = [Array.new(6){rand(256).chr}.join].pack("m").chomp
  end

  def self.encrypted_password(password, salt)
    string_to_hash = password + "Mermaid" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end
end
