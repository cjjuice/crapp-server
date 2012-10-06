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
    
    render :json => { 'id' => bathroom.id } 
  end

  def fetch
    # GET /bathroom/fetch
    # https://something.com/bathroom/fetch?id=23
    id = params[:id]

    bathroom = Bathroom.find(id)

    bathroomScores = Array.new

    bathroomScores.push({ 'type' => 'cleanliness',
                          'score' => 5 })

    bathroomScores.push({ 'type' => 'atmosphere',
                           'score' => 4 })

    bathroomInfo = { 'info' => bathroom,
                     'type' => bathroom.bathroomtype.btype,
                     'scores' => bathroomScores }

    #render :json => { :bathroom => bathroom }
    render :json => { 'bathrooms' => [ bathroomInfo ] }
  end

  def update
  end

  def delete
  end
end
