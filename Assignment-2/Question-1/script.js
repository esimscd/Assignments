//The purpose of this web app is to generate a list of travel destination/activities


//Accessing input from page, selecting all radio input buttons using ID
const hot = document.getElementById("hot")
const cold = document.getElementById("cold")
const adventure = document.getElementById("adventure")
const relax = document.getElementById("relax")

//Accessing result display area
let resultDisplay = document.getElementById("result")

//Creating an object with an four arrays inside of possible destinations to select from

let hotAdventure = ["Visit Ranthambore National Park in India", "Safari in Kenya", "Scuba Diving in the Galapagos Islands" ]
let hotRelax = ["Relax in the Maldives", "Bora Bora", "Explore the island of Maurtius"]
let coldAdventure = ["Hiking in Patagonia", "Voyage in Antartica", "Volcano Hiking in Russia" ]
let coldRelaxing = ["A weekend break in Halstatt, Austria", "City break in Vancouver, Canada"]


//Function using boolean and if else to select a destination randomly from a selected array
function destinationSelector() {
    console.log("button works and function runs")//Checking button to run function

    if (hot.checked && adventure.checked){
        resultDisplay.innerText = "hot and adventure"
    }

    else if (hot.checked && relax.checked) {
        resultDisplay.innerText = "hot and relax"
    }

    else if (cold.checked && adventure.checked) {
        resultDisplay.innerText = "cold and adventure"
    }
    else if (cold.checked && relax.checked) {
        resultDisplay.innerText = "cold and relax"
    }
    else {
        alert("Please select an option for each question")
    }

    //

}

//Selecting button and defining event
document.getElementById("checkInputBtn").addEventListener("click", destinationSelector)