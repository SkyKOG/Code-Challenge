class AdminSectionController < ApplicationController
  before_filter :authenticate_admin!

  def browse
    @problems = Problem.all
  end

  def new
  end

  def create
  	@problem = Problem.new
  	@problem.title = params[:title]
  	@problem.question = params[:question]
  	@problem.save
    file2 = File.new('input'+@problem.id.to_s,'w')
    file2.write(params[:testing_input])
    file2.close
    file2 = File.new('output'+@problem.id.to_s,'w')
    file2.write(params[:testing_output])
    file2.close
  	redirect_to admin_section_browse_path
  end

  def edit
  end

  def destroy
    @problem = Problem.find(params[:id])
    @problem.destroy
    redirect_to admin_section_browse_path
    `rm input#{params[:id]} output#{params[:id]}`
  end

  def update
  end
end