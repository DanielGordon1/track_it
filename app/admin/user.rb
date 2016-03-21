ActiveAdmin.register User do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :username, :first_name, :last_name, :email, :tracks, :votes, :comments 

#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  index do
    selectable_column
    column :id
    column :username
    column :first_name
    column :last_name
    column :email
    column :created_at
    column :admin
    column :tracks
    column :comments
    column :votes

    actions
  end

end
