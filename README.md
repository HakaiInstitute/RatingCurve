# RatingCurve
Calculate and plot stream stage-discharge rating curves using LOESS regression.

By Maartje Korver

This repository includes two Rmarkdown scripts (sourcing multiple R scripts) that were written for the calculation of stage-discharge rating curves for the stream gauging stations of the Hakai Institute.

**QH_data_assessment.Rmd** creates a document that will help to assess rating curve shifts and outlier data.

**Rating_curve.Rmd** plots the rating curve using LOESS regression, extrapolates the curve to maximum and minimum stage recorded and calculates Confidence Intervals (method by Coxon et al., 2015).

See **RatingCurve_manual.pptx** for an explanantion and tutorial on the RatingCurve scripts. 
