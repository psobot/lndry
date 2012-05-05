ActiveAdmin.register Use do
  actions :index, :show
  index do
    column :id
    column :resource
    column :user
    column :start
    column :finish
    default_actions
  end
end
