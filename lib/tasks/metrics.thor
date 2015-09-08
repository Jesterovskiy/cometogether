require 'yaml'
require 'bundler/setup'
require 'pry'

class Metrics < Thor
  desc 'all', 'Run all metrics'
  def all
    lint
    smells
    coverage(nil, true)
  end

  desc 'coverage [TYPE]', 'Generate code coverage'
  def coverage(type=nil, cli=false)
    ENV['COVERAGE'] = 'true'
    system "rspec spec/#{type}"

    if !cli && system('which open')
      `open coverage/index.html`
    end
  end

  desc 'lint', 'Check with code style guide'
  def lint
    begin
      require 'rubocop'
    rescue LoadError, NotImplementedError => e
      puts e
      return false
    end

    config_file = path_to_config('rubocop')

    RuboCop::CLI.new.run(%W[--config #{config_file}])
  end

  desc 'smells', 'Detect code smells with Reek'
  def smells
    begin
      require 'reek/cli/application'
    rescue LoadError => e
      puts e
      return false
    end

    opts = ['--config', path_to_config('reek'), 'app']

    Reek::CLI::Application.new(opts).execute
  end

private

  def config_for(tool)
    file = path_to_config(tool)
    YAML.load_file(file)
  end

  def path_to_config(tool)
    File.expand_path("../../config/metrics/#{tool}.yml", File.dirname(__FILE__))
  end
end
