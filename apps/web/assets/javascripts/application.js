// .js-repeatable - container that must include n
// .js-repeatable-block-add-button - a control to add a block
// and .js-rebeatable-block - the block that must be duplicated and appended into the container
// example:
// .js-repeatable
//   .js-repeatable-block-add-button.btn.btn-danger Add
//   .js-rebeatable-block I will be repeated!

document.addEventListener("DOMContentLoaded", function(event) {
  var nestedForms = Array.from(document.getElementsByClassName("js-repeatable"));

  nestedForms.forEach(makeRepeatable);

  function makeRepeatable(container) {
    var addButton = container.getElementsByClassName("js-repeatable-block-add-button")[0]
    addButton.addEventListener("click", function(e) {
      addBlock(e.target.closest(".js-repeatable"));
    }, false);

    var deleteButtons = Array.from(container.getElementsByClassName("js-repeatable-delete-button"));
    deleteButtons.forEach(function(input) {
      input.addEventListener("click", function(e) {
        deleteBlock(e.target.closest(".js-repeatable-block"));
      })
    })
  }

  function addBlock(container) {
    var blocks = Array.from(container.getElementsByClassName("js-repeatable-block"));
    var newNode = createNewNode(blocks);
    container.insertBefore(newNode, blocks[blocks.length - 1].nextSibling);
    newNode.querySelectorAll("input,select")[0].focus();
  }

  function deleteBlock(block) {
    repeatableBlocks = block.closest(".js-repeatable").getElementsByClassName("js-repeatable-block");

    if (repeatableBlocks.length > 1) {
      block.remove();
    }
  }

  function createNewNode(blocks) {
    var firstItemIndex = 0;
    var newItemIndex = blocks.length; // last item index + 1 = (blocks.length - 1) + 1
    var newNode = blocks[firstItemIndex].cloneNode(true);
    Array.from(newNode.querySelectorAll("input,select")).forEach(function(input) {
      input.setAttribute("name", input.name.replace(firstItemIndex, newItemIndex));
      input.setAttribute("id", input.id.replace(firstItemIndex, newItemIndex));
      clearValue(input);
    })

    deleteButton = newNode.getElementsByClassName("js-repeatable-delete-button")[0];
    deleteButton.addEventListener("click", function(e) {
      deleteBlock(e.target.closest(".js-repeatable-block"));
    });
    return newNode;
  }

  function clearValue(input) {
    input.value = '';
    Array.from(input).forEach(function(option) { option.removeAttribute("selected") })
  }
});

document.addEventListener("DOMContentLoaded", function(event) {
  var visibilityToggleArea = Array.from(document.getElementsByClassName("js-visibility-toggle"));

  visibilityToggleArea.forEach(toggleVisibility);

  function toggleVisibility(table) {
    var button = table.getElementsByClassName("js-visibility-toggle-button")[0];

    button.addEventListener("click", function(_e) {
      var visible = Array.from(table.getElementsByClassName("visible"));
      var invisible = Array.from(table.getElementsByClassName("invisible"));

      visible.forEach(function(el) { el.className = el.className.replace("visible", "invisible") })
      invisible.forEach(function(el) { el.className = el.className.replace("invisible", "visible") })
    });
  }
});

document.addEventListener("DOMContentLoaded", function(event) {
  var imperialMetricToggler = document.getElementsByClassName("js-metric-toggler")[0];
  var initialText = imperialMetricToggler.textContent;
  var alternativeText = imperialMetricToggler.dataset.alternativeText;

  imperialMetricToggler.addEventListener("click", function(_e) {
    if (imperialMetricToggler.textContent === alternativeText) {
      imperialMetricToggler.textContent = initialText
    } else {
      imperialMetricToggler.textContent = alternativeText
    };
  })
});
