if ENV["RAILS_ENV"] == "development"
  worker_processes 1
else
  worker_processes 4
end

timeout 30