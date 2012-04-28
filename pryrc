# vim FTW
Pry.config.editor = "gvim --nofork"

# My pry is polite
Pry.config.hooks.add_hook(:after_session, :bye) do
  puts "bye bye!"
end

# Prompt with ruby version
Pry.config.prompt = [proc { |obj, nest_level| "#{RUBY_VERSION} (#{obj}):#{nest_level} > " }, proc { |obj, nest_level| "#{RUBY_VERSION} (#{obj}):#{nest_level} * " }]

# loading rails configuration if it is running as a rails console
load File.dirname(__FILE__) + '/.railsrc' if defined?(Rails) && Rails.env

if defined? PryNav
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
end
