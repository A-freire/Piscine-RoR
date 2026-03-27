Vote.destroy_all
Post.destroy_all
User.destroy_all

password = "password123"

admin = User.create!(name: "admin", email: "admin@example.com", password:, password_confirmation: password, admin: true)
bob2 = User.create!(name: "bob2", email: "bob2@example.com", password:, password_confirmation: password)
stephan = User.create!(name: "Stephan", email: "stephan@example.com", password:, password_confirmation: password)
alice = User.create!(name: "alice", email: "alice@example.com", password:, password_confirmation: password)
mentor = User.create!(name: "mentor", email: "mentor@example.com", password:, password_confirmation: password)
rookie = User.create!(name: "rookie", email: "rookie@example.com", password:, password_confirmation: password)

bob_post = bob2.posts.create!(
  title: "How to tell if the water is too hot?",
  content: "Dip your baby in it and check its temperature with the inside of your wrist."
)
stephan_post = stephan.posts.create!(
  title: "How to stop oversalting soup",
  content: "Add a peeled potato for a few minutes to absorb some of the excess salt."
)
alice_post = alice.posts.create!(
  title: "How to cool down coffee quickly",
  content: "Pour it into a wider mug to increase the surface area and lose heat faster."
)
mentor_post = mentor.posts.create!(
  title: "How to keep cables organized",
  content: "Reuse empty toilet paper rolls to separate each cable in a drawer."
)

2.times do
  Vote.create!(user: admin, post: bob_post, value: 1)
end

3.times do
  Vote.create!(user: admin, post: stephan_post, value: 1)
end
Vote.create!(user: bob2, post: stephan_post, value: 1)

8.times do
  Vote.create!(user: admin, post: mentor_post, value: 1)
end
Vote.create!(user: bob2, post: mentor_post, value: 1)
Vote.create!(user: stephan, post: mentor_post, value: 1)

alice_post.update!(content: "#{alice_post.content}\n\nUse a metal spoon in the mug if you want even faster cooling.")
alice_post.update!(last_editor: stephan, last_edited_at: Time.current)

puts "Seed completed."
puts "Test accounts:"
puts "admin / #{password}"
puts "bob2 / #{password}"
puts "Stephan / #{password}"
puts "alice / #{password}"
puts "mentor / #{password}"
puts "rookie / #{password}"
