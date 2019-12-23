class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  def index
    if logged_in?
      @blogs = Blog.all
    else
      redirect_to new_session_path , notice: 'loginしてください。'
    end

  end

  def show
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  def new
    if logged_in?
      if params[:back]
        @blog = Blog.new(blog_params)
      else
        @blog = Blog.new
      end
    else
      redirect_to new_session_path , notice: 'loginしてください。'
   end
 end

  def edit
  end

  def create
    @user = current_user
    UserMailer.user_mail(@user).deliver
    @blog = current_user.blogs.build(blog_params)
    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def confirm
    @blog = current_user.blogs.build(blog_params)
    render :new if @blog.invalid?
  end

  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'Blog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_blog
    @blog = Blog.find(params[:id])
  end


  def blog_params
    params.require(:blog).permit(:title, :content, :image, :image_cache)
  end

  def correct_user
    blog = Blog.find(params[:id])
      if current_user.id != blog.user.id
        redirect_to new_session_path , notice: 'loginしてください。'
      end
  end
end
