//The purpose of this web app is to generate a list of travel destination/activities based on two inputs from the user.
//The app uses booleans to check all conbinations of responses and display an array of results and responds to event of button click to run

//Accessing input from page, selecting all radio input buttons using ID
const hot = document.getElementById("hot")
const cold = document.getElementById("cold")
const adventure = document.getElementById("adventure")
const relax = document.getElementById("relax")

//Accessing result display area
let resultDisplay = document.getElementById("result")

//Creating an object with an four arrays inside of possible destinations to select from
const destinations = { 
    hotAdventure: ["Visiting Ranthambore National Park in India", "Safari in Kenya", "Scuba Diving in the Galapagos Islands" ],
    hotRelax: ["Island hopping in the Maldives", "A boat trip in Bora Bora", "Explore the islands of Maurtius"],
    coldAdventure: ["Skiing in Hokkaido", "Expedition to Antartica", "Volcano Hiking in Russia" ],
    coldRelaxing: ["A Secluded countryside stay in Norway", "City break in Vancouver", "Visiting the lagoons in Iceland"]
}

//Function using boolean and if else to select a destination randomly from a selected array
function destinationSelector() {
    console.log("button works and function runs")//Checking button to run function

    let selectedArray = [];

    if (hot.checked && adventure.checked){
        selectedArray = destinations.hotAdventure
    }

    else if (hot.checked && relax.checked) {
        selectedArray = destinations.hotRelax
    }

    else if (cold.checked && adventure.checked) {
        selectedArray = destinations.coldAdventure
    }
    else if (cold.checked && relax.checked) {
        selectedArray = destinations.coldRelaxing
    }
    else {
        alert("Please select an option for each question")//Alert if either question does not have a response selected
    }

    //Displaying list of destinations from array as undordered list
    resultDisplay.innerHTML = "How about: <ul>";

    // Using a for loop to iterate through the array and add each item as a list element
    for (let i = 0; i < selectedArray.length; i++) {
        resultDisplay.innerHTML += `<li>${selectedArray[i]}</li>`;
    }

    resultDisplay.innerHTML += "</ul>"; 
}

//Selecting button and defining event
document.getElementById("checkInputBtn").addEventListener("click", destinationSelector);