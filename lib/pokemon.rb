class Pokemon
  attr_accessor :name, :type, :id, :db
  def initialize(id: nil, name:, type:, db:)
    @name = name
    @type = type
    @db = db
    @id = id
  end

  def self.save (name, type, db)
    new = self.new(name: name,type: type,db: db)

    sql = <<-SQL
    INSERT INTO pokemon (name, type) VALUES (?, ?)
    SQL
    db.execute(sql, new.name, new.type)
    new.id = db.execute("SELECT last_insert_rowid() FROM pokemon")
  end

  def self.find(id, db)
    db.execute("SELECT * FROM pokemon WHERE id = ?", id).map do |row|
      self.new(id: id, name: row[1], type: row[2], db: db)
    end.first
  end
end
