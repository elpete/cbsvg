component {

    function configure() {
        parseParentSettings();
    }

    function onLoad() {
        var helpers = controller.getSetting( "applicationHelper" );
        arrayAppend(
            helpers,
            "#moduleMapping#/helpers/SvgIconHelpers.cfm"
        );
        controller.setSetting( "applicationHelper", helpers );
    }

    function onUnload() {
        controller.setSetting(
            "applicationHelper",
            arrayFilter( controller.getSetting( "applicationHelper" ), function( helper ) {
                return helper != "#moduleMapping#/helpers/SvgIconHelpers.cfm"; 
            } )
        );
    }

    private void function parseParentSettings() {
        var oConfig = controller.getSetting( "ColdBoxConfig" );
        var configStruct = controller.getConfigSettings();
        var cbsvg = oConfig.getPropertyMixin( "cbsvg", "variables", structnew() );

        //defaults
        configStruct.cbsvg = {
            inline = false,
            class = "icon",
            spritePrefix = "",
            spritesheetPath = "/resources/assets/svg/sprite.svg",
            iconPath = "/resources/assets/svg/icons"
        };

        // incorporate settings
        structAppend( configStruct.cbsvg, cbsvg, true );
    }

}