## uiContactInfo.R
## App contactInfo tab (client side)
## by Phil Ferriere

menuItemContactInfo = menuItem("Contact Info", tabName = "tabNameContactInfo", icon=icon("envelope-o"))

tabItemContactInfo = tabItem(
  tabName = "tabNameContactInfo",

  fluidRow(column(width = 12, box(width = 12, title = "Contact Info", status = "primary", solidHeader = TRUE,
                                  
    includeMarkdown("uiDocContactInfo.md")

  )))
)
