TASK_ROOT = "#{Rails.root}/app/tasks"

namespace :mc do
  desc "Collect tasks in app/tasks and add them to db"
  task :add_all_to_db => :environment do
    js_tasks = Dir.glob("#{TASK_ROOT}/task_pi_sum*.js*")
    for js_task in js_tasks
      parameters = get_parameters_for_js_task(js_task)
      begin
        Task.create!( name: js_task,
                      filename: js_task,
                      parameters: parameters.shift)
      end while !parameters.empty?
    end
  end

  desc "Delete tasks db and add all tasks from app/tasks"
  task :init => :environment do
    Task.delete_all
    Rake::Task["mc:add_all_to_db"].invoke
  end

  desc "Repeatedly insert tasks :arg times"
  task :repeated, [:times] => :environment do |t, args|
    Rake::Task["tasksjs:init"].invoke
    args.with_defaults(:times => 100)
    puts "Running #{args[:times]} times"
    repeat = Integer(args[:times])
    repeat.times do
      Rake::Task["tasksjs:add_all_to_db"].execute
    end
  end

  desc "Mark unfinished tasks as new"
  task :cleanup => :environment do
    Task.clean_up_tasks
  end

  desc "approximate PI"
  task :pi => :environment do
    tasks = Task.where(finished:true)
    inside = 0.0
    total = 0.0
    f = File.new('picalc.txt', 'w')
    for task in tasks
      total += 1
      inside += 1 if Float(task.result) <= 1
      f.puts "#{(inside/total)*4}"
    end
    puts "PI : #{(inside/total)*4}"
  end

  desc "approximate PI sumwise"
  task :pisum => :environment do
    tasks = Task.where(finished:true)
    pi = 0.0
    f = File.new('picalc.txt', 'w')
    for task in tasks
      pi += Float(task.result)
      f.puts "#{pi}"
    end
    puts "PI : #{pi}"
  end
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
