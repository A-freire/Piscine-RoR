cloudinary_env_keys = %w[
  CLOUDINARY_CLOUD_NAME
  CLOUDINARY_API_KEY
  CLOUDINARY_API_SECRET
].freeze

missing_cloudinary_keys = cloudinary_env_keys.reject { |key| ENV[key].present? }

if missing_cloudinary_keys.empty?
  Cloudinary.config do |config|
    config.cloud_name = ENV["CLOUDINARY_CLOUD_NAME"]
    config.api_key = ENV["CLOUDINARY_API_KEY"]
    config.api_secret = ENV["CLOUDINARY_API_SECRET"]
    config.secure = true
  end
elsif missing_cloudinary_keys.length != cloudinary_env_keys.length
  Rails.logger.warn(
    "Cloudinary desactive: variables manquantes #{missing_cloudinary_keys.join(', ')}."
  )
end
