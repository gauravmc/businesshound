def spin_socket
  require 'digest/md5'
  require 'tempfile'
  key = Digest::MD5.hexdigest [Dir.pwd, 'spin-gem'].join
  [Dir.tmpdir, key].join('/')
end

def process_running?(process)
  `ps | grep -v grep | grep -cE '#{process} *$'`.chomp.to_i >= 1
end

def spork_running?
  process_running? 'spork'
end

def zeus_running?
  process_running? 'zeus-.* start'
end

def spin_running?
  process_running?('spin.*serve') && File.exist?(spin_socket)
end

def command_prefix
  if zeus_running?
    "zeus testrb "
  elsif spork_running?
    "bundle exec testdrb -Itest -I. "
  elsif spin_running?
    "spin push "
  else
    "bundle exec testrb -Itest -I. "
  end
end

def execute_command(files, command)
  if files.any?
    puts "running: #{command}\n"
    Kernel.exec(command)
  else
    puts "No matching tests found."
  end
end
