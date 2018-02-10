$(document).ready(function() {
	
	$("#dadoscliente").tabs();
	$(".multiselect").multiselect();
	
	// Formulários
	$("input:text, input:checkbox, input:radio, input:file, textarea, select").uniform();
	$("input:submit, input:reset").button();
	$("input.data").datepicker();
	$("input.cpf").mask("999.999.999-99");
	$("input.telefone").mask("(99) 9999-9999");
	
	// CKEditor
	$( 'textarea.editor' ).ckeditor(function() {}, { skin : 'kama', toolbar: 'Basic' });
	
	// Tabelas
	$('.tabela').dataTable({
		"bJQueryUI": true,
		"bInfo": false,
		"bLengthChange": false,
		"sPaginationType": "full_numbers",
		"aoColumnDefs": [ 
			{ "bSortable": true, "aTargets": [ 0 ] }
		],
		"oLanguage": {
			"sLengthMenu": "Mostrar _MENU_ por página",
			"sZeroRecords": "Nada encontrado",
			"sInfo": "Mostrando _START_ até _END_ de _TOTAL_ itens",
			"sInfoEmpty": "Mostrando 0 itens",
			"sInfoFiltered": "(de um total de _MAX_ itens)",
			"sSearch": "Busca: ",
			"oPaginate": {
				"sFirst": "Primeira",
				"sLast": "Última",
				"sNext": "Próxima",
				"sPrevious": "Anterior"
			}
		}
	});
	
	// Calendário
	var date = new Date();
		var d = date.getDate();
		var m = date.getMonth();
		var y = date.getFullYear();
		
		$('#calendario').fullCalendar({
			theme: true,
			header: {
				left: 'prev,next today',
				center: 'title',
				right: 'month,agendaWeek,agendaDay'
			},
			editable: true,
		});
});
