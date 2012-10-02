class Task < ActiveRecord::Base
  attr_accessible :name, :filename
  attr_accessor :distributed, :filename, :finished, :name, :result

  before_save :default_values

  def self.next_ready_task
    clean_up_tasks
    task = Task.where(:distributed => false).limit(1)
  end

  def self.distribute_task
    task = self.next_ready_task
    task.distributed = true
    task.save
    return task
  end

  def result(result)
    self.result = result.to_json
    self.finished = true if result
    self.save
  end

  private

  def default_values
    self.distributed = false
    self.finished = false
    self.result = nil
  end

  def self.clean_up_tasks
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
