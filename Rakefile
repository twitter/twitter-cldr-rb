require 'rubygems' unless ENV['NO_RUBYGEMS']
require 'rubygems/package_task'
require 'rake/rdoctask' unless RUBY_VERSION >= '1.9.0'
require 'rdoc/task' unless RUBY_VERSION <= '1.9.0'
require 'rubygems/specification'
require 'spec/rake/spectask'
require 'spec/rake/verify_rcov'
require 'digest'

spec = Gem::Specification.load("#{File.dirname(__FILE__)}/twitter_cldr.gemspec")

task :default => :spec

desc "Run specs"
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = %w(-fs --color)
  t.libs << ["spec", '.']
end

desc "Run all examples with RCov"
Spec::Rake::SpecTask.new('spec:rcov') do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.rcov = true
  t.rcov_opts = ['-T', '--sort', 'coverage', '--exclude', 'gems/*,spec/*']
end

# Gem tasks
Gem::PackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "install the gem locally"
task :install => [:package] do
  sh %{gem install pkg/#{spec.name}-#{spec.version}}
end

