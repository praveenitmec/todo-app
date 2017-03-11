module Api
  module V1
    class TestController < Api::ApiController
      def test_method
        if @current_user
          render json:{"logged_in":true}
        else
          render json:{"logged_in":flase}, status: 401
        end
      end
    end
  end
end
