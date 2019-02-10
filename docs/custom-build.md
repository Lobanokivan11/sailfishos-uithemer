# Custom build

You can change the defaults of UI Themer in your custom build.

## dconf defaults

UI defaults are located in *scripts/sailfishos-uithemer.txt*:

	showGuimode=bool

Show the option to enable/disable the different UI modes in the UI.

	guimode=int

Different UI modes:

- *0* easy: less options and hassle-free experience.
- *1* full: full control of the app settings.
- *2* developer: enable theme developers-tailored options.

	showDensity=bool

Show the display density settings in the UI.

	easygui=bool

Enable/disable the easy mode.

	wizardDone=bool

Enable/disable the first-run wizard.

	coverAction1=int

Main cover action:
- *0* refresh icon theme.
- *1* restart homescreen.
- *2* one-click restore.
- *3* disabled.

	coverAction2=int

(optional) Second cover action:
- *0* refresh icon theme.
- *1* restart homescreen.
- *2* one-click restore.
- *3* disabled.

	coverActiveTheme=bool

Enable/disable active theme showing on the cover.

## Post-install scripts

Via a post-install script, it's possible to enable a default theme pre-installed on the device or configure other options:

### Enable an icon theme

	scripts/apply.sh theme 0/1
	dconf write /desktop/lipstick/sailfishos-uithemer/activeIconPack "'theme'"

- *theme* is the name of the theme as in the package (e.g. *numix-circle*).
- *0/1* false/true for the overlay.

### Enable a font theme

	scripts/apply_font.sh theme fontweight
	dconf write /desktop/lipstick/sailfishos-uithemer/activeFontPack "'theme'"

- *theme* is the name of the theme as in the package (e.g. *ibm-plex*).
- *fontweight* the main font weight used throughout the UI (e.g. *Light*).

### Enable the auto-update service

The auto-update service refreshes the current icon theme. The options are:

#### 30 minutes

	scripts/apply_hours.sh 30
	dconf write /desktop/lipstick/sailfishos-uithemer/autoUpdate 1

#### 1 hour

	scripts/apply_hours.sh 1
	dconf write /desktop/lipstick/sailfishos-uithemer/autoUpdate 2

#### 2 hours

	scripts/apply_hours.sh 2
	dconf write /desktop/lipstick/sailfishos-uithemer/autoUpdate 3

#### 3 hours

	scripts/apply_hours.sh 3
	dconf write /desktop/lipstick/sailfishos-uithemer/autoUpdate 4

#### 6 hours

	scripts/apply_hours.sh 6
	dconf write /desktop/lipstick/sailfishos-uithemer/autoUpdate 5

#### 12 hours

	scripts/apply_hours.sh 12
	dconf write /desktop/lipstick/sailfishos-uithemer/autoUpdate 6

#### Daily

	scripts/apply_hours.sh hh:mm
	dconf write /desktop/lipstick/sailfishos-uithemer/autoUpdate 7

## Further customization

If you need futher customization options [open an issue](https://github.com/fravaccaro/sailfishos-uithemer/issues).