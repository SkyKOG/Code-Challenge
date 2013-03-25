class ProblemController < ApplicationController
  before_filter :authenticate_user!

  def browse
  	@problems = Problem.all
    if Solved.find_by_user_id(current_user.id)
      @solved_problems = Solved.where(user_id = current_user.id)
    else
      @solved_problems = []
    end
  end

  def show
  	@problem = Problem.find_by_id(params[:id])
  end

  def answer
  	file = params[:upload].tempfile
    extension = File.extname(params[:upload].original_filename)
    @id = params[:id]
  	@content = File.read(file)
    filename = current_user.username+extension
  	file2 = File.new(filename,'w')
  	file2.write(@content)
  	file2.close
  	if extension == ".c"
      `gcc #{filename}`
      @output = `./a.out < 'input'#{@id}`
    elsif extension == ".cpp"
      `g++ #{filename}`
       @output = `./a.out < 'input'#{@id}`
    elsif extension == ".py"
      @output = `python #{filename} < 'input'#{@id}`.chop
    elsif extension == ".rb"
      @output = `ruby #{filename} < 'input'#{@id}`.chop                                              
    end
  	if @output == File.read('output' + @id)
  		@result = 'Success'
      if !Solved.find_by_user_id_and_problem_id(current_user.id, params[:id])
        @solved = Solved.new
        @solved.problem_id = params[:id]
        @solved.user_id = current_user.id
        @solved.save
      end
  	else
  		@result = "Failure"
  	end
    `rm a.out`
    `rm #{filename}`
  end

  def result
  end
end