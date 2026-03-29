Role.delete_all
OrderItem.delete_all
Order.delete_all
CartItem.delete_all
Cart.delete_all
Product.delete_all
Brand.delete_all
User.delete_all

prices = Array.new(40) { rand(5.0..250.0).round(2) }
sample_images = [
  Rails.root.join("db", "seed_assets", "articles_logged_in.jpeg"),
  Rails.root.join("db", "seed_assets", "articles_logged_out.jpeg")
]

admin = User.create!(
  bio: FFaker::HipsterIpsum.paragraph,
  name: "admin",
  email: "admin@gmail.com",
  password: "password",
  password_confirmation: "password"
)
admin.add_role(:admin)

5.times do |index|
  moderator = User.create!(
    bio: FFaker::HipsterIpsum.paragraph,
    name: "mod#{index + 1}",
    email: "mod#{index + 1}@gmail.com",
    password: "password",
    password_confirmation: "password"
  )
  moderator.add_role(:mod)
end

14.times do |index|
  User.create!(
    bio: FFaker::HipsterIpsum.paragraph,
    name: FFaker::Name.unique.name,
    email: "user#{index + 1}@gmail.com",
    password: "password",
    password_confirmation: "password"
  )
end

50.times do
  Brand.create!(
    name: FFaker::Product.unique.brand,
    avatar: File.open(sample_images.sample)
  )
end

brands = Brand.all.to_a

2500.times do
  Product.create!(
    name: FFaker::Product.product,
    pict: File.open(sample_images.sample),
    description: FFaker::HipsterIpsum.paragraph,
    brand: brands.sample,
    price: prices.sample
  )
end

puts "Seed terminee: #{Brand.count} marques, #{Product.count} produits, #{User.count} utilisateurs."
