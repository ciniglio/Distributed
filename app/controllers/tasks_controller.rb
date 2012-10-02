class TasksController < ApplicationController
  def next
    task = Task.distribute_task
    puts task
    @message = 'alejandro'
    render :file => task.filename
  end

  def result
    puts params
    render :nothing => true
  end
end
