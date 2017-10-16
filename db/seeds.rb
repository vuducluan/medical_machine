puts "Create 6 top categories"
["Thiết bị thí nghiệm", "Thiết bị đo lường", "Thiết bị y tế", 
  "Thiết bị công nghiệp", "Dụng cụ, vật tư", "Phụ kiện thay thế"].each_with_index do |c, i|
  Category.create! name: c, level: 0, order: i.next
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
