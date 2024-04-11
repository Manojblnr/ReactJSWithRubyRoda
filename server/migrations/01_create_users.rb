Sequel.migration do
    up do
        create_table(:users) do
            primary_key :id

            String		:token
            
            String      :username, :allow_null => false

            String      :email

            String      :mobile

            String		:password_digest

			String		:password_text

            DateTime	:created_at
			DateTime	:updated_at
			DateTime	:deleted_at
        end
    end
            
    down do
        drop_table(:users)
    end
end