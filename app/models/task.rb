class Task < ActiveRecord::Base
  attr_accessible :distributed, :filename, :parameters
  attr_accessible :finished, :name, :result, :verified

  before_create :default_values

  def self.distribute_task
    # 10% of the time, verify an already completed task
    if Random.rand(10) == 0
      task = self.next_verification_task
    # the other 90% of the time, take a task from the queue
    else
      task = self.next_ready_task
      if !task
        task = self.next_verification_task
      else
        task.distributed = true
        task.save
      end
    end
    return task
  end

  def parameters=(parameters)
    write_attribute(:parameters, "[#{parameters}]")
  end

  def result=(result)
    if result and self.result
      verify_result(result)
    elsif result
      add_new_result(result)
    end
  end

  def add_new_result(result)
    # Can't call result= because it will call this function'
    write_attribute(:result, result)
    self.finished = true
    save
  end

  def verify_result(result)
    if result == self.result
      self.verified = true
      save
    else
      self.finished = false
      self.distributed = false
      self.verified = false
      # Can't call result= because it will call this function'
      write_attribute(:result, nil)
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
