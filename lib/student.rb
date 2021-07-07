class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

  attr_accessor :name , :grade
  attr_reader :id

  def initialize (name , grade , id= nil)
    @name = name
    @grade = grade
    @id = id

  end

  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      ID INTEGER PRIMARY KEY,
      NAME TEXT ,
      GRADE INTEGER
    )
    SQL
    DB[:conn].execute(sql)
  end


  def self.drop_table
    sql = <<-SQL
    DROP TABLE students
    SQL
    DB[:conn].execute(sql)
  end


  def save
    sql = <<-SQL
    INSERT INTO students ( name , grade) VALUES(  ? , ?)
    SQL
    DB[:conn].execute(sql , self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def self.create (student_hash)
    st = self.new('' , 0)
    student_hash.each do |k,v|
      st.send("#{k}=" , v)
    end
    st.save
    st
  end


end
