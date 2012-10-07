class ReviewsController < ApplicationController
  def add
    review = Review.create
    
    review.reviewtext = params[:reviewtext]
    review.bathroom = Bathroom.find(params[:id])
    
    review.save 
    
    render :json => { 'id' => review.id }, :callback => params[:callback] 
  end  
end  
