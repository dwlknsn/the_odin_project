const findTheOldest = function(people) {
  
  people.forEach(function(person) {
    person.age = getAge(person.yearOfBirth, person.yearOfDeath);
  });
  
  let sorted = people.sort((a, b) => a.age - b.age);
  
  return sorted[sorted.length - 1]
};

const currentYear = new Date().getFullYear();
const getAge = function(birthYear, deathYear = currentYear) {
  return deathYear - birthYear;
}

// Do not edit below this line
module.exports = findTheOldest;
