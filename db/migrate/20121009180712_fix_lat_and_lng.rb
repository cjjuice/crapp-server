class FixLatAndLng < ActiveRecord::Migration
  def up
      connection.execute(%q{
          alter table bathrooms
          alter column lat
          type float using lat::float
      })
      
        connection.execute(%q{
            alter table bathrooms
            alter column lng
            type float using lng::float
        })
  end

  def down
    connection.execute(%q{
        alter table bathrooms
        alter column lat
        type float using lat::string
    })
    
      connection.execute(%q{
          alter table bathrooms
          alter column lng
          type float using lng::string
      })
  end
end
