module Admin::BlogsHelper
  def blog_page_title
    if action_name == "new"
      "Thêm bài viết"
    else
      "Chỉnh sửa bài viết"
    end
  end
end
