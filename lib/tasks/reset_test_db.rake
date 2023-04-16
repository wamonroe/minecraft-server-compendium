namespace :db do
  namespace :test do
    desc "Reset the Test Environment by dropping the database and running all migrations / seeds."
    task reset: :environment do
      raise "Can only be run in the test environment" unless ENV["RAILS_ENV"] == "test"

      %w[db:drop db:create db:schema:load db:seed].each do |task|
        Rake::Task[task].invoke
      end
    end
  end
end
