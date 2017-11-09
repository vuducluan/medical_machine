class Admin::FieldsController < Admin::BaseController
  before_action :load_fields, only: [:index]

  def index
  end

  def update
    if params[:name] || params[:menu_order]
      @field = Field.find_by id: params[:id]
      if @field
        @field.update_attributes(name: params[:name],
          menu_order: params[:menu_order])
      end
    end

    if request.xhr?
      render json: {
        name: @field.name,
        menu_order: @field.menu_order
      }
    end
  end

  private
  def load_fields
    @fields = Field.all
  end
end
