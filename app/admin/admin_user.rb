ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation, :fname, :login

  index do
    selectable_column
    id_column
    column :fname
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :fname
  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :fname
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
