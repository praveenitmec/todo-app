module Api
  module V1
    class TestController < ApiController
      def test_method
        if @current_user
          render json:{"logged_in":true}, status: :OK
        else
          render json:{"logged_in":flase}, status: 401
        end
      end
    end
  end
end
