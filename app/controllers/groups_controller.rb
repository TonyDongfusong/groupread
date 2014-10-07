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
    @group = Group.includes(users: [:douban_auth_info, :books]).find(params[:id])
    @current_user_in_group = @group.users.any? do |user|
      user.id == current_user.id
    end

    books = @group.users.inject([]) do |books, user|
      books + user.books
    end.uniq


    @book_infos = books.map do |book|
        {
          i_read: book.users.include?(current_user),
          book_url: book.url,
          title: book.title,
          read_num: book.users.size,
          read_people: book.users.map do |user|
            {
                douban_link: "http://book.douban.com/people/#{user.douban_auth_info.douban_user_id}/",
                name: user.douban_auth_info.douban_user_name
            }
          end
      }
    end
    .sort_by{|item| item[:read_num]}
    .reverse
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
