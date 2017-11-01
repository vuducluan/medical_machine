puts "Create 6 top categories"
["Thiết bị thí nghiệm", "Thiết bị đo lường", "Thiết bị y tế",
  "Thiết bị công nghiệp", "Dụng cụ, vật tư", "Phụ kiện thay thế"].each_with_index do |c, i|
  Category.create! name: c, level: Settings.category.highest_level, category_order: i.next
end
puts "Status: OK"

puts "Create template category"
5.times do |i|
  Template.create! name: Faker::Lorem.sentence[0..8], content: Faker::Lorem.paragraph
end

puts "Create 10 news articles"
20.times do |i|
  Blog.create! title: Faker::Lorem.sentence, template: Template.find(5 - rand(4)),
    content: Faker::Lorem.paragraph(30, true), is_important: [true, false].sample,
    relation_blog_id_1: rand(20) + 1, relation_blog_id_2: rand(20) + 1
end
puts "Create articles OK"

puts "Create news blog category and relation"
5.times do |i|
  bc = BlogCategory.create! id: i + 1, name: Faker::Lorem.sentence[0..8]
  10.times do |j|
    BlogCategoryRelation.create! blog_id: rand(20) + 1, blog_category_id: bc.id
  end
end

puts "Create blog tag and relation"
10.times do |i|
  bc = Tag.create! id: i + 1, name: Faker::Lorem.sentence[0..8]
  10.times do |j|
    BlogTagRelation.create! blog_id: rand(20) + 1, tag_id: bc.id
  end
end

puts "create images for news blogs"
img_files = Dir.glob "public/blog/*"
Blog.all.each_with_index do |b, i|
  3.times do |j|
    new_img = b.blog_images.build title: Faker::Lorem.sentence,
      description: Faker::Lorem.paragraph, caption: Faker::Lorem.sentence,
      alt: Faker::Lorem.sentence, is_feature: true
    File.open(img_files[(j+10)%7]) do |f|
      new_img.url = f
    end
    new_img.save!
  end
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
[{sale: "Sản phẩm khuyến mại"}, {hot: "Sản phẩm HOT"}, {weekly: "Sản phẩm nổi bật tuần"}, {trend: "Sản phẩm trending"}, {feature: "Sản phẩm nổi bật"}].each_with_index do |c, i|
  Label.create! title: c.values.first, block_order: i + 1, short_title: c.keys.first.to_s
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

puts "create Category relation 1,2"
Category.where(level: Settings.category.highest_level).each do |category_level_1|
  rand_level_2 = rand(15) + 1
  rand_level_2.times do |r|
    category_level_2 = Category.create! name: Faker::Company.buzzword, level: Settings.category.middle_level
    CategoryRelation.create! parent_id: category_level_1.id, children_id: category_level_2.id
    rand_level_3 = rand(5) + 1
    rand_level_3.times do |r|
      category_level_3 = Category.create! name: Faker::Company.buzzword, level: Settings.category.lowest_level
      CategoryRelation.create! parent_id: category_level_2.id, children_id: category_level_3.id
    end
  end
end
puts "Category relation 1,2 OK"

puts "create Field"
10.times do |i|
  Field.create! name: Faker::Lorem.sentence
end
puts "Field OK"

puts "create product_categoies"
Category.where(level: Settings.category.lowest_level).each do |category|
  rand_p = rand(10)
  rand_p.times do |r|
    ProductCategory.create product_id: rand(Product.count), category_id: category.id
  end
end
puts "product_categoies OK"

puts "create product_fields"
Field.all.each do |field|
  rand_p = rand(30)
  rand_p.times do |r|
    ProductField.create product_id: rand(Product.count), field_id: field.id
  end
end
puts "product_fields OK"

puts "Create media..."
Medium.create!title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, url: "/uploads/media/admin_export_candidate.xlsx", media_type: 0, field_id: 2
Medium.create!title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, url: "/uploads/media/report_3.doc", media_type: 0, field_id: 2
Medium.create!title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, url: "/uploads/media/resume_search.doc", media_type: 0, field_id: 1
Medium.create!title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, url: "/uploads/media/Rails_4_in_Action_v11_MEAP.pdf", media_type: 0, field_id: 2
Medium.create!title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, url: "/uploads/media/Pro React.pdf", media_type: 0, field_id: 3
Medium.create!title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, url: "/uploads/media/admin_export_candidate.xlsx", media_type: 0, field_id: 1
Medium.create!title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, url: "/uploads/media/report_3.doc", media_type: 0, field_id: 4
Medium.create!title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, url: "/uploads/media/resume_search.doc", media_type: 0, field_id: 1
Medium.create!title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, url: "/uploads/media/Rails_4_in_Action_v11_MEAP.pdf", media_type: 0, field_id: 1
Medium.create!title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, url: "/uploads/media/Pro React.pdf", media_type: 0, field_id: 4

10.times do |i|
  field = i < 5 ? 1 : 2
  Medium.create!title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, url: "https://www.youtube.com/embed/ptLFrU_zrEQ", media_type: 1, field_id: field
end

puts "Create media: doc & pdf OK"
