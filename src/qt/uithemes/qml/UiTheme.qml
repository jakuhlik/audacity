pragma Singleton
import QtQml

import Audacity.UiThemes

Theme {
   id: root
   objectName: "UiTheme"

   property var themes: []
   property string currentTheme: ""

   property font bodyFont
   property font iconFont
   property font timecodeFont

   signal themeChanged()

   function availableThemes() {
      var names = []

      for (var i = 0; i < themes.length; i++) {
         names.push(themes[i].objectName)
      }

      return names
   }

   function changeTheme(theme) {
      if (currentTheme === theme) {
         return
      }

      for (var i = 0; i < themes.length; i++) {
         if (themes[i].objectName === theme) {
            root.backgroundColor1 = themes[i].backgroundColor1
            root.backgroundColor2 = themes[i].backgroundColor2
            root.backgroundColor3 = themes[i].backgroundColor3
            root.backgroundColor4 = themes[i].backgroundColor4
            root.fontColor1 = themes[i].fontColor1
            root.fontColor2 = themes[i].fontColor2
            root.buttonColor = themes[i].buttonColor
            root.brandColor = themes[i].brandColor
            root.textFieldColor = themes[i].textFieldColor
            root.successColor = themes[i].successColor
            root.dangerColor = themes[i].dangerColor
            root.strokeColor1 = themes[i].strokeColor1
            root.strokeColor2 = themes[i].strokeColor2
            root.strokeColor3 = themes[i].strokeColor3
            root.waveformRMSColor = themes[i].waveformRMSColor
            root.waveformHighlightColor = themes[i].waveformHighlightColor
            root.waveformPeakColor = themes[i].waveformPeakColor
            root.clipStrokeColor = themes[i].clipStrokeColor
            root.clipHeaderColor = themes[i].clipHeaderColor
            root.textHighlightColor = themes[i].textHighlightColor
            root.invalidInputColor = themes[i].invalidInputColor
            root.currentTheme = themes[i].objectName
            root.themeChanged()
            break
         }
      }
   }

   Component.onCompleted: {
      var themeFiles = UiThemeHandler.themeFiles()

      bodyFont = UiThemeHandler.bodyFont
      iconFont = UiThemeHandler.iconFont
      timecodeFont = UiThemeHandler.timecodeFont

      for (var i = 0; i < themeFiles.length; i++) {
         var component = Qt.createComponent(themeFiles[i]);
         var theme = component.createObject()
         themes.push(theme)
      }

      if (themes.length === 0) {
         console.exception("No themes found")
         return
      }

      changeTheme(themes[0].objectName)
   }
}