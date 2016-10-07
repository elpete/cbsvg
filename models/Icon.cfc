component accessors="true" {

    property name="iconName";
    property name="attributes";
    property name="renderMode";
    property name="factory";


    public string function render() {
        if ( getRenderMode() == "inline" ) {
            return renderInline();
        }

        return renderFromSprite();
    }

    public Icon function inline() {
        variables.renderMode = "inline";

        return this;
    }

    public Icon function sprite() {
        variables.renderMode = "sprite";

        return this;
    }

    private string function renderInline() {
        return replace(
            getFactory().getSvg( getIconName() ),
            "<svg",
            "<svg #renderAttributes()# "
        );
    }

    private string function renderFromSprite() {
        return '<svg #renderAttributes()#><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#getFactory().getSpritesheetPath()####getFactory().getSpriteId( getIconName() )#"></use></svg>';
    }

    private string function renderAttributes() {
        var formattedAttrs = [];
        var attrs = getAttributes();
        for( var key in attrs ) {
            var value = attrs[ key ];
            if ( value == "" ) {
                var attr = camelToDash( key );
            }
            else {
                var attr = '#camelToDash( key )#="#value#"';
            }
            arrayAppend( formattedAttrs, attr );
        }
        return arrayToList( formattedAttrs, " " );
    }

    private Icon function addAttribute( key, value ) {
        var attrs = getAttributes();
        structAppend( attrs, { "#key#" = value }, true );
        setAttributes( attrs );

        return this;
    }

    function onMissingMethod( missingMethodName, missingMethodArguments ) {
        if ( arrayIsEmpty( missingMethodArguments ) ) {
            return addAttribute( missingMethodName, "" );
        }
        return addAttribute( missingMethodName, missingMethodArguments[1] );
    }

    /**
     * Converts a camelCased string into dash-case
     */
    private string function camelToDash( required string str ) {
        return trim(
            lcase( reReplace( arguments.str, "([A-Z])([a-z])", "-\1\2", "ALL" ) )
        );
    }

}