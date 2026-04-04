def seed_file!(record, attribute, path)
  File.open(path) do |file|
    record.public_send("#{attribute}=", file)
    record.save!
  end
end

def ensure_user!(email:, name:, bio:, password:, roles: [])
  user = User.find_or_initialize_by(email: email)
  user.name = name
  user.bio = bio

  if user.new_record?
    user.password = password
    user.password_confirmation = password
  end

  user.save!
  roles.each { |role| user.add_role(role) unless user.has_role?(role) }
  user
end

def next_brand_name
  loop do
    name = FFaker::Product.brand
    return name unless Brand.exists?(name: name)
  end
end

prices = Array.new(40) { rand(5.0..250.0).round(2) }
sample_images = [
  Rails.root.join("db", "seed_assets", "articles_logged_in.jpeg"),
  Rails.root.join("db", "seed_assets", "articles_logged_out.jpeg")
]
seed_with_images = ENV["SEED_WITH_IMAGES"] == "true" || !Rails.env.production?
reset_seed = ENV["SEED_RESET"] == "true" || !Rails.env.production?
brand_count = ENV.fetch("SEED_BRANDS_COUNT", 50).to_i
product_count = ENV.fetch("SEED_PRODUCTS_COUNT", 2500).to_i
moderator_count = ENV.fetch("SEED_MODERATORS_COUNT", 5).to_i
user_count = ENV.fetch("SEED_USERS_COUNT", 14).to_i

if reset_seed
  Role.delete_all
  OrderItem.delete_all
  Order.delete_all
  CartItem.delete_all
  Cart.delete_all
  Product.delete_all
  Brand.delete_all
  User.delete_all
end

admin = ensure_user!(
  bio: FFaker::HipsterIpsum.paragraph,
  name: "admin",
  email: "admin@gmail.com",
  password: "password",
  roles: [:admin]
)

moderator_count.times do |index|
  ensure_user!(
    bio: FFaker::HipsterIpsum.paragraph,
    name: "mod#{index + 1}",
    email: "mod#{index + 1}@gmail.com",
    password: "password",
    roles: [:mod]
  )
end

user_count.times do |index|
  ensure_user!(
    bio: FFaker::HipsterIpsum.paragraph,
    name: FFaker::Name.unique.name,
    email: "user#{index + 1}@gmail.com",
    password: "password"
  )
end

missing_brands = [brand_count - Brand.count, 0].max
missing_brands.times do
  brand = Brand.new(name: next_brand_name)
  if seed_with_images
    seed_file!(brand, :avatar, sample_images.sample)
  else
    brand.save!
  end
end

if seed_with_images
  Brand.find_each do |brand|
    next if brand[:avatar].present?

    seed_file!(brand, :avatar, sample_images.sample)
  end
end

brand_ids = Brand.pluck(:id)
missing_products = [product_count - Product.count, 0].max

if !seed_with_images && missing_products.positive?
  puts "Creating #{missing_products} products without images..."
  timestamp = Time.current
  created = 0

  while created < missing_products
    batch_size = [200, missing_products - created].min
    rows = Array.new(batch_size) do
      {
        name: FFaker::Product.product,
        description: FFaker::HipsterIpsum.paragraph,
        brand_id: brand_ids.sample,
        price: prices.sample,
        created_at: timestamp,
        updated_at: timestamp
      }
    end

    Product.insert_all!(rows)
    created += batch_size
    puts "Created #{created}/#{missing_products} products..."
  end
end

if seed_with_images && missing_products.positive?
  puts "Creating #{missing_products} products with images..."
  missing_products.times do |index|
    product = Product.new(
      name: FFaker::Product.product,
      description: FFaker::HipsterIpsum.paragraph,
      brand_id: brand_ids.sample,
      price: prices.sample
    )
    seed_file!(product, :pict, sample_images.sample)
    puts "Created #{index + 1}/#{missing_products} products with images..." if ((index + 1) % 100).zero?
  end
end

if seed_with_images
  Product.find_each.with_index(1) do |product, index|
    next if product[:pict].present?

    seed_file!(product, :pict, sample_images.sample)
    puts "Attached images to #{index}/#{Product.count} products..." if (index % 100).zero?
  end
end

if !seed_with_images
  puts "Images were skipped. Set SEED_WITH_IMAGES=true on a later deploy if you want to attach them."
else
  puts "Images are enabled for this seed run."
end

puts "Seed terminee: #{Brand.count} marques, #{Product.count} produits, #{User.count} utilisateurs."

if admin.persisted?
  puts "Compte admin: admin@gmail.com / password"
end
