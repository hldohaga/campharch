---
title: "ICS Development National and C&M"
output: html_notebook
---

Integrated care systems are a proposed system of governance for the healthcare system, the NHS, to be introduced in 2022. They have developed from the 'five year forward view" from 2014, via STPs, an pilot ICSs.

This document seeks to analyse the development of the policy into structures and activity.

```{r library, message=FALSE, warning=FALSE, include=FALSE, paged.print=FALSE}
#This section sets up the environment for working
library(quanteda)
library(readtext)
require(quanteda.textstats)
require(quanteda.textplots)
require(quanteda.corpora)
require(ggplot2)
```

## To Begin

This first section takes policies from the CCG, from the ICS locally and from DHSC ICS to create data objects to be analysed.

```{r CCG corporisation, message=FALSE, warning=FALSE, include=FALSE, paged.print=FALSE}
#This section reads the ccg strategy and opperational plans
opplanccg <- readtext(paste0( "*.pdf"))
#Then converts them into a corpus object
corpus_opplanccg <- corpus(opplanccg)
#The names are too long so are shortened
docnames(corpus_opplanccg) <- c("strategy","18-19","19-20")
summary(corpus_opplanccg)
head(docvars(corpus_opplanccg))
names(corpus_opplanccg)
```

```{r National ICS pols, message=FALSE, warning=FALSE, include=FALSE, paged.print=FALSE}
#This section reads the national ICS development plans from NHSE/DHSC
ICSpol <- readtext( "~/MPHModules/dissertation/icsguides/*.pdf")
#Then converts them into a corpus object
corpus_ICSpol <- corpus(ICSpol)
#The names are too long so are shortened
docnames(corpus_ICSpol) <- c(1,2,3,4,5,6,7,8,9,10)
summary(corpus_ICSpol)
head(docvars(corpus_ICSpol))
names(corpus_ICSpol)


```

```{r local C&M policies, message=FALSE, warning=FALSE, include=FALSE, paged.print=FALSE}
#This section reads the local C&M ICS development plans
ICSCandMpol <- readtext(paste0( "~/Desktop/MPHModules/dissertation/candm/*.pdf"))
#Then converts them into a corpus object
corpus_ICSCandMpol <- corpus(ICSCandMpol)
#The names are too long so are shortened
docnames(corpus_ICSCandMpol) <- c("CandM1","CandM2","CandM3","CandM4","CandM5","CandM6","CandM7","CandM8","CandM9","CandM10","CandM11","CandM12","CandM13","CandM14","CandM15","CandM16","CandM17","CandM18","CandM19","CandM20")
summary(corpus_ICSCandMpol)
head(docvars(corpus_ICSCandMpol))
names(corpus_ICSCandMpol)

```

```{r lanc and south lakes C&M policies, message=FALSE, warning=FALSE, include=FALSE, paged.print=FALSE}
#This section reads the local C&M ICS development plans
ICSlscpol <- readtext(paste0( "~/Desktop/MPHModules/dissertation/lscics/*.pdf"))
#Then converts them into a corpus object
corpus_ICSlscpol <- corpus(ICSlscpol)
#The names are too long so are shortened
#docnames(corpus_ICSCandMpol) <- c(11,12,13,14,15,16,17,18,19,110,111,112,113,114,115,116,117,118,119,120)
summary(corpus_ICSlscpol)
head(docvars(corpus_ICSlscpol))
#names(corpus_ICSlscpol)

```

```{r total policies, message=FALSE, warning=FALSE, include=FALSE, paged.print=FALSE}
#This section adds tehm all together
corpus_total <- corpus_opplanccg + corpus_ICSCandMpol + corpus_ICSpol + corpus_ICSlscpol
summary(corpus_total)
head(docvars(corpus_total))
names(corpus_total)

```

Step two is to alter the data objects to strip out punctuation, numbers and common English words which have no contextual information, e.g and , a , it. Then to produce a table of word frequency. As well as wordclouds to enable comparison of relative frequency.

```{r ccg cloud, echo=FALSE, message=FALSE, warning=FALSE, paged.print=FALSE}
tokopplanccg <- tokens(corpus_opplanccg, remove_punct = TRUE, remove_numbers = TRUE)
tokopplanccg <- tokens_remove(tokopplanccg, pattern = stopwords("en"), padding = FALSE)
dfmopplanccg <- dfm(tokopplanccg)
#dfmopplanccg
tstat_freq <- textstat_frequency(dfmopplanccg)
head(tstat_freq, 20)
set.seed(132)
textplot_wordcloud(dfmopplanccg,max_words = 100)
```

```{r ICS frequencies and word cloud, echo=FALSE, message=FALSE, warning=FALSE, paged.print=FALSE}
tokoICSpol <- tokens(corpus_ICSpol, remove_punct = TRUE, remove_numbers = TRUE)
tokoICSpol <- tokens_remove(tokoICSpol, pattern = stopwords("en"), padding = FALSE)
dfmICSpol <- dfm(tokoICSpol)
#dfmopplanccg
tstat_freq <- textstat_frequency(dfmICSpol)
head(tstat_freq, 40)
set.seed(132)
textplot_wordcloud(dfmICSpol,max_words = 100)
```

```{r local ICS frequency and wordcloud, echo=FALSE, message=FALSE, warning=FALSE, paged.print=FALSE}
tokoICSCandMpol <- tokens(corpus_ICSCandMpol, remove_punct = TRUE, remove_numbers = TRUE)
tokoICSCandMpol <- tokens_remove(tokoICSCandMpol, pattern = stopwords("en"), padding = FALSE)
dfmICSCandMpol <- dfm(tokoICSCandMpol)
#dfmopplanccg
tstat_freq <- textstat_frequency(dfmICSCandMpol)
head(tstat_freq, 40)
set.seed(132)
textplot_wordcloud(dfmICSCandMpol,max_words = 100)
```

```{r total cloud, echo=FALSE, message=FALSE, warning=FALSE, paged.print=FALSE}
tokototal <- tokens(corpus_total, remove_punct = TRUE, remove_numbers = TRUE)
tokototal <- tokens_remove(tokototal, pattern = stopwords("en"), padding = FALSE)
dfm_total <- dfm(tokototal)
#dfmopplanccg
tstat_freq <- textstat_frequency(dfm_total)
head(tstat_freq, 20)
set.seed(132)
textplot_wordcloud(dfm_total,max_words = 100)
```

```{r lsc cloud, echo=FALSE, message=FALSE, warning=FALSE, paged.print=FALSE}
tokoICSlscpol <- tokens(corpus_ICSlscpol, remove_punct = TRUE, remove_numbers = TRUE)
tokoICSlscpol <- tokens_remove(tokoICSlscpol, pattern = stopwords("en"), padding = FALSE)
dfm_ICSlscpol <- dfm(tokoICSlscpol)
#dfmopplanccg
tstat_freq <- textstat_frequency(dfm_ICSlscpol)
head(tstat_freq, 20)
set.seed(132)
textplot_wordcloud(dfm_ICSlscpol,max_words = 100)
```

These tables and clouds appear to show a similarity in content and a similarity in content.

## Part 2

The next section starts to look at words which occur close to key words starting with health

```{r}
kw_opplanccgh <- kwic(tokopplanccg, pattern =  "heal*")
head(kw_opplanccgh)
corp_kw_opplanccgh <- corpus(kw_opplanccgh)
dfmkw_opplanccgh <- dfm(corp_kw_opplanccgh)
tstat_freq <- textstat_frequency(dfmkw_opplanccgh)
head(tstat_freq, 10)
set.seed(132)
textplot_wordcloud(dfmkw_opplanccgh,max_words = 100)
```

```{r}
#kw_opplanccgh
kw_ICSpol <- kwic(tokoICSpol, pattern =  "heal*")
head(kw_ICSpol)
corp_kw_ICSpol <- corpus(kw_ICSpol)
dfmkw_ICSpol <- dfm(corp_kw_ICSpol)
tstat_freq <- textstat_frequency(dfmkw_ICSpol)
head(tstat_freq, 10)
set.seed(132)
textplot_wordcloud(dfmkw_ICSpol,max_words = 100)
```

```{r}
#kw_opplanccgh
kw_ICSCandMpol <- kwic(tokoICSCandMpol, pattern =  "heal*")
head(kw_ICSCandMpol)
corp_kw_ICSCandMpol <- corpus(kw_ICSCandMpol)
dfmkw_ICSCandMpol <- dfm(corp_kw_ICSCandMpol)
tstat_freq <- textstat_frequency(dfmkw_ICSCandMpol)
head(tstat_freq, 10)
set.seed(132)
textplot_wordcloud(dfmkw_ICSCandMpol,max_words = 100)
```

```{r}
#kw_opplanccgh
kw_totalph <- kwic(tokototal, pattern =  phrase( "public health"))
head(kw_totalph)
corp_kw_totalph <- corpus(kw_totalph)
tokocorp_kw_totalph <- tokens(corp_kw_totalph , remove_punct = TRUE, remove_numbers = TRUE)
tokocorp_kw_totalph <- tokens_remove(tokocorp_kw_totalph, pattern = stopwords("en"), padding = FALSE)
dfmtokocorp_kw_totalph <- dfm(tokocorp_kw_totalph)

tstat_freq <- textstat_frequency(dfmtokocorp_kw_totalph)
head(tstat_freq, 10)
set.seed(132)
textplot_wordcloud(dfmtokocorp_kw_totalph,max_words = 100)
```

```{r}
#kw_opplanccgh
kw_totalph <- kwic(tokototal, pattern =  phrase( "population health"))
head(kw_totalph)
corp_kw_totalph <- corpus(kw_totalph)
tokocorp_kw_totalph <- tokens(corp_kw_totalph , remove_punct = TRUE, remove_numbers = TRUE)
tokocorp_kw_totalph <- tokens_remove(tokocorp_kw_totalph, pattern = stopwords("en"), padding = FALSE)
dfmtokocorp_kw_totalph <- dfm(tokocorp_kw_totalph)

tstat_freq <- textstat_frequency(dfmtokocorp_kw_totalph)
head(tstat_freq, 10)
set.seed(132)
textplot_wordcloud(dfmtokocorp_kw_totalph,max_words = 100)
```

For Strategy

```{r}
kw_opplanccgs <- kwic(tokopplanccg, pattern =  "strateg*")
head(kw_opplanccgs)
corp_kw_opplanccgs <- corpus(kw_opplanccgs)
dfmkw_opplanccgs <- dfm(corp_kw_opplanccgs)
tstat_freq <- textstat_frequency(dfmkw_opplanccgs)
head(tstat_freq, 10)
set.seed(132)
textplot_wordcloud(dfmkw_opplanccgs,max_words = 100)
```

```{r}
kw_ICSpol <- kwic(tokoICSpol, pattern =  "strateg*")
head(kw_ICSpol)
corp_kw_ICSpol <- corpus(kw_ICSpol)
dfmkw_ICSpol <- dfm(corp_kw_ICSpol)
tstat_freq <- textstat_frequency(dfmkw_ICSpol)
head(tstat_freq, 10)
set.seed(132)
textplot_wordcloud(dfmkw_ICSpol,max_words = 100)
```

```{r}
kw_ICSCandMpol <- kwic(tokoICSCandMpol, pattern =  "strateg*")
head(kw_ICSCandMpol)
corp_kw_ICSCandMpol <- corpus(kw_ICSCandMpol)
dfmkw_ICSCandMpol <- dfm(corp_kw_ICSCandMpol)
tstat_freq <- textstat_frequency(dfmkw_ICSCandMpol)
head(tstat_freq, 10)
set.seed(132)
textplot_wordcloud(dfmkw_ICSCandMpol,max_words = 100)
```

```{r}
kw_opplanccgp <- kwic(tokopplanccg, pattern =  "polic*")
head(kw_opplanccgp)
corp_kw_opplanccgh <- corpus(kw_opplanccgh)
dfmkw_opplanccgh <- dfm(corp_kw_opplanccgh)
tstat_freq <- textstat_frequency(dfmkw_opplanccgh)
head(tstat_freq, 10)
set.seed(132)
textplot_wordcloud(dfmkw_opplanccgh,max_words = 100)
```

```{r}
kw_ICSpol <- kwic(tokoICSpol, pattern =  "polic*")
head(kw_ICSpol)
corp_kw_ICSpol <- corpus(kw_ICSpol)
dfmkw_ICSpol <- dfm(corp_kw_ICSpol)
tstat_freq <- textstat_frequency(dfmkw_ICSpol)
head(tstat_freq, 10)
set.seed(132)
textplot_wordcloud(dfmkw_ICSpol,max_words = 100)
```

```{r}
kw_ICSCandMpol <- kwic(tokoICSCandMpol, pattern =  "polic*")
head(kw_ICSCandMpol)
corp_kw_ICSCandMpol <- corpus(kw_ICSCandMpol)
dfmkw_ICSCandMpol <- dfm(corp_kw_ICSCandMpol)
tstat_freq <- textstat_frequency(dfmkw_ICSCandMpol)
head(tstat_freq, 10)
set.seed(132)
textplot_wordcloud(dfmkw_ICSCandMpol,max_words = 100)
```

```{r}
kw_opplanccgho <- kwic(tokopplanccg, pattern =  "hospit*")
head(kw_opplanccgho)
corp_kw_opplanccgho <- corpus(kw_opplanccgho)
dfmkw_opplanccgho <- dfm(corp_kw_opplanccgho)
tstat_freq <- textstat_frequency(dfmkw_opplanccgho)
head(tstat_freq, 10)
set.seed(132)
textplot_wordcloud(dfmkw_opplanccgho,max_words = 100)
```

```{r}
kw_ICSpol <- kwic(tokoICSpol, pattern =  "hospit*")
head(kw_ICSpol)
corp_kw_ICSpol <- corpus(kw_ICSpol)

dfmkw_ICSpol <- dfm(corp_kw_ICSpol)
tstat_freq <- textstat_frequency(dfmkw_ICSpol)
head(tstat_freq, 10)
set.seed(132)
textplot_wordcloud(dfmkw_ICSpol,max_words = 100)
```

```{r}
kw_ICSCandMpol <- kwic(tokoICSCandMpol, pattern =  "hospit*")
head(kw_ICSCandMpol)
corp_kw_ICSCandMpol <- corpus(kw_ICSCandMpol)
dfmkw_ICSCandMpol <- dfm(corp_kw_ICSCandMpol)
tstat_freq <- textstat_frequency(dfmkw_ICSCandMpol)
head(tstat_freq, 10)
set.seed(132)
textplot_wordcloud(dfmkw_ICSCandMpol,max_words = 100)
```

```{r}
kw_ICSCandMpol <- kwic(tokoICSCandMpol, pattern =  "hospit*")
head(kw_ICSCandMpol)
corp_kw_ICSCandMpol <- corpus(kw_ICSCandMpol)
dfmkw_ICSCandMpol <- dfm(corp_kw_ICSCandMpol)
tstat_freq <- textstat_frequency(dfmkw_ICSCandMpol)
head(tstat_freq, 10)
set.seed(132)
textplot_wordcloud(dfmkw_ICSCandMpol,max_words = 100)
```

## section four

This part looks at the similarity of texts within the different corpus collections.

First for CCG

```{r}
tstat_lexdiv <- textstat_lexdiv(dfmopplanccg)
tstat_lexdiv

tstat_dist <- as.dist(textstat_dist(dfmopplanccg))
tstat_dist
clust <- hclust(tstat_dist)
plot(clust, xlab = "Distance", ylab = NULL)
```

Then for the ICS policies

```{r}
tstat_lexdiv <- textstat_lexdiv(dfmICSpol)
tstat_lexdiv

tstat_dist <- as.dist(textstat_dist(dfmICSpol))
tstat_dist
clust <- hclust(tstat_dist)
plot(clust, xlab = "Distance", ylab = NULL)


```

Then for the C&M ICS

```{r}
tstat_lexdiv <- textstat_lexdiv(dfmICSCandMpol)
tstat_lexdiv

tstat_dist <- as.dist(textstat_dist(dfmICSCandMpol))
tstat_dist
clust <- hclust(tstat_dist)
plot(clust, xlab = "Distance", ylab = NULL)


```

Then adding all the corpi

```{r}

tstat_lexdiv <- textstat_lexdiv(dfm_total)
tstat_lexdiv

tstat_dist <- as.dist(textstat_dist(dfm_total))
tstat_dist
clust <- hclust(tstat_dist)
plot(clust, xlab = "Distance", ylab = NULL)


```
