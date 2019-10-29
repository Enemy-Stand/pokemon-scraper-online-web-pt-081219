class Pokemon
  attr_accessor :id, :name, :type, :db
  
  def initialize(id:, name:, type:, db:)
    
    @id = id
    @name = name
    @type = type
    @db = db
  end
  
  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type)
      VALUES (?,?)
    SQL
    
    db.execute(sql, name, type)
    @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0][0]
  end
  
  def self.find(id, db)
    sql = "SELECT * FROM pokemon WHERE id = ? LIMIT 1"
    result = db.execute(sql, id)[0]
    Pokemon.new(id: result[0], name: result[1], type: result[2], db: db)

    db[:conn].execute(sql, name, type, id)
    @id = db[:conn].execute("SELECT last_insert_rowid() FROM pokemon")[0][0][0]
  end
  
  def self.find(id)
    sql = "SELECT * FROM pokemon WHERE id = ? LIMIT 1"
    result = DB[:conn].execute(sql, id)[0]
    Pokemon.new(result[0], result[1], result[2], result[3])
  end
end