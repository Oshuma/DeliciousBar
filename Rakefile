desc 'debug:build'
task :default => 'debug:build'

desc 'debug:clean'
task :clean => 'debug:clean'

def default_tasks_for(name)
  desc "Build the #{name} configuration"
  task :build do
    build(name)
  end

  desc "Clean the #{name} configuration"
  task :clean do
    build(name, 'clean')
  end
end

def build(configuration, command = '')
  puts %x{
    xcodebuild -configuration #{configuration} #{command}
  }
end

namespace :debug do
  default_tasks_for('Debug')
end

namespace :release do
  default_tasks_for('Release')
end
