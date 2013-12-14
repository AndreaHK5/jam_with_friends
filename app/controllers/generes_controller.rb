class GeneresController < ApplicationController
  def index
    @generes = Genere.all
  end

  def show
    @genere = Genere.find params[:id]
  end

  def new
    @genere = Genere.new
  end
  
  def create
    @genere = Genere.create safe_genere
    if @genere.save
      flash[:notice] = "new Genere added!!!"
      redirect_to @genere
    else
      flash[:notice] = "something went wrong"
      render 'new'
    end
  end

  def edit
    @genere = Genere.find params[:id] 
  end
  
  def update 
    @genere = Genere.find params[:id]    
    @genere.update safe_genere
    if @genere.save
      flash[:notice] = "Genere edited!!!"
      redirect_to @genere
    else
      flash[:notice] = "something went wrong"
      render 'edit'
    end
  end

  def destroy
    @genere = Genere.find params[:id]
    @genere.destroy
    flash[:notice] = "#{@genere.name} has been deleted"
    
    redirect_to generes_path 
  end

  private

  def safe_genere
    safe_genere = params.require(:genere).permit(:name)
  end
end
