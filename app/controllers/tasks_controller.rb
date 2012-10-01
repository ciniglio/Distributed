class TasksController < ApplicationController
  TaskRoot = "#{Rails.root}/app/tasks"
  def next
    tasks = Dir.glob("#{TaskRoot}/task*.js")
    size = tasks.length
    task = tasks[rand(size)]
    puts task
    render task
  end
end
