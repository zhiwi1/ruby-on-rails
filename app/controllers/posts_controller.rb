class PostsController < ApplicationController
  before_action :authenticate_person!,except: [:index,:show]
  def index
    @post = Post.all
  end

  def new
    @post = Post.new()
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    #render plain: params[:post].inspect
    @post = Post.find(params[:id])

    # @post.save()
    if (@post.update(post_params))
      Rails.logger.info "================= I'm here ================"
      redirect_to(@post)
    else
      render "edit"
    end
  end
  def destroy
    @post=Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def create

    #render plain: params[:post].inspect
    @post = Post.new(post_params)
    # @post.save()
    if (@post.save())
      Rails.logger.info "================= I'm here ================"
      redirect_to(@post)
    else
      render "new"
    end
  end

  private def post_params
    params.require(:post).permit(:title, :body,:all_tags)
  end
end
