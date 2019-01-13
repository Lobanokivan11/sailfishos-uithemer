# Custom build

You can change the defaults of UI Themer in your custom build.

## dconf defaults

UI defaults are located in *scripts/sailfishos-uithemer.txt*:

	showEasygui=bool

Show the option to enable/disable the easy mode in the UI.

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

## Post-install scripts

Via a post-install script, it's possible to enable a default theme pre-installed on the device or configure other options:

### Enable an icon theme

	scripts/apply.sh theme 0/1

- *theme* is the name of the theme as in the package (e.g. *numix-circle*).
- *0/1* false/true for the overlay.

### Enable a font theme

	scripts/apply_font.sh theme fontweight

- *theme* is the name of the theme as in the package (e.g. *ibm-plex*).
- *fontweight* the main font weight used throughout the UI (e.g. *Light*).

### Enable the autoupdate service

The autoupdate service refreshes the current icon theme. The options are:

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