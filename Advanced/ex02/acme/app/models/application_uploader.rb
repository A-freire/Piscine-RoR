class ApplicationUploader < CarrierWave::Uploader::Base
  CLOUDINARY_ENV_KEYS = %w[
    CLOUDINARY_CLOUD_NAME
    CLOUDINARY_API_KEY
    CLOUDINARY_API_SECRET
  ].freeze

  if CLOUDINARY_ENV_KEYS.all? { |key| ENV[key].present? }
    include Cloudinary::CarrierWave
  else
    storage :file
  end

  def self.cloudinary_configured?
    CLOUDINARY_ENV_KEYS.all? { |key| ENV[key].present? }
  end

  def cloudinary_configured?
    self.class.cloudinary_configured?
  end

  def transformed_url(width:, height:)
    return url unless cloudinary_configured?

    url(
      width: width,
      height: height,
      crop: :fill,
      gravity: :auto,
      fetch_format: :auto,
      quality: :auto
    )
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
