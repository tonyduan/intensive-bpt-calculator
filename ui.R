library(shiny)

shinyUI(navbarPage(title="Navigation", theme = "style.css",
                   windowTitle = "Intensive BP Therapy ARR Calculator",
  tabPanel("HTE Calculator", fluidPage(
    fluidRow(
      column(3,
             numericInput("age", label = "Age (years)", value = 65),
             selectInput("sex", label = "Sex", choices = list(Male = 0, Female = 1)),
             radioButtons("black", label = "Black?", choices = list(No=0, Yes=1), inline = TRUE),
             radioButtons("hisp", label = "Hispanic?", choices = list(No=0, Yes=1), inline = TRUE)
      ),
      column(3,
             numericInput("sysbp", label = "Systolic blood pressure (mm Hg)", value = 140),
             numericInput("diabp", label = "Diatolic blood pressure (mm Hg)", value = 80),
             numericInput("totchol", label = "Total cholesterol (mg/dL)", value = 190),
             numericInput("hdlchol", label = "HDL cholesterol (mg/dL)", value = 50)
      ),
      column(3,
             numericInput("screat", label = "Serum creatinine (mg/dL)", value = 1.2),
             numericInput("trr", label = "Triglycerides (mg/dL)", value = 150),
             numericInput("bmi", label = "Body mass index (kg/m^2)", value = 35),
             numericInput("n_agents", label = "Number of BP treatment classes", value = 2)
      ),
      column(3,
             radioButtons("cursmoke", label = "Currently smoking tobacco?", choices = list(No=0, Yes=1), inline = TRUE),
             radioButtons("formersmoke", label = "Formerly smoking tobacco?", choices = list(No=0, Yes=1), inline = TRUE),
             radioButtons("aspirin", label = "Currently on aspirin?", choices = list(No=0, Yes=1), inline = TRUE),
             radioButtons("statin", label = "Currently on statin?", choices = list(No=0, Yes=1), inline = TRUE),
             radioButtons("diabetes", label = "Has diabetes?", choices = list(No=0, Yes=1), inline = TRUE)
      )
    ),

    hr(),

    fluidRow(
      column(8,
          h4("Estimated 3-year ARR of intensive (< 120 mm Hg) versus standard (< 140 mm Hg) BP therapy:", align = "center")
      ),
      column(4,
          h4(textOutput("pred_arr")), align = "center"
      )
    ),
    hr(),
    "Note: This calculator is intended for informational purposes only, and has not been prospectively
     evaluated for impact on clinical practice or patient outcomes. Calculations must be re-checked and
     should not be used alone to guide patient care, nor should they substitute for clinical judgment.
     Contact: Tony Duan, tonyduan@cs.stanford.edu; Sanjay Basu, basus@stanford.edu."

  )),
  tabPanel("Summary Statistics", fluidPage(

    h4("Summary Statistics"),

    fluidRow(column(12, dataTableOutput("summary")))

  )),
  tabPanel("Disclaimers", fluidPage(
      h4("Disclaimers"),
      p("This website contains clinical tools and data intended for use by healthcare professionals. These tools do not give professional advice; physicians and other healthcare professionals who use these tools or data should exercise their own clinical judgment as to the information they provide. Consumers who use the tools or data do so at their own risk. Individuals with any type of medical condition are specifically cautioned to seek professional medical advice before beginning any sort of health treatment. For medical concerns, including decisions about medications and other treatments, users should always consult their physician or other qualified healthcare professional.
         Our content developers have carefully tried to create its content to conform to the standards of professional practice that prevailed at the time of development. However, standards and practices in medicine change as new data become available and the individual medical professional should consult a variety of sources.
         The contents of the Site, such as text, graphics and images are for informational purposes only. We do not recommend or endorse any specific tests, physicians, products, procedures, opinions, or other information that may be mentioned on the Site.
         While information on this site has been obtained from sources believed to be reliable, neither we nor our content providers warrant the accuracy of the information contained on this site.
         We do not give medical advice, nor do we provide medical or diagnostic services. Medical information changes rapidly. Neither we nor our content providers guarantee that the content covers all possible uses, directions, precautions, drug interactions, or adverse effects that may be associated with any therapeutic treatments.
         Your reliance upon information and content obtained by you at or through this site is solely at your own risk. Neither we nor our content providers assume any liability or responsibility for damage or injury (including death) to you, other persons or property arising from any use of any product, information, idea or instruction contained in the content or services provided to you.
         We cannot and will not be held legally, financially, or medically responsible for decisions made using these calculators, equations, and algorithms, and this Site is for the use of medical professionals only."),
      p("The calculations and website shown here were prepared using ACCORD and SPRINT research materials obtained from the NHLBI Biologic Specimen and Data Repository Information Coordinating Center. The calculations and content on this Site do not necessary reflect the opinions or views of the ACCORD SPRINT, or NHLBI."),
      p("Financial support for this calculator and website and its related materials was provided in part by grants from the National Heart, Lung and Blood Institute of the National Institutes of Health under Award Numbers R01HL144555 and R21MD012867. The content is solely the responsibility of the authors and does not necessarily represent the official views of the National Institutes of Health.")
  ))
))
