## Autor: Andreas Ruckstuhl, April 2016
## Anpassungen: Anna Drewek, Februar 2026
## Beschreibung der Input-Argumente:
## obj  - a regression fit, i.e. output of R-Function lm()
## which - which plots to generate
##.        (1 = Tukey-Anscombe, 2 = Normal, 3 = Scale-Location)
## seed - set random seed for the simualted smoothers
## nsim - Number of simulated smoothers
## rob - using a robust estimate for sigma

plot.lmSim <- function(obj, which=c(1L:3L), seed=NULL, nsim=19, rob=FALSE)
{
    
    X <- model.matrix(obj)
    x.n <- nrow(X)
    yh <- fitted(obj)
    sigma <- if(rob) mad(resid(obj)) else summary(obj)$sigma
    show <- rep(FALSE, 3)
    show[which] <- TRUE
    w <- obj$weights
    if(is.null(w)) w <- rep(1, nrow(X))
    sqrtW <- sqrt(w)

    ## Tukey-Anscombe Plot
    if(show[1L]){
        res <- resid(obj)
        ylim <- extendrange(r=range(res, na.rm = TRUE), f = 0.08)
        plot(yh*sqrtW, res*sqrtW, xlab = "Fitted values",
             ylab = "Residuals", main="", ylim = ylim, type = "n")
        abline(h = 0, lty = 3) ## , col = "gray"
        lines(lowess(yh*sqrtW, res*sqrtW, f=2/3, iter=3),
              lwd=1.5, col="red")

        if(!is.null(seed)) set.seed(seed)
        for(i in 1:nsim){
            FIT <- lm.wfit(x=X, y=yh + rnorm(x.n,0,sigma/sqrtW), w=w)
            lines(lowess(fitted(FIT)*sqrtW, resid(FIT)*sqrtW,
                         f=2/3, iter=3),col="grey")
        }
    }
    if(any(show[2L:3L])){
        ## Be careful, there are problems when hii==1
        hii <- lm.influence(obj, do.coef=FALSE)$hat
        if (any(isInf <- hii >= 1)) {
            warning(gettextf(paste("not plotting observations",
                                   "with leverage one:\n  %s"),
                             paste(which(isInf), collapse = ", ")),
                    call. = FALSE, domain = NA)
        }
        rdf <- obj$df.residual
        f.stdres <- function(wls) {
            r <- resid(wls)
            sr <- sqrt(w)*r/(sqrt((1 - hii) * sum(w*r^2)/rdf))
            sr[hii >= 1] <- NaN
            sr
        }
    }
    ## normal plot
    if(show[2L]){
        SIM <- matrix(NaN, ncol=nsim, nrow=x.n)
        if(nsim>0){
            if(!is.null(seed)) set.seed(seed)
            for(i in 1:nsim){
                FIT <- lm.wfit(x=X, y=yh + rnorm(x.n,0,sigma/sqrtW), w=w)
                SIM[!isInf,i] <- sort(qqnorm(f.stdres(FIT), plot.it=FALSE)$y)
            }
        }
        RQQN <- qqnorm(f.stdres(obj), plot.it=FALSE)
        ylim <- range(c(RQQN$y, SIM), finite=TRUE)
        plot(range(RQQN$x, finite=TRUE), ylim, type="n",
             xlab = "Theoretical Quantiles", ylab = "Stamdardized Residuals")
        if(nsim>0)
            points(rep(sort(RQQN$x),nsim), as.vector(SIM[!isInf,]), col="gray")
        points(RQQN$x, RQQN$y, lwd=2)
    }
    ## Scale-Location Plot
    if(show[3L]){
        sqrtabsR <- sqrt(abs(f.stdres(obj)))
        ylim <- c(0, max(sqrtabsR[is.finite(sqrtabsR)]))
        yl <- as.expression(substitute(sqrt(abs(YL)),
            list(YL=as.name("Standardized residuals"))))
        plot(yh, sqrtabsR, xlab="Fitted values", ylab=yl, main="",
             ylim=ylim, type="n")
        ok <- is.finite(sqrtabsR)
        lines(lowess(yh[ok], sqrtabsR[ok], f=2/3, iter=3), lwd=1.5, col="red")
        if(!is.null(seed)) set.seed(seed)
        for(i in 1:nsim){
            FIT <- lm.wfit(x=X, y=yh + rnorm(x.n,0,sigma/sqrtW), w=w)
            h.sRes  <- sqrt(abs(f.stdres(FIT)))
            ok <- is.finite(h.sRes)
            lines(lowess(fitted(FIT)[ok], h.sRes[ok], f=2/3, iter=3),
                  col="grey")
        }
    }
    invisible()
}
