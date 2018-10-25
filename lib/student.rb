class Student

  attr_accessor :name, :grade
  attr_reader :id
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

  def initialize(name, grade)
    self.name = name
    self.grade = grade
  end


  def self.create_table

    DB[:conn].execute(
      <<-SQL
        CREATE TABLE IF NOT EXISTS students(
          id INTEGER PRIMARY KEY, name TEXT,
          grade INTEGER
        );
      SQL
    )

  end

  def self.drop_table
    DB[:conn].execute("
      DROP TABLE students;")
  end

  def save
    #binding.pry
    DB[:conn].execute(
      "
      INSERT INTO students (name, grade)
      VALUES (?, ?)
      " , self.name, self.grade
    )
  #  binding.pry
    @id = DB[:conn].execute("SELECT id FROM students ORDER BY id DESC LIMIT 1")[0][0]
    #self.class.new(self.name, self.grade)
  end

  def self.create(name: nil, grade: nil)
    self.new(name, grade).tap{|student| student.save}

  end
end
