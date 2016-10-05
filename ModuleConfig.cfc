component {

    function configure() {
        parseParentSettings();

        var helpers = controller.getSetting( "applicationHelper" );
        arrayAppend(
            helpers,
            "#moduleMapping#/helpers/SvgIconHelpers.cfm"
        );
        controller.setSetting( "applicationHelper", helpers );
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