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

puts "create slider images"
slider_imgs = Dir.glob "public/jssor/*"
3.times do |i|
  img = SliderCatalog.create title: Faker::Lorem.sentence,
    desc: Faker::Lorem.paragraph, caption: Faker::Lorem.sentence,
    alt: Faker::Lorem.sentence, image_type: "slider"
  File.open(slider_imgs[i]) do |f|
    img.url = f
  end
  img.save!
end
puts "slider images OK"

puts "create catalog images"
catalog_imgs = Dir.glob "public/catalog/*"
2.times do |i|
  img = SliderCatalog.create title: Faker::Lorem.sentence,
    desc: Faker::Lorem.paragraph, caption: Faker::Lorem.sentence,
    alt: Faker::Lorem.sentence, image_type: "catalog"
  File.open(catalog_imgs[i]) do |f|
    img.url = f
  end
  img.save!
end
puts "catalog images OK"

puts "create label"
["Sale", "Hot", "Weekly", "Trend", "Feature"].each_with_index do |c, i|
  Label.create! title: c, block_order: i + 1, short_title: c
end
puts "create label OK"

puts "create Brand"
50.times do |i|
  Brand.create! name: Faker::Lorem.sentence[0..10], location: Faker::Lorem.sentence[0..10]
end
puts "Brand OK"

puts "create product"
300.times do |i|
  a = 97 + i%25
  Product.create! name: "#{a.chr}#{Faker::Lorem.sentence}", model: Faker::Lorem.sentence, location: Faker::Lorem.sentence,
    price: rand(10000), discount_price: rand(9000), description: Faker::Lorem.paragraph, label_order: i, category_order: i + 2,
    short_description: Faker::Lorem.sentence, label_id: i%5 + 1, brand_id: i%50 + 1
end
puts "product OK"

puts "create images for products"
p_imgs = Dir.glob "public/product/*"
Product.all.each_with_index do |b, i|
  5.times do |j|
    new_img = b.product_images.build title: Faker::Lorem.sentence, url: Faker::Lorem.sentence,
      desc: Faker::Lorem.paragraph, caption: Faker::Lorem.sentence,
      alt: Faker::Lorem.sentence
    File.open(p_imgs[j]) do |f|
      new_img.url = f
    end
    new_img.save!
  end
end
puts "product images OK"

puts "create Category level 2"
300.times do |i|
  a = 97 + i%25
  Category.create! name: "#{a.chr}#{Faker::Lorem.sentence}", level: 2
end
puts "Category level 2 OK"

puts "create Field"
10.times do |i|
  Field.create! name: Faker::Lorem.sentence
end
puts "Field OK"

puts "create product_categoies"
Product.all.each_with_index do |p, i|
  ProductCategory.create product_id: i%30, category_id: rand(10)
end
puts "product_categoies OK"

puts "create product_fields"
Product.all.each_with_index do |p, i|
  ProductField.create product_id: i%30, field_id: rand(10)
end
puts "product_fields OK"

puts "Create media..."
Medium.create!title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, url: "/uploads/media/admin_export_candidate.xlsx", media_type: 0, field_id: 0
Medium.create!title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, url: "/uploads/media/report_3.doc", media_type: 0, field_id: 0
Medium.create!title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, url: "/uploads/media/resume_search.doc", media_type: 0, field_id: 1
Medium.create!title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, url: "/uploads/media/Rails_4_in_Action_v11_MEAP.pdf", media_type: 0, field_id: 0
Medium.create!title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, url: "/uploads/media/Pro React.pdf", media_type: 0, field_id: 0
Medium.create!title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, url: "/uploads/media/admin_export_candidate.xlsx", media_type: 0, field_id: 1
Medium.create!title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, url: "/uploads/media/report_3.doc", media_type: 0, field_id: 0
Medium.create!title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, url: "/uploads/media/resume_search.doc", media_type: 0, field_id: 1
Medium.create!title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, url: "/uploads/media/Rails_4_in_Action_v11_MEAP.pdf", media_type: 0, field_id: 1
Medium.create!title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, url: "/uploads/media/Pro React.pdf", media_type: 0, field_id: 0

10.times do |i|
  field = i < 5 ? 0 : 1
  Medium.create!title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, url: "https://www.youtube.com/embed/ptLFrU_zrEQ", media_type: 1, field_id: field
end

puts "Create media: doc & pdf OK"
