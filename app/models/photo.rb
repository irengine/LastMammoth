class Photo < ActiveRecord::Base
  belongs_to :employee

  has_attachment :content_type => :image,
    :storage => :file_system,
    :path_prefix => 'public/files',
    :content_type => :image,
    :size => 0.kilobytes..500.kilobytes

  validates_as_attachment
end
