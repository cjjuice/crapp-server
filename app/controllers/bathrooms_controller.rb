class BathroomsController < ApplicationController
  def add
    
    # GET /bathroom/add
    # http://something.com/bathroom/add?name=Test&address=Blah&...

    bathroom = Bathroom.create
    bathroomType = Bathroomtype.create
    
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

    bathroomType.btype = params[:bathroomType]
    bathroomType.save

    bathroom.bathroomtype = bathroomType
    
    # Save everything.
    bathroom.save  
    
    render :json => { 'id' => bathroom.id } 
  end

  def fetch
    #https://something.com/bathroom/fetch?id=23
    @id = params[:id]
  end

  def update
  end

  def delete
  end
end
