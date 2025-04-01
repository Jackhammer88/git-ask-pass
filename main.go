package main

import (
	_ "embed"
	"fmt"
	"os"
	"strings"

	"fyne.io/fyne/v2"
	"fyne.io/fyne/v2/app"
	"fyne.io/fyne/v2/container"
	"fyne.io/fyne/v2/data/binding"
	"fyne.io/fyne/v2/layout"
	"fyne.io/fyne/v2/theme"
	"fyne.io/fyne/v2/widget"
)

//go:embed assets/app-icon.png
var iconData []byte

func main() {
	if len(os.Args) <= 1 {
		os.Exit(1)
	}

	app := app.New()
	app.SetIcon(fyne.NewStaticResource("icon.png", iconData))
	window := app.NewWindow("Авторизация")
	prompt := os.Args[1]

	var input *widget.Entry

	if strings.Contains(prompt, "Password") {
		input = widget.NewPasswordEntry()
	} else {
		input = widget.NewEntry()
	}

	label := widget.NewLabel(prompt)

	okButton := &widget.Button{
		Importance: widget.HighImportance,
		Text:       "OK",
		Icon:       theme.ConfirmIcon(),
		OnTapped: func() {
			writeAppResponse(input.Text)
		},
	}
	okButton.Disable()
	cancelButton := widget.NewButtonWithIcon("Отмена", theme.CancelIcon(),
		func() {
			os.Exit(1)
		})
	buttonContainer := container.NewHBox(layout.NewSpacer(), okButton, cancelButton)

	stringBinding := binding.NewString()
	input.Bind(stringBinding)
	stringBinding.AddListener(binding.NewDataListener(func() {
		text, err := stringBinding.Get()
		if err != nil {
			logError("stringBinding datalistener", err)
			return
		}
		if text == "" {
			okButton.Disable()
		} else {
			okButton.Enable()
		}
	}))

	input.OnSubmitted = func(text string) {
		if text == "" {
			return
		}

		writeAppResponse(text)
	}

	content := container.NewVBox(label, input, buttonContainer)

	window.Resize(fyne.Size{
		Width:  300,
		Height: 120,
	})
	window.SetContent(content)
	window.Canvas().Focus(input)
	window.ShowAndRun()
}

func logError(context string, err error) {
	fmt.Fprintf(os.Stderr, "[%s] %v\n", context, err)
}

func writeAppResponse(text string) {
	fmt.Printf("%s\n", text)
	os.Exit(0)
}
