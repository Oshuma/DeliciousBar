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


# in order of severity
NOTE_TAGS = %w{ FIXME TODO FEATURE IDEA }

desc 'Show development notes'
task :notes do
  dirs = [ File.dirname(__FILE__) ]
  NOTE_TAGS.each do |tag|
    system("find #{dirs.join(' ')} -type f -iname '*.[hm]' -exec grep -Hn #{tag} {} \\;")
  end
end
