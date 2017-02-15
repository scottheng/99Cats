class CatsController < ApplicationController

  def index
    @cats = Cat.all.order(:name)
    render :index
  end

  def show
    @cat = Cat.find_by(id: params[:id])
    if @cat
      render :show
    else
      redirect_to cats_url
    end
  end

  def new
    @cat = Cat.new
    render :new
  end

  def edit
    @cat = Cat.find_by(id: params[:id])
    if @cat
      render :edit
    else
      redirect_to cats_url
    end
  end

  def update
    @cats = Cat.find_by(id: params[:id])
    if @cats.update(cat_params)
      redirect_to cats_url
    else
      redirect_to new_cat_url
    end

  end
  def create
    @cats = Cat.new(cat_params)
    if @cats.save
      redirect_to cats_url
    else
      redirect_to new_cat_url
    end
  end

  private

  def cat_params
    params.require(:cat).permit(:name, :color, :sex, :birth_date, :description)
  end
end
