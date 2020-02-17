require 'minitest/autorun'
require 'minitest/pride'
require './lib/renter'
require './lib/boat'
require './lib/dock'

class DockTest < Minitest::Test
  def setup
    @dock = Dock.new("The Rowing Dock", 3)
    @kayak_1 = Boat.new(:kayak, 20)
    @kayak_2 = Boat.new(:kayak, 20)
    @sup_1 = Boat.new(:standup_paddle_board, 15)
    @sup_2 = Boat.new(:standup_paddle_board, 15)
    @canoe = Boat.new(:canoe, 25)
    @patrick = Renter.new("Patrick Star", "4242424242424242")
    @eugene = Renter.new("Eugene Crabs", "1313131313131313")
  end

  def test_it_exists
    assert_instance_of Dock, @dock
  end

  def test_it_has_attributes
    assert_equal "The Rowing Dock", @dock.name
    assert_equal 3, @dock.max_rental_time
  end

  def test_it_starts_with_empty_rental_log
    empty_hash = {}
    assert_equal empty_hash, @dock.rental_log
  end

  def test_it_can_keep_track_of_rentals
    empty_hash = {}
    assert_equal empty_hash, @dock.rental_log

    @dock.rent(@kayak_1, @patrick)
    @dock.rent(@kayak_2, @patrick)
    @dock.rent(@sup_1, @eugene)

    test_hash = {
      @kayak_1 => @patrick,
      @kayak_2 => @patrick,
      @sup_1 => @eugene
    }

    assert_equal test_hash, @dock.rental_log
  end

  def test_it_can_charge_renters_for_rented_boats
    @dock.rent(@kayak_1, @patrick)
    @dock.rent(@kayak_2, @patrick)
    @dock.rent(@sup_1, @eugene)
    @kayak_1.add_hour
    @kayak_1.add_hour
    @dock.charge(@kayak_1)

    test_hash = {
      :card_number => "4242424242424242",
      :amount => 40
    }
    assert_equal test_hash, @dock.charge(@kayak_1)

    @sup_1.add_hour
    @sup_1.add_hour
    @sup_1.add_hour

    test_hash_2 = {
      :card_number => "1313131313131313",
      :amount => 45
    }
    assert_equal test_hash_2, @dock.charge(@sup_1)

    @sup_1.add_hour
    @sup_1.add_hour
    assert_equal test_hash_2, @dock.charge(@sup_1)
  end

  def test_it_can_log_hours_for_rented_boats
    @dock.rent(@kayak_1, @patrick)
    @dock.rent(@kayak_2, @patrick)
    assert_equal 0, @kayak_1.hours_rented
    assert_equal 0, @kayak_2.hours_rented

    @dock.log_hour
    assert_equal 1, @kayak_1.hours_rented
    assert_equal 1, @kayak_2.hours_rented

    @dock.log_hour
    assert_equal 2, @kayak_1.hours_rented
    assert_equal 2, @kayak_2.hours_rented

    @dock.rent(@canoe, @patrick)
    @dock.log_hour
    assert_equal 1, @canoe.hours_rented
    assert_equal 3, @kayak_1.hours_rented
    assert_equal 3, @kayak_2.hours_rented
  end

  def test_it_can_return_boats
    test_hash = {
      @kayak_1 => @patrick,
      @kayak_2 => @patrick,
      @canoe => @patrick
    }

    @dock.rent(@kayak_1, @patrick)
    @dock.rent(@kayak_2, @patrick)
    @dock.rent(@canoe, @patrick)
    assert_equal test_hash, @dock.rental_log
    @dock.log_hour
    assert_equal 1, @canoe.hours_rented
    assert_equal 1, @kayak_1.hours_rented
    assert_equal 1, @kayak_2.hours_rented

    test_hash2 = {}
    @dock.return(@kayak_1)
    @dock.return(@kayak_2)
    @dock.return(@canoe)
    assert_equal test_hash2, @dock.rental_log
    assert_equal 0, @canoe.hours_rented
    assert_equal 0, @kayak_1.hours_rented
    assert_equal 0, @kayak_2.hours_rented
  end

  def test_it_can_generate_revenue
    assert_equal 0, @dock.revenue
    @dock.rent(@kayak_1, @patrick)
    @dock.rent(@kayak_2, @patrick)
    @dock.rent(@canoe, @patrick)
    @dock.log_hour
    assert_equal 0, @dock.revenue

    @dock.log_hour
    assert_equal 0, @dock.revenue

    @dock.return(@kayak_1)
    assert_equal 40, @dock.revenue

    @dock.return(@kayak_2)
    assert_equal 80, @dock.revenue

    @dock.return(@canoe)
    assert_equal 130, @dock.revenue

    @dock.rent(@sup_1, @eugene)
    @dock.rent(@sup_2, @eugene)
    assert_equal 130, @dock.revenue

    @dock.log_hour
    @dock.log_hour
    @dock.log_hour
    @dock.log_hour
    @dock.log_hour
    assert_equal 130, @dock.revenue

    @dock.return @sup_1
    assert_equal 175, @dock.revenue

    @dock.return @sup_2
    assert_equal 220, @dock.revenue
  end
end
