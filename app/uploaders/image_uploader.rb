# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  include Cloudinary::CarrierWave
  include CarrierWave::RMagick
  process :resize_to_limit => [700, 700]


  process :convert => 'jpg'

  version :thumb do
    process :resize_to_limit => [300, 300]
  end
  def public_id
    model.id
  end
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    if original_filename.present?
        time = Time.now
        name = time.strftime('%Y%m%d%H%M%S') + '.jpg'
        name.downcase
    end
  end
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
