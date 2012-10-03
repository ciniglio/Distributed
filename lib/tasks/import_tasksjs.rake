namespace :tasksjs do
  desc "Collect tasks in app/tasks and add them to db"
  task :add_all_to_db => :environment do
    task_root = "#{Rails.root}/app/tasks"
    js_tasks = Dir.glob("#{task_root}/task*.js*")
    for js_task in js_tasks
      Task.create!( name: js_task,
                    filename: js_task)
    end
  end

  desc "Delete tasks db and add all tasks from app/tasks"
  task :init => :environment do
    Task.delete_all
    Rake::Task["tasksjs:add_all_to_db"].invoke
  end

  desc "Repeatedly insert tasks :arg times"
  task :repeated, [:times] => :environment do |t, args|
    Rake::Task["tasksjs:init"].invoke
    args.with_defaults(:times => 100)
    puts "Running #{args[:times]}"
    repeat = Integer(args[:times])
    repeat.times do
      Rake::Task["tasksjs:add_all_to_db"].execute
    end
  end

  desc "Mark unfinished tasks as new"
  task :cleanup => :environment do
    Task.clean_up_tasks
  end
end
