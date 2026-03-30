document.addEventListener("DOMContentLoaded", function() {
  if (!window.jQuery || !window.jQuery.fn.DataTable) {
    return;
  }

  var table = window.jQuery("#quick-search-table");

  if (!table.length) {
    return;
  }

  table.DataTable({
    pageLength: 10,
    lengthMenu: [10, 25, 50, 100],
    order: [[0, "asc"], [1, "asc"]],
    autoWidth: false,
    language: {
      search: "Search all commands:",
      lengthMenu: "Show _MENU_ commands",
      info: "Showing _START_ to _END_ of _TOTAL_ commands",
      paginate: {
        previous: "Prev",
        next: "Next"
      }
    }
  });
});
