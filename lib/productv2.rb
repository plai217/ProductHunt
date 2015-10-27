require 'pry'

class ProductHunt

attr_accessor :products, :name, :comments

  def initialize
    @products = {"Test1" => 5, "Test2" =>4}
    @comments = {"Test1" => {"My comment1 abc" => "Person1", "My comment1 xyz" => "Person2"},
                 "Test2" => {"My comment2 AAA" => "Person1"}
                }
    @users = {
                "Person1" => {"XYZ" => "up","ABC" => "down"},
                "Person2" => {"ABC" => "down"}          
             }
  end

  def start
    input = 0
    until (input == 1 || input == 2 || input == 3 || input == 4 || input == 5 || input == 6)
      puts "Please enter 1 to display products and votes"
      puts "Please enter 2 to display comments for a product"
      puts "Please enter 3 to add a new product"
      puts "Please enter 4 to vote"
      puts "Please enter 5 to add a comment to product"
      puts "Please enter 6 to quit"
      input = gets.to_i
    end
    if input == 6
      puts "Good Bye"
    else
      continue(input)
      start
    end
  end

  def continue(input)
    if input == 1
      display
    elsif input ==2
      displaycomments
    elsif input == 3
      addproduct
    elsif input == 4
      startvote
    elsif input == 5
      startcomment
    end
  end

  def display
    @products = Hash[@products.sort_by{|k, v| v}.reverse]
    @products.each do |product,votes|
      puts "Product: #{product} Votes: #{votes}"
    end
  end

  def addproduct
    puts "Please enter product"
    product = gets.strip
    if @products.has_key?(product) == false
      @products[product] = 0
      @comments[product] = {}
      puts "Product #{product} added"
    else
      puts "Product already exists"
    end
  end

  def startvote
    puts "Please enter name"
    user = gets.strip
    product = ''
    until @products.has_key?(product)
      puts "Products"
      @products.each {|x,y| puts "#{x}"}
      puts "please enter vaild product"
      product = gets.strip
    end
    vote = ''
    until vote == 'up' || vote == 'down'
      puts "please enter up or down"
      vote = gets.strip
    end 
    applyvote(user,product,vote)
  end

  def applyvote(user,product,vote)
    if user_status(user,product,vote) == "newuser"
      addvote(user,product,vote)
      @users[user] = {product => vote}
      puts "votes for #{product} is now #{@products[product]}"
    elsif user_status(user,product,vote) == "novote"
      addvote(user,product,vote)
      @users[user][product] = vote
      puts "votes for #{product} is now #{@products[product]}"
    elsif user_status(user,product,vote) == "different"
      addvote(user,product,vote)
      addvote(user,product,vote)
      @users[user][product] = vote
      puts "votes for #{product} is now #{@products[product]}"
    else
      puts "already voted, vote remains at #{@products[product]} for #{product}"
    end
  end

  #adds 1 vote based on direction
  def addvote(user,product,vote)
    if vote == "up"
      @products[product] += 1
    elsif
      @products[product] -= 1
    end
  end

  #determines if new user and if user voted and if it's in the same direction
  def user_status(user,product,vote)
    if @users.has_key?(user) == false
      return "newuser"
    elsif @users[user].has_key?(product) == false
      return "novote"
    elsif @users[user][product][vote] == vote
      return "same"
    else
      return "different"
    end
  end

  def startcomment
    puts "Please enter name"
    user = gets.strip
    product = ''
    until @products.has_key?(product)
      puts "Products"
      @products.each {|x,y| puts "#{x}"}
      puts "please enter vaild product"
      product = gets.strip
    end
    comment = ''
    puts "please enter comment"
    comment = gets.strip
    applycomment(user,product,comment)
  end

  def applycomment(user,product,comment)
    @comments[product][comment] = user
    puts  @comments[product][comment]
  end

  def displaycomments
    puts "Products"
    @products.each {|x,y| puts "#{x}"}
    puts "Please enter a valid product you wish to see comments for"
    product = gets.strip
    until @products.has_key?(product)
      puts "Products"
      @products.each {|x,y| puts "#{x}"}
      puts "Please enter a valid product you wish to see comments for"
      product = gets.strip
    end
    puts "Comments for #{product}"
    @comments[product].each {|key,value|puts "#{key} posted by #{value}"}
  end

end

PH = ProductHunt.new
PH.start

