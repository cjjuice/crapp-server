require 'geokit'

class BathroomsController < ApplicationController
  def add
    
    # GET /bathroom/add
    # http://something.com/bathroom/add?name=Test&address=Blah&...

    bathroom = Bathroom.create
    
    bathroom.isHandicapAccessible = params[:isHandicapAccessible]
    bathroom.isPublic = params[:isPublic]
    bathroom.isFamily = params[:isFamily]
    bathroom.isGreen = params[:isGreen]
    bathroom.isUnisex = params[:isUnisex]
    bathroom.isHandsFree = params[:isHandsFree]
    bathroom.hasProductDispenser = params[:hasProductDispenser]
    bathroom.hasAttendent = params[:hasAttendant]
    bathroom.hasSignage = params[:hasSignage]
    bathroom.hasWifi = params[:hasWifi]
    bathroom.name = params[:name]
    bathroom.address = params[:address]
    bathroom.city = params[:city]
    bathroom.state = params[:state]
    bathroom.zip = params[:zip]
    bathroom.lat = params[:lat]
    bathroom.lng = params[:lng]
    bathroom.save

    bathroomType = Bathroomtype.find_or_create_by_btype(params[:bathroomType])
    bathroomType.save

    bathroom.bathroomtype = bathroomType
    
    # Save everything.
    bathroom.save  
    
    render :json => { 'id' => bathroom.id }, :callback => params[:callback]
  end

  def fetch
    # GET /bathroom/fetch
    # https://something.com/bathroom/fetch?id=23

    id = params[:id]
    lat = params[:lat]
    lng = params[:lng]

    output = Array.new
    distanceHash = Hash.new

    # Fetch by ID
    if id 

      bathrooms = [ Bathroom.find(id) ]

    # Fetch by location
    else
    
      bathrooms = []

      list = Bathroom.all

      list.each do |bathroom|
        # Geocode the Lat/Lng
        begin
          bathroom_origin = bathroom.lat + "," + bathroom.lng
          bathroom_location = Geokit::Geocoders::YahooGeocoder.geocode bathroom_origin

          #
          # Super UNSAFE! This is user supplied data that is NOT sanitized! This
          # needs to be changed in the future.
          #
          user_origin = lat + "," + lng
          user_location = Geokit::Geocoders::YahooGeocoder.geocode user_origin
       
          # Calculate the distance
          distance = user_location.distance_to(bathroom_location)
        # Bad stuff can happen. So this should keep us safe <3
        rescue
          distance = -1
        end

        # If the bathroom is within a 5 mile radius, add to to the list!
        if distance >= 0 && distance <= 5
          bathrooms.push(bathroom)
          distanceHash.store(bathroom, distance)
        end
      end
    end 

    bathrooms.each do |bathroom|

      publishedScores = Array.new

      weightedScores = Hash.new

      bathroom.scores.each do |s|
        if weightedScores[s.scoretype.stype]
          weightedScores[s.scoretype.stype]['sum'] = weightedScores[s.scoretype.stype]['sum'] + s.value 
          weightedScores[s.scoretype.stype]['count'] = weightedScores[s.scoretype.stype]['count'] + 1
          weightedScores[s.scoretype.stype]['score'] = weightedScores[s.scoretype.stype]['sum'] / weightedScores[s.scoretype.stype]['count']
        else
          weightedScores[s.scoretype.stype] = Hash.new
          weightedScores[s.scoretype.stype]['sum'] = s.value
          weightedScores[s.scoretype.stype]['count'] = 1
          weightedScores[s.scoretype.stype]['score'] = weightedScores[s.scoretype.stype]['sum'] / weightedScores[s.scoretype.stype]['count']

        end
      end

      weightedScores.each do |k, v|
        publishedScores.push({'type' => k, 'score' => v['score'], 'count' => v['count']})
      end

      btype = ""

      if bathroom.bathroomtype 
        btype = bathroom.bathroomtype.btype
      end   
      
      reviews = bathroom.reviews

      bathroomInfo = { 'info' => bathroom,
                       'type' => btype,
                       'scores' => publishedScores,
                       'reviews' => reviews,
                       'distance' => distanceHash[bathroom] }

      output.push(bathroomInfo)
    end 

    #render :json => { 'bathrooms' => output }
    render :json => { 'bathrooms' => output }, :callback => params[:callback]
  end

  def update
  end

  def delete
  end
end
