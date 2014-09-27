require 'reading_status_analyzer'

class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy, :join, :leave]

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @current_user_in_group = @group.users.any? do |user|
      user.id == current_user.id
    end
    douban_related_user_infos = @group.users.map do |user|
      {
          douban_id: user.douban_auth_info.douban_user_id,
          douban_name: user.douban_auth_info.douban_user_name
      }
    end
    book_infos = ReadingStatusAnalyzer.new.statistic_by_user_ids(douban_related_user_infos)

    @book_infos = book_infos.map do |book_info|
      current_user_read_this_book = book_info[:read_people].any? do |read_person|
        read_person[:douban_id] == current_user.douban_auth_info.douban_user_id
      end

      book_info.merge(i_read: current_user_read_this_book)
    end
    .sort_by{|item| item[:read_num]}
    .reverse

    p @book_infos[0]
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
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

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def join
    @group.users << current_user
    @group.save
    redirect_to root_path
  end

  def leave
    @group.users.delete(current_user.id)
    redirect_to root_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params[:group].permit(:name, :description)
    end
end
