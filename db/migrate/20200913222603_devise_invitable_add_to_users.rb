class DeviseInvitableAddToUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.string     :invitation_token
      t.datetime   :invitation_created_at
      t.datetime   :invitation_sent_at
      t.datetime   :invitation_accepted_at
      t.integer    :invitation_limit
      t.references :invited_by, type: :uuid, foreign_key: { to_table: :users, on_delete: :nullify }
      t.integer    :invitations_count, default: 0

      t.index      :invitations_count
      t.index      :invitation_token, unique: true # for invitable
    end
  end
end
