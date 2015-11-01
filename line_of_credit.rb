
class Credit
  attr_reader :APR, :limit, :balance, :interest
  @@lastDay=0 #this variable is used to record the date of the last transaction happen
  
  def initialize(apr, limit, balance=0, interest=0)
    @transactionRecorder=Array.new
    @APR= apr
    @limit=limit
    @remainingLimit=limit
    @balance=balance
    @interest=interest
  end
  
  def withdraw(amount,day)
    if day>30
      puts "Access denied: input date should be within one month"
    else
      @transactionRecorder.push("Transaction type: withdraw\nAmount: $#{amount}\nDate: day #{day}")
         if amount>@remainingLimit 
           puts "Access denied: exceed limit"
         else 
           if day==1
                 calculate_interest_so_far(day-1)
               else 
                 calculate_interest_so_far(day)
           end
           @balance+=amount
           @remainingLimit-=amount
           
           puts "Withdrew $#{amount} on day #{day}. New balance: $#{@balance}"
         end
    end
  end
  
  def payment(amount,day)
    if day>30
          puts "Access denied: input date should be within one month"
    else
    @transactionRecorder.push("Transaction type: payment\nAmount: $#{amount}\nDate: day #{day}")
    if day==1
      calculate_interest_so_far(day-1)
    else 
      calculate_interest_so_far(day)
    end
    @balance-=amount
    if @remainingLimit+amount<=@limit
      @remainingLimit+=amount
    else 
      @remainingLimit=@limit
    end
    end
    
    puts "Paid $#{amount} on day #{day}. New balance: $#{@balance}"
  end
  
  def payoff_amount_on_day_30
    calculate_interest_so_far(30)
    puts "Payoff amount on day 30: $#{@balance+@interest}"
  end
  
  def display_balance
    puts "Balance: $#{@balance}"
  end
  
  def calculate_interest_so_far(day)
    if day==@@lastDay
    else
      @interest+=@balance*@APR/100.0/365.0*(day-@@lastDay)
      @@lastDay=day
    end
  end
  
  def display_interest(day) #display interest accumulated until input date
    calculate_interest_so_far(day)
    puts "Interest: $#{@interest}"
  end
  
  def display_transactionRecord
    @transactionRecorder.each{|x| puts x}
  end
  
  def display_remainingLimit
    puts "RemainingLimit: $#{@remainingLimit}"
  end
end

#test case
my_card=Credit.new(35,1000)
my_card.withdraw(500,1)
my_card.payment(200,15)
my_card.withdraw(100,25)
my_card.display_balance
my_card.display_interest(20)
my_card.display_remainingLimit()
my_card.display_transactionRecord
my_card.payoff_amount_on_day_30