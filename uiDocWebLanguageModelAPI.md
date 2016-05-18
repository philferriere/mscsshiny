Calling the MSCS Web Language Model API with the `{mscsweblm4r}` R package
==========================================================================
  
[![Build Status](https://api.travis-ci.org/philferriere/mscsweblm4r.png)](https://travis-ci.org/philferriere/mscsweblm4r)
[![codecov.io](https://codecov.io/github/philferriere/mscsweblm4r/coverage.svg?branch=master)](https://codecov.io/github/philferriere/mscsweblm4r?branch=master)
[![CRAN Version](http://www.r-pkg.org/badges/version/mscsweblm4r)](https://cran.r-project.org/package=mscsweblm4r)

The Microsoft Cognitive Services (MSCS) website provides several code samples
that illustrate how to use the awesome Web LM REST API from C#, Java, JavaScript, ObjC, PHP, Python, Ruby,
and... you guessed it -- if you want to test drive their service from R, you're
pretty much on your own. To restore ![](https://dl.dropboxusercontent.com/u/5888080/SadPanda.png)'s
happiness, and allow us to experiment with Microsoft Research's NLP in R, we've
developed a R interface to a subset of the MSCS REST API.

To use the `{mscsweblm4r}` R package, you **MUST** have a valid [account](https://www.microsoft.com/cognitive-services/en-us/pricing)
with Microsoft Cognitive Services. Once you have an account, Microsoft will
provide you with an [API key](https://en.wikipedia.org/wiki/Application_programming_interface_key).
This key will be listed under your subscriptions.

After you've configured `{mscsweblm4r}` with your API key, you will be able to
call the Web LM REST API from R, up to your maximum number of transactions per
month and per minute.

## What's the Web LM REST API?

[Microsoft Cognitive Services](https://www.microsoft.com/cognitive-services/en-us/documentation)
-- formerly known as Project Oxford -- are a set of APIs, SDKs and services
that developers can use to add [AI](https://en.wikipedia.org/wiki/Artificial_intelligence)
features to their apps. Those features include emotion and video detection;
facial, speech and vision recognition; and speech and language understanding.

The [Web Language Model REST API](https://www.microsoft.com/cognitive-services/en-us/web-language-model-api/documentation)
provides tools for natural language processing [NLP](https://en.wikipedia.org/wiki/Natural_language_processing).

Per Microsoft's website, this API uses smoothed Backoff N-gram language models
(supporting Markov order up to 5) that were trained on four web-scale American
English corpora collected by Bing (web page body, title, anchor and query).

The MSCS Web LM REST API supports four lookup operations:

* Joint (log10) probability of a sequence of words.
* Conditional (log10) probability of one word given a sequence of preceding words.
* List of words (completions) most likely to follow a given sequence of words.
* Word breaking of strings that contain no spaces.

## Package Status

This package is certainly functional. It's also the first time it is available
on CRAN. Therefore, if you observe unexpected behaviors (a.k.a. bugs), please be
kind enough to submit a bug report on GitHub (not via email) with a minimal
reproducible example.

## Package Installation

You can either install the latest **stable** version from CRAN:


```r
if ("mscsweblm4r" %in% installed.packages()[,"Package"] == FALSE) {
  install.packages("mscsweblm4r")
}
```

Or, you can install the **development** version


```r
if ("mscsweblm4r" %in% installed.packages()[,"Package"] == FALSE) {
  if ("devtools" %in% installed.packages()[,"Package"] == FALSE) {
    install.packages("devtools")
  }
  devtools::install_github("philferriere/mscsweblm4r")
}
```

## Package Loading and Configuration

After loading `{mscsweblm4r}` with `library()`, you **must** call `weblmInit()`
before you can call any of the core `{mscsweblm4r}` functions.

The `weblmInit()` configuration function will first check to see if the variable
`MSCS_WEBLANGUAGEMODEL_CONFIG_FILE` exists in the system environment. If it does,
the package will use that as the path to the configuration file.

If `MSCS_WEBLANGUAGEMODEL_CONFIG_FILE` doesn't exist, it will look for the file
`.mscskeys.json` in the current user's home directory (that's `~/.mscskeys.json`
on Linux, and something like `C:\Users\Phil\Documents\.mscskeys.json` on
Windows). If the file is found, the package will load the API key and URL from
it.

If using a file, please make sure it has the following structure:

```json
{
  "weblanguagemodelurl": "https://api.projectoxford.ai/text/weblm/v1.0/",
  "weblanguagemodelkey": "...MSCS Web Language Model API key goes here..."
}
```

If no configuration file is found, `weblmInit()` will attempt to pick up its
configuration from two Sys env variables instead:

`MSCS_WEBLANGUAGEMODEL_URL` - the URL for the Web LM REST API.

`MSCS_WEBLANGUAGEMODEL_KEY` -  your personal Web LM REST API key.

`weblmInit()` needs to be called *only once*, after package load.

## Error Handling Not Optional

The MSCS Web LM API is a **[RESTful](https://en.wikipedia.org/wiki/Representational_state_transfer)** API. HTTP requests over a network and the
Internet can fail. Because of congestion, because the web site is down for
maintenance, because of firewall configuration issues, etc. There are many
possible points of failure.

The API can also fail if you've **exhausted your call volume quota** or are **exceeding
the API calls rate limit**. Unfortunately, MSCS does not expose an API you can query to check
if you're about to exceed your quota for instance. The only way you'll know for
sure is by **looking at the error code** returned after an API call has failed.

Therefore, you must write your R code with failure in mind. Our preferred way is
to use `tryCatch()`. Its mechanism may appear a bit daunting at first, but it
is well [documented](http://www.inside-r.org/r-doc/base/signalCondition). We've
also included many examples, as you'll see below.

## Package Configuration with Error Handling

Here's some sample code that illustrates how to use `tryCatch()`:


```r
library('mscsweblm4r')
tryCatch({

  weblmInit()

}, error = function(err) {

  geterrmessage()

})
```

If `{mscsweblm4r}` cannot locate `.mscskeys.json` nor any of the configuration
environment variables, the code above will generate the following output:


```r
[1] "mscsweblm4r: could not load config info from Sys env nor from file"
```

Similarly, `weblmInit()` will fail if `{mscsweblm4r}` cannot find the
`weblanguagemodelkey` key in `.mscskeys.json`, or fails to parse it correctly,
etc. This is why it is so important to use `tryCatch()` with all `{mscsweblm4r}`
functions.

## Package API

The five API calls exposed by `{mscsweblm4r}` are the following:


```r
  # Retrieve a list of supported web language models
  weblmListAvailableModels()
```


```r
  # Break a string of concatenated words into individual words
  weblmBreakIntoWords(
    textToBreak,                    # ASCII only
    modelToUse = "body",            # "title"|"anchor"|"query"(default)|"body"
    orderOfNgram = 5L,              # 1L|2L|3L|4L|5L(default)
    maxNumOfCandidatesReturned = 5L # Default: 5L
  )
```


```r
  # Get the words most likely to follow a sequence of words
  weblmGenerateNextWords(
    precedingWords,                 # ASCII only
    modelToUse = "title",           # "title"|"anchor"|"query"(default)|"body"
    orderOfNgram = 4L,              # 1L|2L|3L|4L|5L(default)
    maxNumOfCandidatesReturned = 5L # Default: 5L
  )
```


```r
  # Calculate joint probability a particular sequence of words will appear together
  weblmCalculateJointProbability(
    inputWords =,                   # ASCII only
    modelToUse = "query",           # "title"|"anchor"|"query"(default)|"body"
    orderOfNgram = 4L               # 1L|2L|3L|4L|5L(default)
  )
```


```r
  # Calculate conditional probability a particular word will follow a given sequence of words
  weblmCalculateConditionalProbability(
    precedingWords,                 # ASCII only
    continuations,                  # ASCII only
    modelToUse = "title",           # "title"|"anchor"|"query"(default)|"body"
    orderOfNgram = 4L               # 1L|2L|3L|4L|5L(default)
  )
```

These functions return S3 class objects of the class `weblm`. The `weblm` object
exposes formatted results (in `data.frame` format), the REST API JSON response
(should you care), and the HTTP request (mostly for debugging purposes).

## Sample Code

The following code snippets illustrate how to use {mscsweblm4r} functions and
show what results they return with toy examples. If after reviewing this code
there is still confusion regarding how and when to use each function, please
refer to the [original documentation](https://www.microsoft.com/cognitive-services/en-us/web-language-model-api/documentation).

### List Available Models function


```r
tryCatch({

  # Retrieve a list of supported web language models
  weblmListAvailableModels()

}, error = function(err) {

 # Print error
 geterrmessage()

})
#> weblm [https://api.projectoxford.ai/text/weblm/v1.0/models]
#> 
#> -------------------------------------------------
#>             corpus              model   maxOrder 
#> ------------------------------ ------- ----------
#>    bing webpage title text      title      5     
#>            2013-12                               
#> 
#> bing webpage body text 2013-12  body       5     
#> 
#>  bing web query text 2013-12    query      5     
#> 
#>    bing webpage anchor text    anchor      5     
#>            2013-12                               
#> -------------------------------------------------
#> 
#> Table: Table continues below
#> 
#>  
#> -------------------------------------------------------------
#>  calculateJointProbability   calculateConditionalProbability 
#> --------------------------- ---------------------------------
#>          supported                      supported            
#> 
#>          supported                      supported            
#> 
#>          supported                      supported            
#> 
#>          supported                      supported            
#> -------------------------------------------------------------
#> 
#> Table: Table continues below
#> 
#>  
#> ------------------------------------
#>  generateNextWords   breakIntoWords 
#> ------------------- ----------------
#>      supported         supported    
#> 
#>      supported         supported    
#> 
#>      supported         supported    
#> 
#>      supported         supported    
#> ------------------------------------
```

### Break Into Words function


```r
tryCatch({

  # Break a sentence into words
  weblmBreakIntoWords(
    textToBreak = "testforwordbreak", # ASCII only
    modelToUse = "body",              # "title"|"anchor"|"query"(default)|"body"
    orderOfNgram = 5L,                # 1L|2L|3L|4L|5L(default)
    maxNumOfCandidatesReturned = 5L   # Default: 5L
  )

}, error = function(err) {

  # Print error
  geterrmessage()

})
#> weblm [https://api.projectoxford.ai/text/weblm/v1.0/breakIntoWords?model=body&text=testforwordbreak&order=5&maxNumOfCandidatesReturned=5]
#> 
#> ---------------------------------
#>        words         probability 
#> ------------------- -------------
#> test for word break    -13.83    
#> 
#> test for wordbreak     -14.63    
#> 
#> testfor word break     -15.94    
#> 
#> test forword break     -16.72    
#> 
#>  testfor wordbreak     -17.41    
#> ---------------------------------
```

### Generate Next Word function


```r
tryCatch({

  # Generate next words
  weblmGenerateNextWords(
    precedingWords = "how are you",  # ASCII only
    modelToUse = "title",            # "title"|"anchor"|"query"(default)|"body"
    orderOfNgram = 4L,               # 1L|2L|3L|4L|5L(default)
    maxNumOfCandidatesReturned = 5L  # Default: 5L
  )

}, error = function(err) {

  # Print error
  geterrmessage()

})
#> weblm [https://api.projectoxford.ai/text/weblm/v1.0/generateNextWords?model=title&words=how%20are%20you&order=4&maxNumOfCandidatesReturned=5]
#> 
#> ---------------------
#>  word    probability 
#> ------- -------------
#>  doing     -1.105    
#> 
#>   in       -1.239    
#> 
#> feeling    -1.249    
#> 
#>  going     -1.378    
#> 
#>  today      -1.43    
#> ---------------------
```

### Calculate Joint Probability function


```r
tryCatch({

  # Calculate joint probability a particular sequence of words will appear together
  weblmCalculateJointProbability(
    inputWords = c("where", "is", "San", "Francisco", "where is",
                   "San Francisco", "where is San Francisco"),  # ASCII only
    modelToUse = "query",                     # "title"|"anchor"|"query"(default)|"body"
    orderOfNgram = 4L                         # 1L|2L|3L|4L|5L(default)
  )

}, error = function(err) {

  # Print error
  geterrmessage()

})
#> weblm [https://api.projectoxford.ai/text/weblm/v1.0/calculateJointProbability?model=query&order=4]
#> 
#> ------------------------------------
#>         words           probability 
#> ---------------------- -------------
#>         where             -3.378    
#> 
#>           is              -2.607    
#> 
#>          san              -3.292    
#> 
#>       francisco           -4.051    
#> 
#>        where is           -3.961    
#> 
#>     san francisco         -4.086    
#> 
#> where is san francisco    -7.998    
#> ------------------------------------
```

### Calculate Conditional Probability function


```r
tryCatch({

  # Calculate conditional probability a particular word will follow a given sequence of words
  weblmCalculateConditionalProbability(
    precedingWords = "hello world wide",       # ASCII only
    continuations = c("web", "range", "open"), # ASCII only
    modelToUse = "title",                      # "title"|"anchor"|"query"(default)|"body"
    orderOfNgram = 4L                          # 1L|2L|3L|4L|5L(default)
  )

}, error = function(err) {

  # Print error
  geterrmessage()

})
#> weblm [https://api.projectoxford.ai/text/weblm/v1.0/calculateConditionalProbability?model=title&order=4]
#> 
#> -------------------------------------
#>      words        word   probability 
#> ---------------- ------ -------------
#> hello world wide  web       -0.32    
#> 
#> hello world wide range     -2.403    
#> 
#> hello world wide  open      -2.97    
#> -------------------------------------
```
