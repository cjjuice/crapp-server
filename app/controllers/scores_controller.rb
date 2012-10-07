class ScoresController < ApplicationController

  def add

    # /scores/add?id=1&cleanliness=5&atmosphere
    
    status = "ok"

    scoreTypes = [
                  "cleanliness",
                  "atmosphere",
                  "privacy",
                  "waittime",
                  "overall",
                  "neighborhood"
                 ]
    
    params.each do |key, value|
      begin
        if scoreTypes.include?(key)
          score = Score.create

          score.bathroom = Bathroom.find(params[:id])
          score.scoretype = Scoretype.find_by_stype(key)
          score.value = value

          score.save
        end 
      rescue
        # Do nothing if an exception is thrown =)
        status = "crapp!!"
      end
    end

    render :json => { 'status' => status }
  end

end
