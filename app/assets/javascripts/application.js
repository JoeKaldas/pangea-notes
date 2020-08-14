// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require jquery_ujs
//= require lib/jquery-ui.min
//= require popper
//= require bootstrap
//= require activestorage
//= require_tree ./channels
//= require lib/jquery.retryAjax
//= require lib/sweetalert2.min

$(function() {
	// Focus input-group-append on input-focus
	$('.input-group > input')
		.focus(function(e) {
			$(this)
				.parent()
				.addClass('input-group-focus');
		})
		.blur(function(e) {
			$(this)
				.parent()
				.removeClass('input-group-focus');
		});
});

// keep default js alert to use in specific cases
window.legacyAlert = window.alert;

// types alert and confirm: "success", "error", "warning", "info", "question". Default: "warning"
// overwrite default js alert
window.alert = function(msg, title, type, params, cb) {
	var title = title == null ? 'Alert' : title;
	var type = type == null ? 'warning' : type;
	Swal.fire(
		$.extend({
				title: title,
				text: msg,
				icon: type
			},
			params || {}
		)
	).then(result => {
		if (cb) {
			cb(result);
		}
	});
};

// keep default js alert to use in specific cases
window.legacyConfirm = window.confirm;

window.confirm = function(msg, title, type, onConfirm, onCancel, params) {
	var title = title == null ? 'Confirm' : title;
	var type = type == null ? 'warning' : type;
	Swal.fire(
		$.extend({
				title: title,
				text: msg,
				icon: type,
				showCancelButton: true,
				allowEscapeKey: false,
				allowOutsideClick: false
			},
			params || {}
		)
	).then(
		function(isConfirm) {
			if (isConfirm && isConfirm.value && onConfirm instanceof Function) {
				onConfirm();
			}
		},
		function(dismiss) {
			if (dismiss === 'cancel' && onCancel instanceof Function) {
				onCancel();
			}
		}
	);
};

$.rails.allowAction = function(link) {
	if (link.data('confirm') == undefined) {
		return true;
	}
	$.rails.showConfirmationDialog(link);
	return false;
};

$.rails.showConfirmationDialog = function(link) {
	var message = link.data('confirm');
	Swal.fire({
		title: 'Confirm',
		text: message,
		icon: 'warning',
		showCancelButton: true
	}).then(function(e) {
		if (e.value == true) {
			$.rails.confirmed(link);
		}
	});
};

$.rails.confirmed = function(link) {
	link.data('confirm', null);
	link.trigger('click.rails');
};