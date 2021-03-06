album_names = [
  "Nevermind",
  "Ten",
  "Ok Computer",
  "The Miseducation of Lauryn Hill",
  "Automatic For The People",
  "Achtung Baby",
  "The Chronic",
  "Metallica (a.k.a. The Black Album)",
  "Jagged Little Pill",
  "Dookie",
  "Blood Sugar Sex Magik",
  "(What's the Story) Morning Glory",
  "Ready To Die",
  "Mellon Collie and the Infinite Sadness",
  "Downward Spiral",
  "The Score",
  "Superunknown",
  "CrazySexyCool",
  "Illmatic",
  "The Low End Theory",
  "In Utero",
  "Rage Against The Machine",
  "Siamese Dream",
  "Out of Time",
  "Dirt",
  "Odelay",
  "All Eyez on Me",
  "Fear Of A Black Planet",
  "The Bends",
  "Definitely Maybe",
  "Aquemini",
  "Enter the Wu",
  "MTV Unplugged in New York",
  "Weezer",
  "Urban Hymns",
  "The Slim Shady LP",
  "Life After Death",
  "Grace",
  "I Do Not Want What I Haven't Got",
  "AmeriKKKa's Most Wanted",
  "Ritual De Lo Habitual",
  "Use Your Illusion I",
  "Use Your Illusion II",
  "Ill Communication",
  "Doggystyle",
  "Vitalogy",
  "Aenima",
  "Californication",
  "3 Years, 5 Months, & 2 Days in the Life of...",
  "Vs.",
  "Tragic Kingdom",
  "Supernatural",
  "Unplugged",
  "Check Your Head",
  "Violator",
  "Cypress Hill",
  "Throwing Copper",
  "Baduizm",
  "BadMotorFinger",
  "Tuesday Night Music Club",
  "August and Everything After",
  "Sublime",
  "Supa Dupa Fly",
  "Parklife",
  "Ray of Light",
  "Hello Nasty",
  "Live Through This",
  "Battle of Los Angeles",
  "What's the 411?",
  "Time Out of Mind",
  "Me Against the World",
  "Blue Lines",
  "Post",
  "Slanted and Enchanted",
  "Loveless",
  "Exile in Guyville",
  "Dummy",
  "Smash",
  "Mellow Gold",
  "Cracked Rear View",
  "Please Hammer Don't Hurt 'Em",
  "Screamadelica",
  "Reasonable Doubt",
  "Debut",
  "Play",
  "Vulgar Display of Power",
  "Different Class",
  "The Fat of the Land",
  "Devil Without a Cause",
  "Little Earthquakes",
  "To Bring You My Love",
  "Suede",
  "Mama Said Knock You Out",
  "Korn",
  "Temple of the Dog",
  "II",
  "Dig Your Own Hole",
  "My Life",
  "Shake Your Money Maker",
  "Daydream"
]

album_names
|> Enum.shuffle()
|> Stream.cycle()
|> Enum.take(500)
|> Task.async_stream(
  fn album_name ->
    IO.puts(album_name)
    :rand.uniform(2500) |> Process.sleep()
    Mbrainz.search_album(album_name, exact_match: true)
  end,
  max_concurrency: 2,
  timeout: 10000
)
|> Stream.run()
