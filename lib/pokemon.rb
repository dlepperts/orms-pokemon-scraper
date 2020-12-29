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
    def self.save(id, name, type)
        sql = <<-SQL
        INSERT INTO pokemon(name, type)
        VALUES (?,?)
        SQL

        DB[:conn].execute(sql, name, type)

        @id = DB[:conn].execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end

    # Finds a pokemon from the database by their id number and returns a new Pokemon object 
    def self.find(id)
        sql = <<-SQL
        SELECT * FROM pokemon
        WHERE id = ?
        SQL

        DB[:conn].execute(sql, id)
    end

end
