class V1::UsersController < V1::BaseController
  power :users, map: {
    index: :users_index,
    create: :users_create,
  }, as: :users_scope

  # # GET v1/users
  # def index
  # end

  # # POST v1/users
  # def create
  # end

  private

    def user_params
      params.require(:user).permit(:username, :password)
    end
end
