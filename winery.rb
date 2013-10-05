class Winery < ActiveRecord::Base

  after_create :geocode!
  
  def geocode!
    geo = Geocoder.search( self.address)
    if geo[0] # != nil
      self.lat = geo[0].latitude
      self.long = geo[0].longitude
      save
    else
      puts "Geocoder not availalbe, try again later"
      # fail gracefully
    end
  end

  def self.geocode_all!
    Winery.all.each do |winery|
      winery.geocode! if winery.lat.nil? || winery.long.nil?
    end
  end

  def self.ungeocoded_count
Winery.where("lat is NULL and long is NULL").count
  end

end

 
