// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

//= require lib/datatables

$(document).ready(function() {
	var table = $('#notes-table').DataTable({
		"order": [
			[1, "desc"]
		],
		"processing": true,
		"serverSide": true,
		"ajax": {
			"url": $('#notes-table').data('source'),
			"data": {}
		},
		"pagingType": "full_numbers",
		"columns": [{
			"data": "id"
		}, {
			"data": "created_at"
		}, {
			"data": "title"
		}, {
			"data": "body"
		}, {
			"data": "short_body"
		}, {
			"data": "actions"
		}],
		"columnDefs": [{
			"targets": 'no-sort',
			"orderable": false,
		}, {
			"targets": [3],
			"visible": false
		}, ],
	});

	table.on('draw', function() {
		$('[data-toggle="tooltip"]').tooltip();
	});
});