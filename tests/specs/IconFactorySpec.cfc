component extends="testbox.system.BaseSpec" {

    function run() {
        describe( "Icon Factory", function() {
            beforeEach( function() {
                variables.factory = getMockBox().createMock( "models.IconFactory" );
                
                variables.defaultConfig = {
                    inline = false,
                    class = "icon",
                    spritePrefix = "",
                    spritesheetPath = "/tests/specs/resources/sprite.svg",
                    iconPath = "/tests/specs/resources/icons"
                };
                factory.$property( propertyName = "config", mock = defaultConfig );

                variables.mockIcon = getMockBox().createMock( "models.Icon" );
                variables.mockWireBox = getMockBox().createStub().$( "getInstance", mockIcon );
                factory.$property( propertyName = "wirebox", mock = mockWireBox );
            } );

            afterEach( function() {
                structDelete( variables, "factory" );
                structDelete( variables, "defaultConfig" );
                structDelete( variables, "mockIcon" );
                structDelete( variables, "mockWireBox" );
            } );

            it( "renders icons from a spritesheet by default", function() {
                var icon = factory.getIcon( "arrow-thick-up" );
                var actual = '<svg class="icon"><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="/tests/specs/resources/sprite.svg##arrow-thick-up"></use></svg>';
                expect( icon.render() ).toBe( actual );
            } );

            it( "gives icons the icon class by default", function() {
                var icon = factory.getIcon( "arrow-thick-up" );
                expect( icon.$getProperty( "attributes" ).class ).toInclude( "icon" );
            } );

            it( "can render inline icons", function() {
                var inlineConfig = { inline = true };
                structAppend( inlineConfig, defaultConfig, false );
                factory.$property( propertyName = "config", mock = inlineConfig );
                var icon = factory.getIcon( "arrow-thick-up" );
                var expected = '<svg class="icon"  viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path d="M7 10v8h6v-8h5l-8-8-8 8h5z" fill-rule="evenodd"/></svg>';
                expect( icon.render() ).toBe( expected );
            } );

            it( "can render icons with additional classes", function() {
                var icon = factory.getIcon( "arrow-thick-up", "icon-lg" );
                expect( icon.$getProperty( "attributes" ).class )
                    .toInclude( "icon" )
                    .toInclude( "icon-lg" );
            } );

            it( "can accept additional attributes as a struct", function() {
                var icon = factory.getIcon( iconName = "arrow-thick-up", attributes = {
                    alt = "test",
                    id = "arrow-icon"
                } );
                var attributes = icon.$getProperty( "attributes" );
                expect( attributes )
                    .toHaveKey( "alt" )
                    .toHaveKey( "id" );

                expect( attributes.alt ).toBe( "test" );
                expect( attributes.id ).toBe( "arrow-icon" );
            } );

            it( "sets attributes with blank values as valueless html attributes", function() {
                var icon = factory.getIcon( iconName = "arrow-thick-up", attributes = {
                    alt = "test",
                    "data-foo" = ""
                } );
                expect( icon.render() ).toInclude( 'alt="test"' );
                expect( icon.render() ).toInclude( 'data-foo' );
            } );

            it( "overrides the default class when setting class as an attribute", function() {
                var icon = factory.getIcon( iconName = "arrow-thick-up", attributes = {
                    class = "foo"
                } );
                var expected = '<svg class="foo"><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="/tests/specs/resources/sprite.svg##arrow-thick-up"></use></svg>';
                expect( icon.render() ).toBe( expected );
            } );

            it( "can chain additional attributes", function() {
                var icon = factory.getIcon( "arrow-thick-up" ).alt( "Alt text" ).id( 
                    "arrow-icon" );
                expect( icon.render() ).toInclude( 'alt="Alt text"' );
                expect( icon.render() ).toInclude( 'id="arrow-icon"' );
            } );

            it( "converts camelCased attributes to dash-cased when chaining", function() {
                var icon = factory.getIcon( "arrow-thick-up" ).dataFoo( "bar" ).dataBaz();
                expect( icon.render() ).toInclude( 'data-baz' );
                expect( icon.render() ).toInclude( 'data-foo="bar"' );
            } );

            it( "can force an icon to render inline", function() {
                var icon = factory.getIcon( "arrow-thick-up" ).inline();
                var expected = '<svg class="icon"  viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path d="M7 10v8h6v-8h5l-8-8-8 8h5z" fill-rule="evenodd"/></svg>';
                expect( icon.render() ).toBe( expected );
            } );

            it( "can force an icon to render from a spritesheet", function() {
                var inlineConfig = { inline = true };
                structAppend( inlineConfig, defaultConfig, false );
                factory.$property( propertyName = "config", mock = inlineConfig );

                var icon = factory.getIcon( "arrow-thick-up" ).sprite();
                var expected = '<svg class="icon"><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="/tests/specs/resources/sprite.svg##arrow-thick-up"></use></svg>';
                expect( icon.render() ).toBe( expected );
            } );

            it( "can add an id prefix for sprited icons", function() {
                var inlineConfig = { spritePrefix = "icon--" };
                structAppend( inlineConfig, defaultConfig, false );
                factory.$property( propertyName = "config", mock = inlineConfig );

                var icon = factory.getIcon( "arrow-thick-up" );
                var expected = '<svg class="icon"><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="/tests/specs/resources/sprite.svg##icon--arrow-thick-up"></use></svg>';
                expect( icon.render() ).toBe( expected );
            } );
        } );
    }

}