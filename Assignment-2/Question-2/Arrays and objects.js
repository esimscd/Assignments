//Initiating array of CFG streams
const cfgStreams = ["Product management", "Software engineering", "Fullstack"]
console.log(cfgStreams)

//Adding Data as the first element of the array
cfgStreams.unshift("Data")
console.log(cfgStreams)

//Removing the first element of the array 
cfgStreams.shift()
console.log(cfgStreams)

//Initiating a string and splitting it
const myString = "Code first girls"
const myArray = myString.split(" ") // split using a space to return each world as an element of the array
console.log(myArray)


//Creating an object containing multiple objects
const programmingLanguage = {
    name: "Python", 
    release: 1991, 
    createdBy: "Guido van Rossum" 
}

//Demonstrating general object methods 
console.log(Object.keys(programmingLanguage));
console.log(Object.values(programmingLanguage));

