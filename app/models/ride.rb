class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :attraction

  def take_ride
    if enough_tickets && height_req
      "Sorry. You do not have enough tickets to ride the #{attraction.name}. You are not tall enough to ride the #{attraction.name}."
    elsif enough_tickets
      "Sorry. You do not have enough tickets to ride the #{attraction.name}."
    elsif height_req
      "Sorry. You are not tall enough to ride the #{attraction.name}."
    else
      new_nausea = self.user.nausea + self.attraction.nausea_rating
      new_happiness = self.user.happiness + self.attraction.happiness_rating
      new_tickets = self.user.tickets - self.attraction.tickets
      self.user.update(
        :nausea => new_nausea,
        :happiness => new_happiness,
        :tickets => new_tickets
      )

      "Thanks for riding the #{self.attraction.name}!"
    end
  end

  def enough_tickets
    self.user.tickets < self.attraction.tickets
  end

  def height_req
    self.user.height.to_i < self.attraction.min_height
  end
end
