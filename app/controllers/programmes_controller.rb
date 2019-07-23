class ProgrammesController < ApplicationController
  
  def index
    @programmes = Programme.all
  end
  
  def show
    @programme = Programme.find(params[:id])
  end
  
  def new
    @programme = Programme.new
  end
  
  def create
    @programme = Programme.new(programme_params)
 

    if @programme.save
      redirect_to @programme
    else
      render 'new'
    end
    
  end
  
  def edit
    @programme = Programme.find(params[:id])
  end
  
  def update
    @programme = Programme.find(params[:id])

    if @programme.update(programme_params)
      redirect_to @programme
    else
      render 'edit'
    end
  end
  

  def destroy
    @programme = Programme.find(params[:id])
    @programme.destroy

    redirect_to programmes_path
  end
  
  private
  def programme_params
    params.require(:programme).permit(:title, :description)
  end
  
end
