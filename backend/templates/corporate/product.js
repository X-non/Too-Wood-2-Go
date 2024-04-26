function addElementToTable () {
    const table = document.getElementById("productTable");
    const newRow = document.createElement("tr");
    newRow.innerHTML = `
        <td><input type="checkbox"></td>
        <td>Arla Mjölk</td>
        <td>Ica väst</td>
        <td>15 kr</td>
        <td>7 kr</td>
        <td>8</td>
        <td></td>
    `;
    table.appendChild(newRow);
};

var modal = document.getElementById("addForm");
var span = document.getElementsByClassName("close")[0];

function displayForm() {
    modal.style.display = "block";
}

span.onclick = function() {
    modal.style.display = "none";
}

function addItem() {
    let product = document.getElementById("product").value;
    document.getElementById("company").value;
    document.getElementById("oldPrice").value;
    document.getElementById("newPrice").value;
    document.getElementById("amount").value;
}