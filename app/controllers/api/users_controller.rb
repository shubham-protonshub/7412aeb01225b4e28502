class Api::UsersController < ApplicationController
    before_action :load_user, only: [:show, :update, :destroy]

    def index
        users = User.all.page(params[:page]).per(3)
        render json: users
    end

    def create
        user = User.new(user_params)
        if user.save
            render json: user
        else
            render json: {errors: user.errors}, status: 422
        end
    end

    def show 
        render json: @user
    end

    def update
        if @user.update(user_params)
            render json: @user
        else
            render json: {errors: @user.errors},status: 422
        end
    end

    def destroy
        if @user.destroy 
            render json: {message: 'sucessfully destoyed'}
        else
            render json: {errors: @user.errors}, status: 422
        end
    end

    def typeahead
        search = "%#{params[:input]}%"
        users = User.where("firstName LIKE :search OR lastName LIKE :search OR email LIKE :search", {search: search})
        if users.present?
            render json: users.map {|u| "#{u.firstName} #{u.lastName}"}.to_sentence
        else
            render json: {message: "no user found"}, status: 404
        end
    end

    private

    def user_params
        params.require(:user).permit(:firstName, :lastName, :email)
    end

    def load_user
        @user = User.find(params[:id])
        unless @user.present?
            render json: {message: "user not found"}, status: 404
        end
    end
end
