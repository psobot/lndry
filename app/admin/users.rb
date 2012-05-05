ActiveAdmin.register User do
  actions :index, :show, :edit
  show :title => :name do |user|
    attributes_table do
      row :id
      row :email
      row :name
      row :key
      row :created_at
      row :updated_at
      Type.all.each do |type|
        row "#{type.name} Uses" do
          user.send("#{type.slug}_uses").count
        end
      end
      row :total_uses do
        user.uses.count
      end
    end
    panel "Use History" do
      table_for(user.uses) do
        column("Use", :sortable => :id)     {|use| link_to "##{use.id}", admin_use_path(use) }
        column :resource
        column("Date", :sortable => :start) {|use| pretty_format(use.start) }
      end
    end
    active_admin_comments
  end

  index do 
    id_column
    column :email
    column :name, :sortable => :name
    column :key
    column :created_at, :sortable => :created_at
    Type.all.each do |type|
      column "#{type.name} Uses" do |user|
        user.send("#{type.slug}_uses").count
      end
    end
    column :total_uses do |user|
      user.uses.count
    end
    default_actions
  end
end
