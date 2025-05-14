@description('Array of dog objects')
var dogs = [
  {
    name: 'Evie'
    age: 5
    interests: ['Ball', 'Frisbee']
  }
  {
    name: 'Casper'
    age: 3
    interests: ['Other dogs']
  }
  {
    name: 'Indy'
    age: 2
    interests: ['Butter']
  }
  {
    name: 'Cira'
    age: 8
    interests: ['Rubs']
  }
]

@description('Dogs aged 5 or older')
output oldDogs array = filter(dogs, dog => dog.age >= 5)

@description('First two dogs whose names start with C')
output dogNameIndex array = filter(dogs, (val, i) => i < 2 && substring(val.name, 0, 1) == 'C')
