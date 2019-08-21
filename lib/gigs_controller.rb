def can_be_instantiated_and_then_saved
  gig = Gig.new
  gig.title = "This is a title."
  gig.save
end

