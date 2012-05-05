ActiveAdmin.register Use do
  actions :index, :show
  
  show do |use|
    attributes_table do
      row :id
      row :user
      row :resource
      row :start
      row :finish
      row(:raw_email) do |use|
        if use.raw_email.empty?
          span( class: "empty" ) {"Empty"}
        else
          pre(use.raw_email)
        end
      end
      row :created_at
      row :updated_at
    end
  end

  index do
    column :id
    column :resource
    column :user
    column :start
    column :finish
    default_actions
  end
end
