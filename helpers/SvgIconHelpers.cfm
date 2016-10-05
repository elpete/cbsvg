<cfscript>

    public string function icon(
        required string iconName,
        string class = "",
        struct attributes = {}
    ) {
        return svgIcon( argumentCollection = arguments ).render();
    }

    public Icon function svgIcon(
        required string iconName,
        string class = "",
        struct attributes = {}
    ) {
        return application.wirebox
            .getInstance( "IconFactory@cbsvg" )
            .getIcon( argumentCollection = arguments );
    }

    public string function svgSpritesheet() {
        return application.wirebox
            .getInstance( "IconFactory@cbsvg" )
            .getSpritesheet();
    }

</cfscript>