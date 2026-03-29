module ApplicationHelper
  def owner_login
    ENV.fetch("OWNER_LOGIN", "bexas")
  end

  def money(value)
    number_to_currency(value || 0, unit: "EUR", separator: ",", delimiter: " ")
  end

  def transformed_image_url(uploader, width:, height:)
    return nil unless uploader.present?

    if uploader.class.ancestors.include?(Cloudinary::CarrierWave)
      uploader.url(width: width, height: height, crop: :fill, gravity: :auto, fetch_format: :auto, quality: :auto)
    else
      uploader.url
    end
  end

  def can_manage_catalog?
    current_user&.admin? || current_user&.mod?
  end
end
