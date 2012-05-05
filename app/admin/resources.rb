ActiveAdmin.register Resource do
  actions :index, :show

  index do
    id_column
    column :order
    column :name
    column :location
    column :duration
    column :created_at
    default_actions
  end
end
