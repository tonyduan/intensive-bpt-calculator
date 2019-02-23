library(shiny)
library(ranger)


xf0 = readRDS("ckpts/xf0.rds")
xf1 = readRDS("ckpts/xf1.rds")

column_names = paste("x", seq(0, 16), sep = "")


shinyServer(function(input, output) {


    pred_arr = reactive({

        patient = c(input$age, as.numeric(input$sex), as.numeric(input$black),
                    as.numeric(input$hisp), input$sysbp, input$diabp,
                    input$n_agents, as.numeric(input$cursmoke),
                    as.numeric(input$formersmoke), as.numeric(input$aspirin),
                    as.numeric(input$statin),
                    input$screat, input$totchol, input$hdlchol, input$trr,
                    input$bmi, as.numeric(input$diabetes))
        patient = matrix(patient, nrow = 1)
        colnames(patient) = column_names
        pred_0 = 0.5 * predict(xf0, patient)$predictions[1]
        pred_1 = 0.5 * predict(xf1, patient)$predictions[1]
        pred = pred_0 + pred_1
        rm(patient)
        return(paste(round(-pred * 100, 2), "%", sep=""))
    })

    output$summary = renderDataTable({
        rows = c("Age (years)", "Female (%)", "Black (%)", "Hispanic (%)",
                 "Systolic blood pressure (mm Hg)",
                 "Diastolic blood pressure (mm Hg)",
                 "Number of blood pressure treatment classes", "Current Smoker",
                 "Former Smoker", "Aspirin use", "Statin use",
                 "Serum creatinine (mg/dL)",
                 "Total cholesterol (mg/dL)",
                 "High-density lipoprotein cholesterol (mg/dL)",
                 "Triglycerides (mg/dL)", "Body mass index (kg/m^2)")
        sprint = c("67.84 (9.40)",
                   "0.35 (0.48)",
                   "0.32 (0.46)",
                   "0.11 (0.31)",
                   "139.65 (15.59)",
                   "78.16 (11.92)",
                   "1.84 (1.04)",
                   "0.13 (0.34)",
                   "0.43 (0.49)",
                   "0.51 (0.50)",
                   "0.44 (0.50)",
                   "1.07 (0.34)",
                   "190.10 (41.22)",
                   "52.82 (14.45)",
                   "126.13 (90.29)",
                   "29.87 (5.76)")
        accord = c("63.19 (6.68)",
                   "0.49 (0.50)",
                   "0.24 (0.42)",
                   "0.07 (0.26)",
                   "139.62 (15.75)",
                   "75.94 (10.34)",
                   "1.70 (1.08)",
                   "0.01 (0.10)",
                   "0.48 (0.50)",
                   "0.52 (0.50)",
                   "0.65 (0.48)",
                   "0.91 (0.25)",
                   "192.88 (43.77)",
                   "46.74 (13.50)",
                   "186.86 (164.58)",
                   "32.23 (5.46)")
        table = data.frame(rows, sprint, accord)
        colnames(table) = c("",
                            "In SPRINT (N = 9,361), Mean (SD)",
                            "In ACCORD-BP (N = 4,733), Mean (SD)")
        table
    }, options = list(searching = FALSE, paging = FALSE))

    output$pred_arr = renderText(pred_arr())

})
