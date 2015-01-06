if Kernel.const_defined?('YARD')
  YARD::Rake::YardocTask.new
  namespace :doc do
    task :app => :yard
    task :api => :yard
  end

  task :doc => :yard
end
