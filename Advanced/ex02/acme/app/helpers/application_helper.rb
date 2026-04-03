module ApplicationHelper
  def owner_login
    ENV.fetch("OWNER_LOGIN", "bexas")
  end

  def money(value)
    number_to_currency(value || 0, unit: "EUR", separator: ",", delimiter: " ")
  end

  def transformed_image_url(uploader, width:, height:)
    return nil unless uploader.present?
    return uploader.transformed_url(width: width, height: height) if uploader.respond_to?(:transformed_url)

    uploader.url
  end

  def cloudinary_enabled?
    ApplicationUploader.cloudinary_configured?
  end

  def can_manage_catalog?
    current_user&.admin? || current_user&.mod?
  end
end
