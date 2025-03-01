class PhotosController < ApplicationController

  def index 
    matching_photos = Photo.all
    @list_of_photos = matching_photos.order({ :username => :asc })
    render ({ :template => "photos/index" })
  end

  def show
    url_id = params.fetch("path_id")
    matching_photos = Photo.where({ :id => url_id})
    @the_photo = matching_photos.at(0)
    render ({ :template => "photos/show" })
  end 

  def del
    the_id = params.fetch("toast_id")
    matching_photos = Photo.where({ :id => the_id })
    the_photo = matching_photos.at(0)
    the_photo.destroy

    #render ({ :template => "photo_templates/del" })
    redirect_to("/photos") 
  end

  def create
  input_image = params.fetch("query_image")
  input_caption = params.fetch("query_caption")
  input_owner_id = params.fetch("query_owner_id")

  a_new_photo = Photo.new
  
  a_new_photo.image = input_image
  a_new_photo.caption = input_caption
  a_new_photo.owner_id = input_owner_id

  a_new_photo.save

  #render({ :template => "photos/create" })
  redirect_to("/photos/" + a_new_photo.id.to_s)
  end

  def update
    # Parameters: {"query_image"=>"https://robohash.org/eligendiprovidentsed.png?size=300x300&set=set1", "query_caption"=>" Every flight begins with a fall. cchvhvj", "modify_id"=>"628"}
    the_id = params.fetch("modify_id")
    matching_photos = Photo.where({ :id => the_id})
    the_photo = matching_photos.at(0)

    input_image = params.fetch("query_image")
    input_caption = params.fetch("query_caption")

    the_photo.image = input_image
    the_photo.caption = input_caption

    the_photo.save
    #render ({ :template => "photos/update"})
    redirect_to("/photos/" + the_photo.id.to_s)
  end


  def comment
    # params: ?input_photo_id=629&input_author_id=111&input_comment=woowwww

    #first fetch all the values in the form 
    photo_id = params.fetch("input_photo_id")
    author_id = params.fetch("input_author_id")
    the_comment = params.fetch("input_comment")

    #then create a new Comment instance
    new_comment = Comment.new
    new_comment.photo_id = photo_id
    new_comment.author_id = author_id
    new_comment.body = the_comment

    #Finally save
    new_comment.save
    
    redirect_to("/photos/" + photo_id.to_s)
   
  end
end
