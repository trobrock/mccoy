require 'awesome_print'
def listen(stdout, stderr)
    Thread.new {
      while !stderr.eof?
        ap stderr.gets
      end
    }
    Thread.new {
      while !stdout.eof?
        ap stdout.gets
      end
    }
end

def cap_line(line)
  match = line.match(/([a-z0-9\-\.]+)(?=\]).+ (.+)\n$/i)
  return nil unless match
  match.captures
end

def cap_readlines(lines)
  lines.map { |line| cap_line line }.compact
end

def cap(cmd, criteria=nil, options={})
  group = options[:group]
  env   = options[:env]

  stdin, stdout, stderr = Open3.popen3("cap #{env} shell")
  # listen(stdout, stderr)

  if !group.nil?
    stdin.puts "with #{group} #{cmd}"
  else
    stdin.puts cmd
  end
  stdin.puts "exit"

  lines = cap_readlines(stderr.readlines)
  lines = lines.select { |line| line.last == criteria.to_s } unless criteria.nil?
  lines.map(&:first)
end

puts "=================================================="
ap cap "ps -ef | grep nginx | grep -v grep | wc -l", 0, { :env => :qa }
