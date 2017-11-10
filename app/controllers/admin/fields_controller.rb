class Admin::FieldsController < Admin::BaseController
  before_action :load_fields, only: [:index]

  def index
  end

  def update
    if params[:name] || params[:menu_order] || params[:description]
      @field = Field.find_by id: params[:id]
      if @field
        @field.update_attributes(name: params[:name],
          menu_order: params[:menu_order], description: params[:description])
      end
    end

    if request.xhr?
      render json: {
        name: @field.name,
        menu_order: @field.menu_order,
        description: @field.description
      }
    end
  end

  def create
    field = Field.create name: params[:name], description: params[:description],
      menu_order: params[:menu_order]
    respond_to do |format|
      format.html
      format.json { render json: nil }
    end
  end

  def destroy
    field = Field.find_by id: params[:id]
    if field
      field.destroy
    end
    respond_to do |format|
      format.html
      format.json { render json: nil }
     end
  end

  private
  def load_fields
    @fields = Field.all.order(created_at: :desc)
  end
end
