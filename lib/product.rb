class ProductHunt

  attr_accessor :products, :users

  def initialize
    @products = {"Test1" => 5, "Test2" =>4}
    @users = {
                "Person1" => {"XYZ" => "up","ABC" => "down"},
                "Person2" => {"ABC" => "down"}          
             }
  end

  def start
    input = 0
    until (input == 1 || input == 2 || input == 3 || input == 4)
      puts "Please enter 1 to display Products and votes"
      puts "Please enter 2 to add a new product"
      puts "Please enter 3 to vote"
      puts "Please enter 4 to quit"
      input = gets.to_i
    end
    if input == 4 
      puts "Good Bye"
    else
      continue(input)
      start
    end
  end

  def continue(input)
    if input == 1
      display
    elsif input == 2
      addproduct
    elsif input == 3
      startvote
    end
  end

  def display
    @products = Hash[@products.sort_by{|k, v| v}.reverse]
    @products.each do |product,votes|
      puts "Product: #{product} Votes: #{votes}"
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

  def addproduct
    puts "Please enter product"
    product = gets.strip
    if @products.has_key?(product) == false
      @products[product] = 0
      puts "Product #{product} added"
    else
      puts "Product already exists"
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

end

PH = ProductHunt.new
PH.start

