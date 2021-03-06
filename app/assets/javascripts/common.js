$('input.price').priceFormat({
  prefix: '',
  limit: 10,
  thousandsSeparator: '',
  centsLimit: 2,
  clearPrefix: true
});

$('a#myOwnAccountLink').click(function(e){
  e.preventDefault();

  var obj   = $(this),
  agency   = obj.attr('data-account-agency'),
  account  = obj.attr('data-account-number');

  $('input#account_agency').val(agency);
  $('input#account_number').val(account);
});

// Activating popover functionality.
$("[rel='popover']").popover();