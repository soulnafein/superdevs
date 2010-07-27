class MigrateLocationToCountryAndCity < ActiveRecord::Migration
  def self.up
    combinations = {
      "London, UK" => ["London", "United Kingdom"],
      "London, United Kingdom" => ["London", "United Kingdom"],
      "London" => ["London", "United Kingdom"],
      "Sheffield, United Kingdom" => ["Sheffield", "United Kingdom"],
      "Preston, UK" => ["Preston", "United Kingdom"],
      "Cardiff, United Kingdom" => ["Cardiff", "United Kingdom"],
      "Frankfurt am main, Germany" => ["Frankfurt am main", "Germany"],
      "Ireland" => [nil, "Ireland"],
      "India" => [nil, "India"],
      "Wirral" => ["Wirral", "United Kingdom"],
      "Edinburgh, United Kingdom" => ["Edinburgh", "United Kingdom"],
      "Wrexham" => ["Wrexham", "United Kingdom"]
    }
    
    combinations.keys.each do |old_location|
      new_location = combinations[old_location]
      users = User.where(:location => old_location)
      users.each do |user|
        user.city = new_location[0]
        user.country = new_location[1]
        user.save!
      end
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
