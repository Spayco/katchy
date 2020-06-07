class GroupsController < ApplicationController
    before_action :logged?
    before_action :set_user
    def index
        @groups = Group.all
    end

    def show
        @group = Group.find(params[:id])
    end

    def new
        @group = Group.new
    end

    def create
        @group = Group.new(group_params)
        respond_to do |format|
            if @group.save
                format.html { redirect_to @group, notice: 'Group was successfully created.' }
                format.json { render :show, status: :created, location: @group }
              else
                format.html { render :new }
                format.json { render json: @group.errors, status: :unprocessable_entity }
            end
        end
    end
    private
    def logged?
        if cookies[:id] == "" || cookies[:id] == nil
            flash[:danger] = "Please log in."
            redirect_to signin_path 
        end
    end
    def set_user
        @current_user = User.find(cookies[:id])
    end
    def group_params
        params.require(:group).permit(:name, :icon)
    end
end
