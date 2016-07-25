$(function()
{
	$( '.ui-button.ui-state-default' )
		.addClass( 'btn-default' )
		.removeClass( 'ui-state-default' );

	$( '.ui-button' )
		.addClass( 'btn' )
		.removeClass( 'ui-button' );

	$( 'input.button' )
		.addClass( 'btn' )
		.addClass( 'btn-default' )
		.removeClass( 'button' );

	$( 'input.defaultbutton' )
		.addClass( 'btn' )
		.addClass( 'btn-primary' )
		.removeClass( 'button' );

	$( 'form input:not( .btn )' )
		.addClass( 'form-control' );
	//form-group
});