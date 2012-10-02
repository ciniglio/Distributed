class Task < ActiveRecord::Base
  attr_accessible :distributed, :filename, :finished, :name, :result

  before_create :default_values

  def self.distribute_task
    task = self.next_ready_task
    task.distributed = true
    task.save
    return task
  end

  def result=(result)
    if result
      @result = result.to_json
      @finished = true
      self.save
    end
  end

  private
  def self.next_ready_task
    clean_up_tasks
    task = Task.where(:distributed => false).first
  end

  def default_values
    self.distributed = false
    self.finished = false
    self.result = nil
  end

  def self.clean_up_tasks
    unfinished_tasks = Task.where(:distributed => true,
                                  :finished => false,
                                  :updated_at =>
                                        (Time.now - 15.minutes)..Time.now)

    for task in unfinished_tasks
      task.finished = false
      task.distributed = false
      task.save
    end
  end
end
