$("input.datepicker").datepicker({
  dateFormat: "yy-mm-dd",
  maxDate: 0
}).change(function(e){
  var inputs = $('input.datepicker');

  if ($(this).val() !== "") {
    inputs.attr("required", "required");
  } else {
    inputs.removeAttr("required");
  }

});