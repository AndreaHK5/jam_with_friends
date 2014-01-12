class GenresController < ApplicationController
  def index
    @genres = Genre.all
  end

  def show
    @genre = Genre.find params[:id]
  end

  def new
    @genre = Genre.new
  end
  
  def create
    @genre = Genre.create safe_genre
    if @genre.save
      flash[:notice] = "new Genre added!!!"
      redirect_to edit_profile_path(current_user)
    else
      flash[:notice] = "something went wrong with adding #{safe_genre[:name]}"
      @genre.save
      @genre.errors[:name].each do |d| 
        flash[:notice] = flash[:notice] + ", \n #{d}"
      end
      render 'new'
    end
  end

  def edit
    @genre = Genre.find params[:id] 
  end
  
  def update 
    @genre = Genre.find params[:id]    
    @genre.update safe_genre
    if @genre.save
      flash[:notice] = "Genre edited!!!"
      redirect_to edit_profile_path(current_user)
    else
      flash[:notice] = "something went wrong"
      render 'edit'
    end
  end

  def destroy
    @genre = Genre.find params[:id]
    @genre.destroy
    flash[:notice] = "#{@genre.name} has been deleted"
    
    redirect_to genres_path 
  end

  private

  def safe_genre
    safe_genre = params.require(:genre).permit(:name)
  end
end
