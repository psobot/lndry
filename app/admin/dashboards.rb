ActiveAdmin.register_page "Dashboard" do

  sidebar "Recent Laundries" do
    table_for Use.order('id desc').limit(10) do
      column :user
      column(:start, :sortable => :start) { |use| "#{time_ago_in_words use.start} ago" }
    end
  end

  content :title => "New Launderers" do
    table_for Use.order('id desc').group('user_id').limit(10).each do
      column("Name") { |use| link_to use.user.name, admin_user_path(use.user)  }
      column("Email") { |use| mail_to use.user.email }
      column("Signed Up") { |use| "#{time_ago_in_words use.user.created_at} ago" }
      column("# Uses") { |use| use.user.uses.count }
    end
  end
end
