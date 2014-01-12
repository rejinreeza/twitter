class HomeController < ApplicationController
  def index
	@users = User.all #all
  end
end
