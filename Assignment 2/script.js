//Accessing input from page, selecting all radio input buttons

const tempButton = document.querySelectorAll("input[name='temp']");
const  preferenceButton = document.querySelectorAll("input[name='preference]");

//Checking that input was collected correctly
console.log(tempButton)

//Creating an array of possible destinations to select from
const destinations = ["India", ""]

//Function to compare input combinations against destinations
function destinationSelector() {
    if (tempButton === "hot" && preferenceButton === "adventure") {

    }
}