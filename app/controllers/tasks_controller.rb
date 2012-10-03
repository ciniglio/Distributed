class TasksController < ApplicationController
  def next
    @task = Task.distribute_task
    render file: "#{Rails.root}/app/tasks/distributed_task",
           handlers: [:erb, :js],
           formats: [:js]
  end

  def result
    puts params
    task = Task.find_by_id(params[:distributed_task_id])
    task.result = params[:result]
    render :nothing => true
  end
end
