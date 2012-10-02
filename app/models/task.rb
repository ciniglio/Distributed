class Task < ActiveRecord::Base
  attr_accessible :name
  attr_accessor :distributed, :filename, :finished, :name, :result

  def self.next_ready_task
    clean_up_tasks
    task = Task.where(:distributed => false).limit(1)
  end

  def result(result)
    self.result = result.to_json
    self.save
  end

  private
  def clean_up_tasks
    unfinished_tasks = Task.where(:distributed => true,
                                  :finished => false,
                                  :modified_at =>
                                        (Time.now - 15.minutes)..Time.now)

    for task in unfinished_tasks
      task.finished = false
      task.distributed = false
      task.save
    end
  end
end
