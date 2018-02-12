##  Survival analysis for 
library("survival")
library("survminer")

survivalLIHC <- read.table("~/Documents/prj_algo_bioinfo/data/survivalLIHC.txt", sep ="\t", 
                           row.names = 1, header = TRUE)
head (survivalLIHC)
transposed <- t(survivalLIHC)
transposed <- as.data.frame(transposed)
trim_data <- transposed[,c(1:50)]
colnames(trim_data)

#res.cox <- coxph(Surv(LivingDays, Status) ~ ENSG00000000005, data = trim_data)
#res.cox
#summary(res.cox)

feature_50 <- colnames (transposed) 
univ_formulas <- sapply(feature_50,function(x) as.formula(paste('Surv(LivingDays, Status)~', x)))
univ_models <- lapply( univ_formulas, function(x){coxph(x, data = transposed)})
univ_results <- lapply(univ_models,function(x){ 
  x <- summary(x)
  p.value<-signif(x$wald["pvalue"], digits=2)
  wald.test<-signif(x$wald["test"], digits=2)
  beta<-signif(x$coef[1], digits=2);#coeficient beta
  HR <-signif(x$coef[2], digits=2);#exp(beta)
  HR.confint.lower <- signif(x$conf.int[,"lower .95"], 2)
  HR.confint.upper <- signif(x$conf.int[,"upper .95"],2)
  HR <- paste0(HR, " (", 
               HR.confint.lower, "-", HR.confint.upper, ")")
  res<-c(beta, HR, wald.test, p.value)
  names(res)<-c("beta", "HR (95% CI for HR)", "wald.test", 
                "p.value")
  return(res)
})
res <- t(as.data.frame(univ_results, check.names = FALSE))  

write.table(res, "~/Documents/prj_algo_bioinfo/data/result.txt", sep ="\t", 
            row.names = TRUE, col.names = TRUE,quote = FALSE)

## Computing the hazard cox model for the given data
## install.packages(c("survival", "survminer"))


data("lung")
head(lung)
summary(res.cox)

covariates <- c("age", "sex",  "ph.karno", "ph.ecog", "wt.loss")
univ_formulas <- sapply(covariates,
                        function(x) as.formula(paste('Surv(time, status)~', x)))
univ_models <- lapply( univ_formulas, function(x){coxph(x, data = lung)})
univ_results <- lapply(univ_models,function(x){ 
                        x <- summary(x)
                         p.value<-signif(x$wald["pvalue"], digits=2)
                         wald.test<-signif(x$wald["test"], digits=2)
                         beta<-signif(x$coef[1], digits=2);#coeficient beta
                         HR <-signif(x$coef[2], digits=2);#exp(beta)
                         HR.confint.lower <- signif(x$conf.int[,"lower .95"], 2)
                         HR.confint.upper <- signif(x$conf.int[,"upper .95"],2)
                         HR <- paste0(HR, " (", 
                                      HR.confint.lower, "-", HR.confint.upper, ")")
                         res<-c(beta, HR, wald.test, p.value)
                         names(res)<-c("beta", "HR (95% CI for HR)", "wald.test", 
                                       "p.value")
                         return(res)
                         #return(exp(cbind(coef(x),confint(x))))
})
  
res <- t(as.data.frame(univ_results, check.names = FALSE))    


res.cox <- coxph(Surv(LivingDays, Status) ~ ENSG00000000005, data = trim_data)
res.cox
summary(res.cox)
ggsurvplot(survfit(res.cox), palette= '#2E9FDF',data = trim_data,
           ggtheme = theme_minimal())


## multivariate survival model
res.cox <- coxph(Surv(LivingDays, Status) ~ Age + Gender + ENSG00000000005, data =  trim_data)
summary(res.cox)
ggsurvplot(fit, conf.int = TRUE, legend.labs=c("Age=1", "Age=2"), data =trim_data,
           ggtheme = theme_minimal())


