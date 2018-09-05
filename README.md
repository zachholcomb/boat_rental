# Boat Rental

## Setup

* Fork [this Repository](https://github.com/turingschool-examples/boat_rental)
* Clone YOUR fork
* Compete the activity below
* Push your solution to your fork
* Submit a pull request from your repository to the turingschool-examples repository
  * Make sure to put your name in your PR!

# Activity

## Iteration 1

Use TDD to create a `Boat` class that responds to the following interaction pattern:

```ruby
pry(main)> require './lib/boat'
#=> true

pry(main)> kayak = Boat.new(:kayak, 20)    
#=> #<Boat:0x00007fceac8f0480...>

pry(main)> kayak.type
#=> :kayak

pry(main)> kayak.price_per_hour
#=> 20

pry(main)> kayak.hours_rented
#=> 0

pry(main)> kayak.add_hour
#=> 1

pry(main)> kayak.add_hour
#=> 2

pry(main)> kayak.add_hour
#=> 3

pry(main)> kayak.hours_rented
#=> 3
```

## Iteration 2

Use TDD to create a `Renter` and a `Dock` class that respond to the following interaction pattern:

```ruby
pry(main)> require './lib/renter'
#=> true

pry(main)> require './lib/dock'
#=> true

pry(main)> renter = Renter.new("Patrick Star", "4242424242424242")    
#=> #<Renter:0x00007fb5ef98b118...>

pry(main)> renter.name
#=> "Patrick Star"

pry(main)> renter.credit_card_number
#=> "4242424242424242"

pry(main)> dock = Dock.new("The Rowing Dock", 3)    
#=> #<Dock:0x00007fb5efb36148...>

pry(main)> dock.name
#=> "The Rowing Dock"

pry(main)> dock.max_rental_time
#=> 3
```

## Iteration 3

Use TDD to update your `Dock` class so that it can calculate revenue. A `Dock` earns revenue for each `Boat` that it rents based on the following rules:

* A `Dock` charges based on how long the `Boat` was rented. A `Boat` can be rented for no longer than the `Dock`'s `max_rental_time`. For instance, if the `max_rental_time` is `3` and a `Boat` is out for `5` hours, the `Boat` will only be charged for `3` hours.
* A `Dock` charges the `Boat`'s `price_per_hour` for each hour rented (up to the `max_rental_time`).
* When the `Dock`'s `rent` method is called, it begins tracking how long the `Boat` is rented for.
* When the `Dock`'s `return` method is called, the `Dock` stops tracking how long the `Boat` is rented for.
* Every time the `Dock`'s `log_hour` method is called, any `Boat` that has been rented but not returned is considered to have been rented an additional hour.

The `Dock` class should now respond to the following interaction pattern:

```ruby
pry(main)> require './lib/renter'

pry(main)> require './lib/boat'

pry(main)> require './lib/dock'

pry(main)> dock = Dock.new("The Rowing Dock", 3)

pry(main)> kayak_1 = Boat.new(:kayak, 20)

pry(main)> kayak_2 = Boat.new(:kayak, 20)    

pry(main)> canoe = Boat.new(:canoe, 25)    

pry(main)> sup_1 = Boat.new(:standup_paddle_board, 15)    

pry(main)> sup_2 = Boat.new(:standup_paddle_board, 15)    

pry(main)> patrick = Renter.new("Patrick Star", "4242424242424242")

pry(main)> eugene = Renter.new("Eugene Crabs", "1313131313131313")    

# Rent Boats out to first Renter
pry(main)> dock.rent(kayak_1, patrick)

pry(main)> dock.rent(kayak_2, patrick)

pry(main)> dock.log_hour

pry(main)> dock.rent(canoe, patrick)

pry(main)> dock.log_hour

pry(main)> dock.return(kayak_1)

pry(main)> dock.return(kayak_2)

pry(main)> dock.return(canoe)

# Revenue thus far
pry(main)> dock.revenue
#=> 105

# Rent Boats out to second Renter
pry(main)> dock.rent(sup_1, eugene)

pry(main)> dock.rent(sup_2, eugene)

pry(main)> dock.log_hour

pry(main)> dock.log_hour

pry(main)> dock.log_hour

# Any hours rented past the max rental time are not counted
pry(main)> dock.log_hour

pry(main)> dock.log_hour

pry(main)> dock.return(sup_1)

pry(main)> dock.return(sup_2)

# Total revenue
pry(main)> dock.revenue
#=> 195
```

## Iteration 4

Use TDD to update your `Dock` class so that is responds to the following interaction pattern:

```ruby
pry(main)> require './lib/renter'

pry(main)> require './lib/boat'

pry(main)> require './lib/dock'

pry(main)> dock = Dock.new("The Rowing Dock", 3)

pry(main)> kayak_1 = Boat.new(:kayak, 20)

pry(main)> kayak_2 = Boat.new(:kayak, 20)    

pry(main)> canoe = Boat.new(:canoe, 25)    

pry(main)> sup_1 = Boat.new(:standup_paddle_board, 15)    

pry(main)> sup_2 = Boat.new(:standup_paddle_board, 15)    

pry(main)> patrick = Renter.new("Patrick Star", "4242424242424242")

pry(main)> eugene = Renter.new("Eugene Crabs", "1313131313131313")    

pry(main)> dock.rent(kayak_1, patrick)

pry(main)> dock.rent(kayak_2, patrick)

pry(main)> dock.log_hour

pry(main)> dock.rent(canoe, patrick)

pry(main)> dock.log_hour

pry(main)> dock.return(kayak_1)

pry(main)> dock.return(kayak_2)

pry(main)> dock.return(canoe)

pry(main)> dock.rent(sup_1, eugene)

pry(main)> dock.rent(sup_2, eugene)

pry(main)> dock.log_hour

pry(main)> dock.log_hour

pry(main)> dock.log_hour

pry(main)> dock.log_hour

pry(main)> dock.log_hour

pry(main)> dock.return(sup_1)

pry(main)> dock.return(sup_2)

pry(main)> dock.charges
#=> {"4242424242424242" => 105, "1313131313131313" => 90}

pry(main)> dock.total_hours_by_rental_type
#=> {:kayak => 4, :canoe => 1, :standup_paddle_board => 10}
```
