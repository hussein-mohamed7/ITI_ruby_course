namespace :articles do
  desc "Delete articles with 6+ reports"
  task cleanup: :environment do
    Article.where("reports_count >= ?", 6).destroy_all
  end
end