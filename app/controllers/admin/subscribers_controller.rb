class Admin::SubscribersController < Admin::BaseController
  before_action :load_subscribers, only: [:index]

  def index

  end

  private
  def load_subscribers
    @subscribers = Subcriber.all
  end
end
