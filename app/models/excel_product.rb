class ExcelProduct
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :file, :errors

  validates :file, presence: {
    message: "Chưa chọn file"
  }

  def initialize *args
    super
    @errors = ActiveModel::Errors.new self
  end
end
