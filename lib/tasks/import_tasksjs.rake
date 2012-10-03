TASK_ROOT = "#{Rails.root}/app/tasks"

namespace :tasksjs do
  desc "Collect tasks in app/tasks and add them to db"
  task :add_all_to_db => :environment do
    get_all_tasks_from_folder
  end

  desc "Delete tasks db and add all tasks from app/tasks"
  task :init => :environment do
    Task.delete_all
    get_all_tasks_from_folder
  end

  desc "Repeatedly insert tasks :arg times\
      (pass verified = true if you're doing a random operation')"
  task :repeated, [:times, :verified] => :environment do |t, args|
    Task.delete_all
    args.with_defaults(:times => 100, :verified => false)
    args[:verified] = true if args[:verified]
    puts "Running #{args[:times]} times"
    repeat = Integer(args[:times])
    repeat.times do
      get_all_tasks_from_folder(args[:verified])
    end
  end

  desc "Mark unfinished tasks as new"
  task :cleanup => :environment do
    Task.clean_up_tasks
  end
end

def get_all_tasks_from_folder(verified=false)
  js_tasks = Dir.glob("#{TASK_ROOT}/task*.js*")
  for js_task in js_tasks
    add_task_and_get_parameters(js_task, verified)
  end
end

def add_task_and_get_parameters(js_task, verified=false)
  parameters = get_parameters_for_js_task(js_task)
  begin
    Task.create!( name: js_task,
                  filename: js_task,
                  parameters: parameters.pop,
                  verified: verified)
  end while !parameters.empty?
end

def get_parameters_for_js_task(js_task)
  base_name = File.basename(js_task, ".*")
  parameters_files = Dir.glob("#{TASK_ROOT}/parameters_#{base_name}.*")
  parameters = []
  for filename in parameters_files
    file = File.open(filename, 'r')
    file.each do |line|
      parameters << line.squish
    end
  end
  return parameters
end
