<div>
    <input id="attribute-{$attribute.id}" data-id="{$attribute.id}" class="form-control" type="text" value="{$attribute.data_text|wash( xhtml )}" />
</div>

<script>
    {literal}
    $(function()
    {
        var savetimer;

        var id = {/literal}{$attribute.id}{literal};

        var instance = $( '#attribute-' + id ).autosaveattribute(
        {
            getData : function()
            {
                return $( '#attribute-' + id ).val();
            },
        });

        $( '#attribute-' + id )
            .keydown( function()
            {
                var textinput = this;

                clearTimeout( savetimer );
                savetimer = setTimeout( function()
                {
                    instance.autosaveattribute( 'save' );
                }, 2000);
            });
    });
    {/literal}
</script>
