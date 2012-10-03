class Task < ActiveRecord::Base
  attr_accessible :distributed, :filename, :finished, :name, :result, :verified

  before_create :default_values

  def self.distribute_task
    if Random.rand(10) == 0
      task = self.next_verification_task
    else
      task = self.next_ready_task
      task.distributed = true
      task.save
    end
    return task
  end

  def result=(result)
    if result and self.result
      if result == self.result
        self.verified = true
        save
      else
        self.finished = false
        self.distributed = false
        self.verified = false
        write_attribute(:result, nil)
        save
      end
    elsif result
      write_attribute(:result, result)
      self.finished = true
      save
    end
  end

  private
  def self.next_ready_task
    clean_up_tasks
    task = Task.where(:distributed => false).first
  end

  def self.next_verification_task
    q = Task.where(:distributed => true,
                   :finished => true,
                   :verified => false)
    q.offset(rand(q.count)).first
  end

  def default_values
    self.distributed = false
    self.finished = false
    self.verified = false
    self.result = nil
  end

  def self.clean_up_tasks
    unfinished_tasks =
      Task.where("updated_at <= ?",
                 Time.now - 15.minutes).where(
                                              :distributed => true,
                                              :finished => false)

    for task in unfinished_tasks
      task.finished = false
      task.distributed = false
      task.save
    end
  end
end
