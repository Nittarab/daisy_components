# frozen_string_literal: true

namespace :lint do
  desc 'Check for missing trailing newlines in source files'
  task :trailing_newlines do
    system('./bin/fix_trailing_newlines.sh --check-only')
    exit $?.exitstatus
  end

  desc 'Fix missing trailing newlines in source files'
  task :fix_trailing_newlines do
    system('./bin/fix_trailing_newlines.sh')
  end
end

desc 'Run all linting checks'
task lint: ['lint:trailing_newlines']
