% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/initFlowBased.R
\name{initFlowBased}
\alias{initFlowBased}
\title{Initialization of the Antares flow-based study}
\usage{
initFlowBased(fb_opts = antaresFlowbased::fbOptions()$path,
  opts = antaresRead::simOptions(), scenarios = rep(1:200, times = 5))
}
\arguments{
\item{fb_opts}{\code{list} of flowbased parameters (flow-based model directory) returned by the function \link{setFlowbasedPath}. 
By default, the value is indicated by \code{antaresFlowbased::fbOptions()}}

\item{opts}{\code{list} of simulation parameters returned by the function \link{setSimulationPath}, Antares study. By default, the value is 
indicated by \code{antaresRead::simOptions()}}

\item{scenarios}{\code{numeric} vector, it represents the flow-based scenarios builder. It will be written in the file scenario.txt and used by 
Antares to combine Antares time series (the scenarios builder) and the flow-based time series. By default, the value is \code{rep(1:200, times = 5)}
 (1000 mcYears, with 200 time series repeated 5 times)}
}
\description{
This function initializes the environment for a flow-based study. The study must be of Antares version equal or higher to 6.1.3 to enable binding 
constraints on thermal clusters.
\itemize{
 \item{
It creates a folder containing the description of the typical 
flow-based days (files created with the function \link{computeFB}), the flow-based time-series consistent with the study inputs (calculated by 
the function \link{createFBTS}), a scenario playlist to combine the flow-based time-series and Antares scenario builder and information 
about the model and time of creation of the folder. This folder will then be used to run the simulation and afterwards by all the functions 
acting on the outputs (post-processing, plots ...). Be careful to keep the consistency between the model loaded by \code{initFlowBased} and the one
 used for running previous simulations.}
 \item{
 It writes the 36 binding constraints representing the flow-based domains, with the weight files being the coefficients of the constraints and the
  second members converted into availability time series of virtual power plants (= the combination weights x links < thermal availability)
 }
}
}
\note{
The folder designed by by fb_opts is a flow-based model. It must include the following files :

\itemize{
  \item{domainesFB.RDS : RDS file created by \link{computeFB}, information on the conversion from real to modelled domain}
  \item{second_member.txt : text file created by \link{computeFB}, representing the second members (or margins) in the constraints. It includes
  the following columns :
  \itemize{
    \item{Id_day : numeric, from 1 to the number of typical days}
    \item{Id_hour : numeric, from 1 to 24}
    \item{vect_b : numeric, second member in MW}
    \item{Name : character, name of the constraint, generally "FBnumber"}
   }
  }
  
  \item{ts.txt: text file created by \link{createFBTS}, flow-based typical day time series with
  \itemize{
    \item{First colum : dates, format : YYYY-MM-DD}
    \item{First row : names of the time series, "number"}
    \item{cells : numeric (typival day ID)}
   }
  }
  
  \item{weigth.txt : text file representing the weights of the binding constraints. It includes the following columns :
  \itemize{
    \item{Name : character, name of the contraints, matching the chosen name in the second member file}
    \item{BE.FR : numeric coefficient on the link from Belgium to France, between -1 and 1}
    \item{DE.FR : numeric coefficient on the link from Germany to France, between -1 and 1}
    \item{DE.NL : numeric coefficient on the link from Germany to The Netherlands, between -1 and 1}
    \item{BE.NL : numeric coefficient on the link from Belgium to The Netherlands, between -1 and 1}
    \item{BE.DE : numeric coefficient on the link from Belgium to Germany, between -1 and 1}
   }
  }
  }
  
  These files will be written in the Antares study (directory user`\`flowbased`\`), as well as additional files:
  \itemize{
  \item{scenario.txt, flow-based scenario builder, including only one column entitled "scenarios". The row 2 will then match the MC year 1 in
  the Antares scenario builder}
  \item{infos.ini Informations on the configured model.
  \itemize{
    \item{date : Time of initialisation}
    \item{model : name of the used model}
    }
  }
 }
}
\examples{

\dontrun{

 antaresRead::setSimulationPath("D:/Users/titorobe/Desktop/antaresStudy",1)
 antaresFlowbased::setFlowbasedPath(model = "D:/Users/titorobe/Desktop/FBModel")
 initFlowBased()
 }
 
 
}
