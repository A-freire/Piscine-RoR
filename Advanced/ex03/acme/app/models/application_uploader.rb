class ApplicationUploader < CarrierWave::Uploader::Base
  if ENV["CLOUDINARY_CLOUD_NAME"].present?
    include Cloudinary::CarrierWave
  else
    storage :file
  end

  def extension_allowlist
    %w[jpg jpeg gif png webp]
  end

  def content_type_allowlist
    [/image\//]
  end

  def size_range
    1.byte..10.megabytes
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
