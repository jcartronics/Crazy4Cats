class ReactionsController < ApplicationController
  def new_user_reaction
    @user = current_user
    @type = params[:reaction_type]
    @article = Article.find(params[:article_id]) if params[:article_id]
    @comment = Comment.find(params[:comment_id]) if params[:comment_id]
    @kind = params[:kind]

    reaction = if @type == "comment"
                 @user.reactions.find_by(comment_id: @comment.id)
               else
                 @user.reactions.find_by(article_id: @article.id)
               end

    respond_to do |format|
      if reaction
        # Actualizar la reacción existente si se cambia
        reaction.update(kind: @kind) if reaction.kind != @kind
        format.html { redirect_to request.referrer, notice: 'Reacción actualizada exitosamente.' }
      else
        reaction_params = {
          user_id: @user.id,
          reaction_type: @type,
          kind: @kind
        }
        reaction_params[@type == "comment" ? :comment_id : :article_id] = @type == "comment" ? @comment.id : @article.id

        @reaction = Reaction.new(reaction_params)

        if @reaction.save
          format.html { redirect_to request.referrer, notice: 'La reacción fue creada exitosamente!.' }
        else
          format.html { redirect_to request.referrer, notice: 'Un error ha ocurrido!' }
        end
      end
    end
  end
end