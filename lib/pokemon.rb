class Pokemon

    attr_accessor :id, :name, :type, :db

    # Is initialized with keyword arguments of id, name, type and db.
    def initialize(id:, name:, type:, db:)
        @id = id
        @name = name
        @type = type
        @db = db
    end

    # Saves an instance of a pokemon with the correct id.
    def self.save(name, type, db)
        sql = <<-SQL
        INSERT INTO pokemon(name, type)
        VALUES (?,?)
        SQL

        db.execute(sql, name, type)

        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end


    # Finds a pokemon from the database by their id number and returns a new Pokemon object 
    def self.find(id, db)
        sql = "SELECT * FROM pokemon WHERE id = ?"
        result = db.execute(sql, id)[0]
        self.new(id: result[0], name: result[1], type: result[2], db: @db)
    end

end
