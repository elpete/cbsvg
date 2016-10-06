component {

    property name="wirebox" inject="wirebox";
    property name="config" inject="coldbox:setting:cbsvg";

    variables.svgCache = {};

    public string function getSvg( required string iconName ) {
        if ( ! structKeyExists( variables.svgCache, iconName ) ) {
            var icon = fileRead( "#config.iconPath#/#iconName#.svg" );
            variables.svgCache[ iconName ] = icon;
        }

        return variables.svgCache[ iconName ];
    }

    public string function getSpriteId( required string iconName ) {
        return "#config.spritePrefix##iconName#";
    }

    public Icon function getIcon(
        required string iconName,
        string class = "",
        struct attributes = {}
    ) {
        var attrs = { "class" = buildClass( class ) };
        structAppend( attrs, attributes, true );

        var icon = wirebox.getInstance( "Icon@cbsvg" );
        icon.setIconName( iconName );
        icon.setFactory( this );
        icon.setAttributes( attrs );
        icon.setRenderMode( getRenderMode() );
        return icon;
    }

    private string function getRenderMode() {
        return config.inline ? "inline" : "sprite";
    }

    private string function buildClass( required string class ) {
        return trim( "#config.class# #class#" );
    }

}