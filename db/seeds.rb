Musician.destroy_all
Venue.destroy_all 
Gig.destroy_all

renee = Musician.create(name: "Renée Cruz", bio: "She is a badass bassist.", website_url: "reneecruz.com", instrument: "bass")
vanessa = Musician.create(name: "Vanessa Cruz", bio: "She is a badass drummer.", website_url: "vanessacruz.com", instrument: "drums")
brandon = Musician.create(name: "Brandon Lewis", bio: "He is a badass drummer.", website_url: "brandonlewis.com", instrument: "drums")
adesewa = Musician.create(name: "Adesewa", bio: "She is a badass vocalist.", website_url: "adesewa.com", instrument: "vocals")
lawrence = Musician.create(name: "Lawrence Clark", bio: "He is a badass saxophonist.", website_url: "lawrence.com", instrument: "saxophone")
mamiko = Musician.create(name: "Mamiko Watanabe", bio: "She is a badass pianist.", website_url: "mamikowatanabe.com", instrument: "piano")

fat_cat = Venue.create(name: "Fat Cat", location: "75 Christopher Street, NY, NY, 10014", website_url: "fatcatmusic.org") 
vanguard = Venue.create(name: "The Village Vanguard", location: "178 7th Ave S, NY, NY, 10014", website_url: "villagevanguard.com") 
blue_note = Venue.create(name: "The Blue Note", location: "131 W 3rd St, NY, NY, 10012", website_url: "bluenotejazz.com") 
zinc = Venue.create(name: "The Zinc Bar", location: "82 W 3rd S, NY, NY, 10012", website_url: "zincjazz.com") 
smalls = Venue.create(name: "Smalls Jazz Club", location: "183 W 10th St, NY, NY, 10014", website_url: "smallslive.com") 
mezzrow = Venue.create(name: "Mezzrow Jazz Club", location: "163 W 10th S, NY, NY, 10014", website_url: "mezzrow.com") 



Gig.create(musician_id: renee.id, venue_id: fat_cat.id, name: "Renée Cruz Band", description: "Amazing Music!", price: 5)

Gig.create(musician_id: vanessa.id, venue_id: vanguard.id, name: "Vanessa Cruz Experience", description: "Amazing Music!", price: 25)
Gig.create(musician_id: vanessa.id, venue_id: blue_note.id, name: "Vanessa Cruz Experience", description: "Amazing Music!", price: 30)

Gig.create(musician_id: brandon.id, venue_id: vanguard.id, name: "The Program of Deprogramming", description: "Amazing Music!", price: 25)
Gig.create(musician_id: brandon.id, venue_id: blue_note.id, name: "The Program of Deprogramming", description: "Amazing Music!", price: 30)
Gig.create(musician_id: brandon.id, venue_id: fat_cat.id, name: "The Program of Deprogramming", description: "Amazing Music!", price: 5)

Gig.create(musician_id: lawrence.id, venue_id: zinc.id, name: "Lawrence Clark Band", description: "Amazing Music!", price: 15)
Gig.create(musician_id: lawrence.id, venue_id: vanguard.id, name: "Lawrence Clark Band", description: "Amazing Music!", price: 25)

Gig.create(musician_id: mamiko.id, venue_id: mezzrow.id, name: "Mamiko Watanabe Duo", description: "Amazing Music!", price: 20)
Gig.create(musician_id: mamiko.id, venue_id: smalls.id, name: "Mamiko Watanabe Duo", description: "Amazing Music!", price: 20)


puts "It has been seeded."