Todo:

- When processing player matches in the player_match_worker, create a row for each player vs just the player that made the request.
- Do a better job of checking for new records by creating a job that looks for missing matches
- Create a record for the Match with the match data from GetMatchHistory
- Deploy and so-forth



The storage of ability_upgrades in the PlayerMatch table leaves a lot to be desired. The Dota API returns a nice array of hashes:

ability_upgrades: [
  {
    ability: 5103,
    time: 164,
    level: 1
  },
  {
    ability: 5102,
    time: 309,
    level: 2
  },
  {
    ability: 5103,
    time: 392,
    level: 3
  },
  {
    ability: 5104,
    time: 484,
    level: 4
  },
  {
    ability: 5103,
    time: 531,
    level: 5
  },

  ...

We store it as a flat array:

[2] pry(main)> match.ability_upgrades
=> ["ability=>5250",
 " time=>166",
 " level=>1",
 "ability=>5249",
 " time=>291",
 " level=>2",
 "ability=>5251",
 " time=>361",
 " level=>3",
 "ability=>5249",
 " time=>451",
 " level=>4",
 "ability=>5249",
 " time=>506",
 " level=>5",


