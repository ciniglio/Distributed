class TasksController < ApplicationController
  def next
    task = Task.distribute_task
    render :file => task.filename
  end

  def result
    puts params
    render :nothing => true
  end
end
