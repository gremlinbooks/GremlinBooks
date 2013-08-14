namespace :db do

  task :clear_all_logs => :environment do
    Rake::Task['db:clear_user_buy_log'].invoke
    Rake::Task['db:clear_search_log'].invoke
    Rake::Task['db:clear_user_search_log'].invoke
  end

  task :clear_user_buy_log => :environment do
    UserBuyLog.delete_all
  end

  task :clear_search_log => :environment do
    SearchLog.delete_all
  end

  task :clear_user_search_log => :environment do
    UserSearchLog.delete_all
  end

end