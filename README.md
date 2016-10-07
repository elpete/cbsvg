# cbsvg

[![Master Branch Build Status](https://img.shields.io/travis/elpete/cbsvg/master.svg?label=master
)](https://travis-ci.org/coldbox-elixir/core) [![Development Branch Build Status](https://img.shields.io/travis/elpete/cbsvg/development.svg?label=development
)](https://travis-ci.org/coldbox-elixir/core)

## Installation

`box install cbsvg`

## Basic Usage

### Icon

Use the `icon()` helper function to include an icon anywhere in your layouts or views.

```html
<a href="/profile">
	#icon( "user" )# Profile
</a>

<!-- Renders -->
<a href="/profile">
	<svg class="icon">
        <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#user"></use>
    </svg>
    Profile
</a>
```

Include additional classes as the second parameter.

```html
<a href="/profile">
	#icon( "user", "icon-lg" )# Profile
</a>

<!-- Renders -->
<a href="/profile">
	<svg class="icon icon-lg">
        <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#user"></use>
    </svg>
    Profile
</a>
```

Include custom attributes as the third parameter.

```html
<a href="/profile">
	#icon( "user", "icon-lg", { "alt" = "user profile icon"} )# Profile
</a>

<!-- Renders -->
<a href="/profile">
	<svg class="icon icon-lg" alt="user profile icon">
        <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#user"></use>
    </svg>
    Profile
</a>
```

### svgIcon

Use the `svgIcon()` helper function to get an instance of the `Icon` component back.
Use a fluent syntax to set custom attributes on the icon before rendering.
Call `render()` to get the svg string back.

```html
<a href="/profile">
	#svgIcon( "user" ).alt( "user profile icon" ).dataFoo( "bar" ).dataBaz().render()# Profile
</a>

<!-- Renders -->
<a href="/profile">
	<svg class="icon" alt="user-profile-icon" data-foo="bar" data-baz>
        <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#user"></use>
    </svg>
    Profile
</a>
```

User the `inline()` or `sprite()` methods to force an icon's rendering.

```html
<a href="/profile">
    #svgIcon( "user" ).inline().render()# Profile
</a>

<!-- Renders.. -->
<a href="/profile">
    <svg class="icon" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
        <path d="M3.938 6.497a6.958 6.958 0 0 0-.702 1.694L0 9v2l3.236.809c.16.6.398 1.169.702 1.694l-1.716 2.861 1.414 1.414 2.86-1.716a6.958 6.958 0 0 0 1.695.702L9 20h2l.809-3.236a6.96 6.96 0 0 0 1.694-.702l2.861 1.716 1.414-1.414-1.716-2.86a6.958 6.958 0 0 0 .702-1.695L20 11V9l-3.236-.809a6.958 6.958 0 0 0-.702-1.694l1.716-2.861-1.414-1.414-2.86 1.716a6.958 6.958 0 0 0-1.695-.702L11 0H9l-.809 3.236a6.96 6.96 0 0 0-1.694.702L3.636 2.222 2.222 3.636l1.716 2.86zM10 13a3 3 0 1 0 0-6 3 3 0 0 0 0 6z" fill-rule="evenodd">
        </path>
    </svg>
    Profile
</a>
```

## Config

Set configuration options inside your `config/ColdBox.cfc` using a `cbsvg` struct.

```cfc
// defaults
cbsvg = {
    inline = false,
    class = "icon",
    spritePrefix = "",
    spritesheetPath = "/resources/assets/svg/sprite.svg",
    iconPath = "/resources/assets/svg/icons"
};
```

## Credits

This package was adapted for CFML from [Adam Wathan's](https://adamwathan.me/) [blade-svg](https://github.com/adamwathan/blade-svg) package for Laravel.
