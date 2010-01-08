require 'rake'

files = [
  'vim',
  'vimrc',
  'gvimrc',
  'irbrc',
  "profile",
  "bash_completion.d",
  "gemrc"
]

desc "Install"
task :install do
  home = ENV['HOME']

  puts "Installing dot files"
  files.each do |file|
    target_file = File.join(home, "."+file)
    FileUtils.rm_rf(target_file) if File.directory?(target_file)
    FileUtils.cp_r(file, target_file)
    puts "  Copied #{file} to #{target_file}"
  end
end

task :default => [:install]
