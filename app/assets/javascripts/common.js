$('input.price').priceFormat({
  prefix: '',
  limit: 10,
  centsLimit: 2,
  clearPrefix: true
});

$('a#myOwnAccountLink').click(function(e){
  e.preventDefault();

  var obj   = $(this),
  agency   = obj.attr('data-agency-number'),
  account  = obj.attr('data-account-number');

  $('input#agency_number').val(agency);
  $('input#account_number').val(account);
});