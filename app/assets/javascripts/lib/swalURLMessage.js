// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

// If there are success & message query parameters in the URL display Swal
$(function() {
	let success = $.query.get('success').toString() == 'true';
	let message = $.query.get('message').toString();

	if (typeof success !== 'undefined' && typeof message !== 'undefined' && message != '') {
		if (success) {
			alert(message, 'Success', 'success', null, function(response) {
				clearQueryParameter();
			});
		} else {
			alert(message, 'Error', 'error', null, function(response) {
				clearQueryParameter();
			});
		}
	}
});

function clearQueryParameter() {
	var query = $.query;
	query = query.remove('success');
	query = query.remove('message');
	history.replaceState('', '', query.toString());
}
