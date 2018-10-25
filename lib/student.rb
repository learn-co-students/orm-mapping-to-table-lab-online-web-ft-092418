class Student
  attr_accessor :name, :grade
  attr_reader :id
  #  with DB[:conn]  
  
  def initialize(name, grade, id = nil)
    self.name = name 
    self.grade = grade
    @id = id
  end
  
  def self.drop_table
    sql = <<-SQL
      DROP TABLE students
    SQL
    DB[:conn].execute(sql)
  end
  
  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students(
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade INTEGER
      )
      SQL
      DB[:conn].execute(sql)
  end
  
  def save
    sql = <<-SQL
      INSERT INTO students(name, grade)
      VALUES (?,?)
      SQL
      DB[:conn].execute(sql, self.name, self.grade)
      @id = DB[:conn].execute("SELECT id FROM students DESC LIMIT 1").flatten[0]
  end
  
  def self.create(atrribute_hash)
    # atrribute_hash.each {|key, value|
      
    #   binding.pry
    # }
    student = Student.new(atrribute_hash[:name], atrribute_hash[:grade])
    student.save
    student
  end
end
