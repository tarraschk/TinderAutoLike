$(document).ready ->
  $('table.table-admin-users tbody tr').click ->
    window.location = $(this).attr('href')
    return false
