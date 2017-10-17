puts "Create 6 top categories"
["Thiết bị thí nghiệm", "Thiết bị đo lường", "Thiết bị y tế", 
  "Thiết bị công nghiệp", "Dụng cụ, vật tư", "Phụ kiện thay thế"].each_with_index do |c, i|
  Category.create! name: c, level: 0, category_order: i.next
end
puts "Status: OK"

puts "Create news blog category"
bc = BlogCategory.create! id: 1, name: "news"

puts "Create news template"
nt = Template.create! name: "news", content: Faker::Lorem.paragraph

puts "Create 10 news articles"
10.times do |i|
  Blog.create! title: Faker::Lorem.sentence, template: nt,
    blog_category: bc, content: Faker::Lorem.paragraph    
end
puts "Create articles OK"

puts "create images for news blogs"
img_files = Dir.glob "public/girl/*"
Blog.all.limit(10).each_with_index do |b, i|
  new_img = b.blog_images.build title: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph, caption: Faker::Lorem.sentence,
    alt: Faker::Lorem.sentence, is_feature: true
  File.open(img_files[i]) do |f|
    new_img.url = f
  end
  new_img.save!
end
puts "blog images OK"

Company.create! about: Faker::Lorem.paragraph,
  phone: "0987.657.234", work_time:"7AM-9PM", email:"vattuthinghiem@gmail.com",
  facebook: "http://facebook.com", instagram:"http://instagram.com",
  contact_info:"Nguyen Thanh Tu", address:"Nhà N02F, KĐT Mễ Trì Thượng, Phường Mễ Trì, Quận Nam Từ Liêm - Hà Nội",
  website:"http://thiendiahoi.com"
puts "Create Company information OK"

10.times do |i|
  Tag.create! name: Faker::Lorem.word, tag_url: "http://thiendiahoi.com"
end
puts "Create Tags OK"
