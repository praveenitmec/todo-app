module Api
  module V1
    class TodosController < Api::ApiController
      before_filter :set_todo, only: [:show, :update, :destroy]

      def index
        @todos = Todo.all
        render json: @todos, each_serializer: TodosSerializer
      end

      def create
        @todo = Todo.new(todo_params)
        if @todo.save
          render json:@todo
        else
          render json: {errors: @todo.errors}, status: :unprocessable_entity
        end
      end

      def show
        render json:@todo
      end

      def update
        if @todo.update(todo_params)
          render json: @todo
        else
          render json: @todo.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @todo.destroy
      end

      private
      def set_todo
        @todo = Todo.find(params[:id])
      end

      def todo_params
        params.require(:todo).permit(:name, :target_date).merge!(user: @current_user)
      end
    end
  end
end
