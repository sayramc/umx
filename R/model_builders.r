# devtools::document("~/bin/umx"); devtools::install("~/bin/umx");
# ==================
# = Model Builders =
# ==================
#' umxEFA
#'
#' Perform full-information maximum-likelihood factor analysis on a data matrix.
#' as in \code{\link{factanal}}, you need only specify the number of factors and offer up
#' some manifest data, e.g:
#'                                                              
#' umxEFA(factors = 2, data = mtcars)
#' 
#' Equivalently, you can also give a list of factor names:
#' 
#' umxEFA(factors = c("g", "v"), data = mtcars)
#' 
#' \figure{umxEFA.png}
#' 
#' \emph{notes}: In an EFA, all items may load on all factors.
#' For identification we need m^2 degrees of freedom. We get m * (m+1)/2 from fixing factor variances to 1 and covariances to 0.
#' We get another m(m-1)/2 degrees of freemdom by fixing the upper-right hand corner of the factor loadings
#' component of the A matrix. The manifest variances are also lbounded at 0.
#' 
#' EFA reports standardized loadings: to do this, we scale the data.
#' 
#' Bear in mind that factor scores are indeterminate and can be rotated.
#' 
#' This is very much early days. Adding "scores" in response to demand.
#' 
#' todo: detect ordinal items and switch to UWLS
#' 
#' @aliases umxFactanal umxEFA
#' @param x Either 1: data, 2: A formula (not implemented yet), 3: A vector of variable names, or 4: A name for the model.
#' @param factors Either number of factors to request or a vector of factor names.
#' @param data A dataframe of manifest columns you are modeling
#' @param covmat Covariance matrix of data you are modeling (not implemented)
#' @param n.obs Number of observations in covmat (if provided, default = NA)
#' @param scores Type of scores to produce, if any. The default is none, "Regression" gives Thompson's scores. Other options are 'ML', 'WeightedML', Partial matching allows these names to be abbreviated.
#' @param rotation A rotation to perform on the loadings (default  = "varimax" (orthogonal))
#' @param name A name for your model
#' @param digits rounding (default = 2)
#' @param report What to report
#' @return - EFA \code{\link{mxModel}}
#' @family Super-easy helpers
#' @export
#' @seealso - \code{\link{factanal}}, \code{\link{mxFactorScores}}
#' @references - \url{http://github.com/tbates/umx}
#' @examples
#' myVars <- c("mpg", "disp", "hp", "wt", "qsec")
#' m1 = umxEFA(mtcars[, myVars], factors =   2, rotation = "promax")
#' loadings(m1)
#' m2 = factanal(~ mpg + disp + hp + wt + qsec, factors = 2, rotation = "promax", data = mtcars)
#' loadings(m2)
#' \dontrun{
#' plot(m2)
#' m1 = umxEFA(myVars, factors = 2, data = mtcars, rotation = "promax")
#' m1 = umxEFA(name = "named", factors = "g", data = mtcars[, myVars])
#' m1 = umxEFA(name = "by_number", factors = 2, rotation = "promax", data = mtcars[, myVars])
#' m1 = umxEFA(name = "score", factors = "g", data = mtcars[, myVars], scores= "Regression")
#' }
umxEFA <- function(x = NULL, factors = NULL, data = NULL, covmat = NULL, n.obs = NULL, 
	scores = c("none", 'ML', 'WeightedML', 'Regression'),
	rotation = c("varimax", "promax", "none"), name = "efa", digits = 2, report = c("1", "table", "html")){
	message("umxEFA is beta, send requests to tim.bates@ed.ac.uk")
	scores = match.arg(scores)
	# "Bartlett" given Bartlett's weighted least-squares scores. 
	# name     = "efa"
	# factors  = 1
	# data     = mtcars[,c("mpg", "disp", "hp", "wt", "qsec")]
	# rotation = "varimax"
	if (!is.null(data)){
		# x must be formula, or column list && covmat and n.obs must be NULL
		if(!is.null(covmat) || !is.null(n.obs)){
			stop("covmat and n.obs must be empty when using 'data =' ...")
		}
		if(!is.null(x)){
			if(length(x) > 1) {
				umx_check_names(x, data)
				data = data[,x]
			} else if (inherits(x,"formula")){
				stop("Nice formula! Sadly I can't handle formulae yet: email tim and abuse him about this failing")
				# todo: handle is.formula()
			}else{
				name = x
			}
		}else{
			name = "EFA"
		}
	} else if(!is.null(covmat) || !is.null(n.obs)){
		# data must be NULL
		stop("Covmat support not yet implemented - but with cov data, you may as well be using factanal()...")
		if(!is.null(data)){
			stop("You can't offer up both a data.frame and a covmat.")
		}
	} else {
		# data is empty, so x must be data
		if(!is.null(x)){
			if(is.data.frame(x)){
				data = x # get data from x
			}else if (is.matrix(x)){
				data = as.data.frame(x)
			}
		} else if(is.null(data)){
			stop("You need to provide a data.frame to analyse: this can be in x, or data, or covmat")
		}
		name = "EFA"
	}

	# What about for scores? Do we want std loadings in that case?...
	data = umx_scale(data)
	rotation = umx_default_option(rotation, c("varimax", "promax", "none"), check = FALSE)
	if(is.null(factors)){
		stop("You need to request at least 1 latent factor, e.g.: factors = 4")
	} else if( length(factors)==1 && class(factors)=="numeric"){
		factors = paste0("F", c(1:factors))
	}
	# TODO adapt to input datatype, i.e., add cov handler
	manifests <- names(data)
	m1 <- umxRAM(model = name, data = data, autoRun = FALSE,
		umxPath(factors, to = manifests, connect = "unique.bivariate"),
		umxPath(v.m. = manifests),
		umxPath(v1m0 = factors)
	)
	# Fix upper-right triangle of A-matrix factor columns at zero
	nFac       = length(factors)
	nManifests = length(manifests)
	if(nFac > 1){
		for(i in 2:nFac){
			m1$A$free[1:(i-1), factors[i]] = FALSE
			m1$A$values[1:(i-1), factors[i]] = 0
		}
	}
	# lbound the manifest diagonal to avoid mirror indeterminacy
	for(i in seq_along(manifests)) {
	   thisManifest = manifests[i]
	   m1$A$lbound[thisManifest, thisManifest] = 0
	}
	m1 = mxRun(m1)
	if(rotation != "none" && nFac > 1){
		x = loadings.MxModel(m1)
		x = eval(parse(text = paste0(rotation, "(x)")))
		print(x) # print out the nice rotation result
		m1$A$values[manifests, factors] = x$loadings[1:nManifests, 1:nFac] # stash the rotated result
	} else {
		print(loadings(m1))
	}
	umxSummary(m1, digits = digits, report = report);
	if(scores != "none"){
		x = umxFactorScores(m1, type = scores)
	} else {
		invisible(m1)
	}
}

#' @export
umxFactanal <- umxEFA

umxFactorScores <- function(model, type = c('ML', 'WeightedML', 'Regression')) {
	suppressMessages({
		scores = mxFactorScores(model, type = type)
	})
	# Only need score from [nrow, nfac, c("score", "se")]
	if(dim(scores)[2] == 1){
		# drop = FALSE if only 1 factor
		return(scores[ , , 1, drop = FALSE])
	} else {
		return(scores[ , , 1])
	}
}



#' umxTwoStage
#'
#' umxTwoStage implements 2-stage least squares regression in Structural Equation Modeling.
#' For ease of learning, the function is modeled closely on the \code{\link[sem]{tsls}}.
#' 
#' The example is a Mendelian Randomization \url{https://en.wikipedia.org/wiki/Mendelian_randomization} 
#' analysis to show the value of two-stage.
#'
#' @param formula	for structural equation to be estimated; a regression constant is implied if not explicitly omitted.
#' @param instruments	one-sided formula specifying instrumental variables.
#' @param data data.frame containing the variables in the model.
#' @param subset [optional] vector specifying a subset of observations to be used in fitting the model.
#' @param weights [optional] vector of weights to be used in the fitting process;
#' if specified should be a non-negative numeric vector with one entry for each observation,
#' to be used to compute weighted 2SLS estimates.
#' @param contrasts	an optional list. See the contrasts.arg argument of model.matrix.default.
#' @param name for the model (defaults to "tsls")
#' @param ...	arguments to be passed down.
#' @return - 
#' @export
#' @family Super-easy helpers
#' @seealso - \code{\link{umxRAM}}, \code{\link[sem]{tsls}}
#' @references - Fox, J. (1979) Simultaneous equation models and two-stage least-squares.
#' In Schuessler, K. F. (ed.) \emph{Sociological Methodology}, Jossey-Bass., 
#' Greene, W. H. (1993) \emph{Econometric Analysis}, Second Edition, Macmillan.
#' @examples
#' library(umx)
#' 
#' 
#' # ====================================
#' # = Mendelian randomization analysis =
#' # ====================================
#' 
#'# Note: in practice: many more subjects are desireable - this just to let example run fast
#' df = umx_make_MR_data(1000) 
#' m1 = umxTwoStage(Y ~ X, instruments = ~ qtl, data = df)
#' coef(m1)
#' plot(m1)
#' 
#' # Errant analysis using ordinary least squares regression (WARNING this result is CONFOUNDED!!)
#' m1 = lm(Y ~ X    , data = df); coef(m1) # incorrect .35 effect of X on Y
#' m1 = lm(Y ~ X + U, data = df); coef(m1) # Controlling U reveals the true 0.1 beta weight
#' #
#' #
#' \dontrun{
#' df = umx_make_MR_data(1e5) 
#' m1 = umxTwoStage(Y ~ X, instruments = ~ qtl, data = df)
#' 
#' # ======================
#' # = now with sem::tsls =
#' # ======================
#' # library(sem) # will require you to install X11
#' m2 = sem::tsls(formula = Y ~ X, instruments = ~ qtl, data = df)
#' coef(m1)
#' coef(m2)
# # Try with missing value for one subect: A beneift of the FIML approach in OpenMx.
#' m3 = tsls(formula = Y ~ X, instruments = ~ qtl, data = (df[1,"qtl"] = NA))
#' }
umxTwoStage <- function(formula, instruments, data, subset, weights, contrasts= NULL, name = "tsls", ...) {
	umx_check(is.null(contrasts), "stop", "Contrasts not supported yet in umxTwoStage: email maintainer to prioritize")	
	# formula = Y ~ X; instruments ~ qtl; data = umx_make_MR_data(10000)
	# m1 = sem::tsls(formula = Y ~ X, instruments = ~ qtl, data = df)
	# summary(sem::tsls(Q ~ P + D, ~ D + F + A, data=Kmenta))
	if(!class(formula) == "formula"){
		stop("formula must be a formula")
	}
	allForm = all.vars(terms(formula))
	if(length(allForm) != 2){
		stop("I'm currently limited to 1 DV, 1 IV, and 1 instrument: 'formula' had ", length(allForm), " items")
	}
	DV   = allForm[1] # left hand item
	Xvars  = all.vars(delete.response(terms(formula)))
	inst = all.vars(terms(instruments))
	if(length(inst) != 1){
		stop("I'm currently limited to 1 DV, 1 IV, and 1 instrument: 'instruments' had ", length(allForm), " items")
	}
	manifests <- c(allForm, inst)     # manifests <- c("qtl", "X", "Y")
	latentErr <- paste0("e", allForm) # latentErr   <- c("eX", "eY")
	umx_check_names(manifests, data = data, die = TRUE)

	IVModel <- umxRAM("IV Model", data = mxData(data, type = "raw"),
		# Causal and confounding paths
		umxPath(inst , to = Xvars), # beta of SNP effect          :  X ~ b1 x inst
		umxPath(Xvars, to = DV),    # Causal effect of Xvars on DV: DV ~ b2 x X

		# Latent error stuff + setting up variance and means for variables
		umxPath(v.m. = inst),     # Model variance and mean of instrument
		umxPath(var = latentErr), # Variance of residual errors
		umxPath(latentErr, to = allForm, fixedAt = 1), # X and Y residuals@1.
		umxPath(unique.bivariate = latentErr, values = 0.2, labels = paste0("phi", length(latentErr)) ), # Correlation among residuals
		umxPath(means = c(Xvars, DV))
	)
	# umx_time(IVModel) # IV Model: 3.1 s ( was 14.34 seconds with poor start values) for 100,000 subjects
	return(IVModel)
}

# load(file = "~/Dropbox/shared folders/OpenMx_binaries/shared data/bad_CFI.Rda", verbose =T)
# ref <- mxRefModels(IVModel, run=TRUE)
# summary(IVModel, refModels=ref)