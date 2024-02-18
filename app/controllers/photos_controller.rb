class PhotosController < ApplicationController

  def index
    render({:template => "photo_templates/index" })
  end

end
