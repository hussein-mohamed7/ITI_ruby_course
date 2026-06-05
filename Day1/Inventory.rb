class Book
  attr_accessor :isbn, :title, :author, :count
# attr_accessor : anther form for setter and getter
  def initialize(isbn, title, author, count = 1)
    @isbn = isbn
    @title = title
    @author = author
    @count = count
  end
end


class Inventory
  def initialize
    @books = []
    load_books
  end

  def load_books
    if File.exist?("books.txt")
      File.readlines("books.txt").each do |line|
        isbn, title, author, count = line.chomp.split(",") # chomp remove new lines (\n)

        new_book = Book.new(isbn, title, author, count.to_i)
        @books << new_book
      end
    end
  end

  def save_books
    file = File.open("books.txt", "w")

    @books.each do |book|
      file.puts "#{book.isbn},#{book.title},#{book.author},#{book.count}"
    end

    file.close
  end

  def list_books
    if @books.empty?
      puts "No books found"
      return
    end

    sorted_books = @books.sort_by { |book| book.isbn }

    sorted_books.each do |book|
      puts "ISBN: #{book.isbn}"
      puts "Title: #{book.title}"
      puts "Author: #{book.author}"
      puts "Count: #{book.count}"
      puts "------------------"
    end
  end

  def add_book
    print "Enter ISBN: "
    isbn = gets.chomp

    print "Enter title: "
    title = gets.chomp

    print "Enter author: "
    author = gets.chomp

    if title.empty? || author.empty? || isbn.empty?
      puts "Invalid input"
      return
    end

    found = false

    @books.each do |book|
      if book.isbn == isbn
        book.count += 1
        book.title = title
        book.author = author
        found = true
        puts "Book already exists, count increased"
      end
    end

    if !found
      new_book = Book.new(isbn, title, author)
      @books << new_book
      puts "Book added"
    end

    save_books
  end

  def remove_book
    print "Enter ISBN: "
    isbn = gets.chomp

    removed = @books.reject! { |book| book.isbn == isbn }

    if removed
      save_books
      puts "Book removed"
    else
      puts "Book not found"
    end
  end

  def search_book
    print "Enter search value: "
    value = gets.chomp.downcase

    found = false

    @books.each do |book|
      if book.title.downcase.include?(value) ||
        book.author.downcase.include?(value) ||
        book.isbn.downcase.include?(value)

        puts "Title: #{book.title}"
        puts "Author: #{book.author}"
        puts "ISBN: #{book.isbn}"
        puts "Count: #{book.count}"
        puts "------------------"

        found = true
      end
    end

    puts "No books found" unless found
  end
end


inventory = Inventory.new

loop do
  puts "\n1. List Books"
  puts "2. Add Book"
  puts "3. Remove Book"
  puts "4. Search Book"
  puts "5. Exit"

  print "Choose: "
  choice = gets.chomp

  case choice
  when "1"
    inventory.list_books
  when "2"
    inventory.add_book
  when "3"
    inventory.remove_book
  when "4"
    inventory.search_book
  when "5"
    puts "Goodbye"
    break
  else
    puts "Invalid choice"
  end
end