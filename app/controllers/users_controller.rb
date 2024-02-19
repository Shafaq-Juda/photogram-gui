class UsersController < ApplicationController

  def index 
    matching_users = User.all
    @list_of_users = matching_users.order({ :username => :asc })
    render ({ :template => "user_templates/index" })
  end

  def show
    url_username = params.fetch("path_username")
    matching_usernames = User.where ({ :username => url_username})
    @the_user = matching_usernames.at(0)
    #<% if the_user == nil %>
         # redirect_to("/")
    #<% else %>
    render ({ :template => "user_templates/show" })
    #<% end %>
  end

  def add_user
    new_username = params.fetch("username")
    new_user = User.new
    new_user.username = new_username

    new_user.save

    redirect_to("/users/<%= a_user.username%>")
  end
end
