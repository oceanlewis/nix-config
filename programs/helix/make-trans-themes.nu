def main [ themeDir: path ] {
  ls $themeDir
  | get name
  | path parse
  | where extension == "toml"
  | get stem
  | each {|theme|
    {
      $"_($theme)": {
        inherits: $theme
        "ui.background": {}
      }
    }
  }
  | into record
  | to json
}
