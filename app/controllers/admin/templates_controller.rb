class Admin::TemplatesController < Admin::BaseController
  def index
    @templates = Template.all.order :name
  end

  def show
    template = Template.find params[:id]
    if template
      render json: {content: template.content, status: "success"}
    else
      render json: {content: "No template match !", status: "error"}
    end
  end

  def create
    template = Template.new template_params
    if template.save
      render json: {status: "success"}
    else
      render json: {status: "error"}
    end
  end

  def update
    template = Template.find params[:id]
    if template.update template_params
      render json: {status: "success"}
    else
      render json: {status: "error"}
    end
  end

  def destroy
    template = Template.find params[:id]
    if template.destroy
      render json: {status: "success"}
    else
      render json: {status: "error"}
    end
  end

  private
  def template_params
    params.require(:template).permit :name, :content
  end
end
