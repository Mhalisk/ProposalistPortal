# config/initializers/delayed_job.rb
Delayed::Worker.destroy_failed_jobs = false
# defines the check interval to see if there are new jobs in seconds
Delayed::Worker.sleep_delay = 30
Delayed::Worker.max_attempts = 1
Delayed::Worker.max_run_time = 5.minutes
Delayed::Worker.read_ahead = 10
Delayed::Worker.default_queue_name = 'default'
Delayed::Worker.delay_jobs = !Rails.env.test?
Delayed::Worker.raise_signal_exceptions = :term
Delayed::Worker.logger = Logger.new(File.join(Rails.root, 'log', 'delayed_job.log'))