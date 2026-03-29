RailsAdmin.config do |config|
  config.asset_source = :sprockets

  config.authenticate_with do
    authenticate_user!
  end
  config.current_user_method(&:current_user)
  config.authorize_with :cancancan

  config.model "User" do
    list do
      field :email
      field :name
      field :roles
    end

    edit do
      field :email
      field :name
      field :bio
      field :password
      field :password_confirmation
      field :roles
    end
  end

  config.model "Brand" do
    edit do
      field :name
      field :avatar, :carrierwave
    end
  end

  config.model "Product" do
    edit do
      field :name
      field :description
      field :price
      field :brand
      field :pict, :carrierwave
    end
  end

  config.actions do
    dashboard
    index
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
  end
end
