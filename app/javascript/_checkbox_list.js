document.addEventListener("DOMContentLoaded", function() {
  // Get references to the select-all checkbox and the action button
  const selectAllCheckbox = document.getElementById("select-all");
  const actionButton = document.getElementById("action-button");

  // Get references to all the list-ingredient checkboxes
  const listIngredientCheckboxes = document.querySelectorAll(".list-ingredient-checkbox");

  // Add an event listener to the select-all checkbox that will select or deselect all the list-ingredient checkboxes
  selectAllCheckbox.addEventListener("change", function() {
    const isChecked = selectAllCheckbox.checked;
    listIngredientCheckboxes.forEach(function(checkbox) {
      checkbox.checked = isChecked;
    });
  });

  // Add an event listener to the list-ingredient checkboxes that will enable or disable the action button based on which checkboxes are currently selected
  listIngredientCheckboxes.forEach(function(checkbox) {
    checkbox.addEventListener("change", function() {
      const isChecked = Array.from(listIngredientCheckboxes).some(checkbox => checkbox.checked);
      actionButton.disabled = !isChecked;
    });
  });
});
