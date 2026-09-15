# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in send_grid.gemspec
gemspec

# Verify both supported Rails series during the upgrade.
def next?
  File.basename(__FILE__) == "Gemfile.next"
end

gem "next_rails"
gem "activerecord", next? ? "= 8.1.3.1" : "= 8.0.5.1"
