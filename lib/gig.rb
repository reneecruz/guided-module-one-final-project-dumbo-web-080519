class Gig < ActiveRecord::Base

    belongs_to :musician
    belongs_to :venue 

    def display_info
        
    end
  
end