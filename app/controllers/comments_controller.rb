class CommentsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]

    def create
        @article = Article.find(params[:article_id])
        @comment = @article.comments.build(comment_params)
        @comment.user = current_user
    
        if @comment.save
            redirect_to @article, notice: 'Comentario agregado correctamente.'
          else
            render 'articles/show'
          end
    end

    def destroy
        @comment = Comment.find(params[:id])

        if current_user == @comment.user || current_user == @comment.article.user || current_user.admin?
            @comment.destroy
            redirect_to @comment.article, notice: 'Comentario eliminado correctamente.'
          else
            redirect_to @comment.article, alert: 'No tienes permiso para eliminar este comentario.'
          end
    end

    private
    def comment_params
        params.require(:comment).permit(:content)
    end
end