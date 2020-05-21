class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.page = Page.find(params[:comment][:page_id])
    if @comment.save
      # flash[:success] = "コメントを投稿しました"
      render json: {message: 'success'}, status: 200
    else
      # flash[:error] = "コメントの投稿に失敗しました"
      render json: {message: 'error'}, status: 422
    end
  end
  
  

  private
  def comment_params
    params.require(:comment).permit(:text)
  end
  
end
