class Dock
  attr_reader :name, :max_rental_time, :rental_log, :revenue

  def initialize(name, max_rental_time)
    @name = name
    @max_rental_time = max_rental_time
    @rental_log = {}
    @revenue = 0
  end

  def rent(boat, renter)
    @rental_log[boat] = renter
  end

  def charge(boat)
    if boat.hours_rented > @max_rental_time
      rent_hours = @max_rental_time
    else
      rent_hours = boat.hours_rented
    end

    @rental_log.reduce({}) do |customer_info, info|
      customer_info[:card_number] = @rental_log[boat].credit_card_number
      customer_info[:amount] = boat.price_per_hour * rent_hours
      customer_info
    end
  end

  def log_hour
    @rental_log.keys.each do |boat|
      boat.add_hour
    end
  end

  def return(boat)
    @revenue += charge(boat)[:amount]
    boat.hours_rented = 0
    @rental_log.delete(boat)
  end
end
