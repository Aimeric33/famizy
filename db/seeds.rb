puts "🗑️ Destroying all records..."
Family.destroy_all
User.destroy_all
puts "✅ All records destroyed!"

puts "👤 Creating users..."
user1 = User.new(name: "Aimeric One", email: "aimerictest1@famizy.fr", password: "12345678", birth_date: "1996-09-06")
user1.skip_confirmation!
user1.save!

user2 = User.new(name: "Aimeric Two", email: "aimerictest2@famizy.fr", password: "12345678", birth_date: "1990-01-01")
user2.skip_confirmation!
user2.save!
puts "✅ Users created!"

puts "👪 Creating families..."
family1 = Family.create!(name: "La maison du bonheur", description: "On teste une famille pour voir si tout fonctionne bien")
family_member1 = FamilyMember.create!(family: family1, user: user1, role: "parent")
family_member2 = FamilyMember.create!(family: family1, user: user2, role: "child")
puts "✅ Families created!"

puts "Seeding done! 🌱"
