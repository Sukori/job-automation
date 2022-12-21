function autoCompleter1(fullName, commentSendTo){
    
    const theTable = document.getElementById("GeneralInfo");
    const nameInput = theTable.querySelector("[tabindex='1']");
    nameInput.value = fullName;

    const textArea = document.getElementsByTagName("textarea")[0];
    textArea.value = commentSendTo;

    const modifyLineButton = document.querySelector(".ModifyLineButton");
    modifyLineButton.click();
    
    //DOM is updating after the .click()
}

function autoCompleter2(shortDescription, reference, price, longDescription){

    const secondTable = document.getElementById("docContents");
    const sDescription = secondTable.querySelector("[tabindex='1']");
    sDescription.value = shortDescription;

    const ref = secondTable.querySelector("[tabindex='2']");
    ref.value = reference;

    const prix = secondTable.querySelector("[tabindex='5']");
    prix.value = price;

    const detailedDesc = document.getElementsByTagName("textarea")[0];
    detailedDesc.value = longDescription;

    const okButton = document.querySelectorAll(".action_grey")[0]; //ok est le premier des deux éléments
    okButton.click();

}


autoCompleter1("Firstname LASTNAME", "Please send the invoice by email to : a@b.com");

autoCompleter2("Course category", "Module Name", "42", "Message to the invoice recipient.");