puts "🗑️ Destroying all records..."
Family.destroy_all
User.destroy_all
puts "✅ All records destroyed!"

puts "👤 Creating users..."
user1 = User.create!(name: "Aimeric - Test1", email: "aimerictest1@famizy.fr", password: "12345678")
user2 = User.create!(name: "Aimeric - Test2", email: "aimerictest2@famizy.fr", password: "12345678")
puts "✅ Users created!"

puts "👪 Creating families..."
family1 = Family.create!(name: "La maison du bonheur")
family_member1 = FamilyMember.create!(family: family1, user: user1, role: "parent")
family_member2 = FamilyMember.create!(family: family1, user: user2, role: "child")
puts "✅ Families created!"

puts "Seeding done! 🌱"
